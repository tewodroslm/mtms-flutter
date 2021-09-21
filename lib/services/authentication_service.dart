import 'package:shared_preferences/shared_preferences.dart';
import 'package:observable_ish/observable_ish.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:dio/dio.dart';

import '../app/http_client.dart';
import '../models/auth_response.dart';

@injectable
class AuthenticationService with ReactiveServiceMixin {
  final Future<SharedPreferences> _localStorage =
      SharedPreferences.getInstance();

  AuthenticationService() {
    listenToReactiveValues([_token]);
    getToken();
  }

  /// @return [String] token
  final RxValue<String> _token = RxValue<String>("");
  String get token => _token.value;
  bool get loggedIn => _token.value.isNotEmpty ? true : false;

  final RxValue<bool> _tokenval = RxValue<bool>(false);
  bool get tokenva => _tokenval.value;
  // /// @return [User] user
  // RxValue<User> _user = RxValue<User>(initial: null);
  // User get user => _user.value;

  static const authTokenKey = 'auth.token';

  /// Login with licence and password.
  ///
  /// @param credentials A map containing licence and password
  /// @return void
  Future loginWithLicence({
    required String licence,
    required String password,
  }) async {
    try {
      print('[AuthService] Logging in...');
      //https: //damp-coast-22655.herokuapp.com/api/login-driver
      Response response = await dio.post(
        '/api/login-driver',
        data: {
          "licence": licence,
          "password": password,
        },
      );

      AuthenticationResponse data =
          AuthenticationResponse.fromJson(response.data);
      print("Api returned this ==================== ** ");
      print(data.access_token);

      _token.value = data.access_token;
      setToken(data.access_token);
      // await fetchUser();
      getToken();
      print('[AuthService] Logged in');

      return response;
    } on DioError catch (e) {
      handleError(e);
    }
  }

  /// Fetch the current authenticated user.
  ///
  // /// @return void
  // Future fetchUser() async {
  //   try {
  //     Response response = await dio.get(
  //       '/api/auth/user',
  //       options: authorizationHeader,
  //     );

  //     User data = User.fromJson(response.data);
  //     _user.value = data;
  //   } on DioError catch (e) {
  //     handleError(e);
  //   }
  // }

  /// Logs out the user.
  ///
  /// @return void
  // Future logout() async {
  //   try {
  //     // await dio.get(
  //     //   '/api/logout',
  //     //   options: authorizationHeader,
  //     // );

  //     deleteToken();
  //     // _user.value = User(id: 0);
  //   } on DioError catch (e) {
  //     handleError(e);
  //   }
  // }

  /// Use the authorization header with Bearer token.
  ///
  /// @return [Options]
  Options get authorizationHeader {
    return Options(
      headers: {
        "Authorization": "Bearer ${_token.value}",
        "accept": "application/json",
      },
    );
  }

  /// Sets the authentication token in the state and also locally
  /// using [SharedPreferences]
  ///
  /// @param string [token]
  /// @return void
  void setToken(String token) async {
    final SharedPreferences localStorage = await _localStorage;
    _token.value = token;
    localStorage.setString(authTokenKey, token);
  }

  void getToken() async {
    final SharedPreferences locl = await _localStorage;
    if (locl.containsKey(authTokenKey)) {
      _tokenval.value = true;
    } else {
      _tokenval.value = false;
    }
  }

  /// Destroy the auth token from state and in [SharedPreferences]
  ///
  /// @return void
  void deleteToken() async {
    final SharedPreferences localStorage = await _localStorage;
    _token.value = "";
    localStorage.remove(authTokenKey);
  }

  /// A callback function receiving [DioError] as first parameter
  /// then handles the error based on status code given from response.
  ///
  /// @return void
  void handleError(DioError error) {
    switch (error.response?.statusCode) {
      case 403:
        print("You do not have the right privileges to access this resource.");
        break;
      case 422:
        print("The data you have provided is invalid.");
        break;
      case 401:
        print("Incorrect credentials.");
        break;
      case 404:
        print("Request not found.");
        break;
      case 500:
        print(
            "There is something wrong with our servers, please report to the admin so it gets fixed.");
        break;
      default:
        print("Something went wrong.");
    }
  }
}
