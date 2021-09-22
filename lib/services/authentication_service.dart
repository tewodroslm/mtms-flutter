import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mtms/models/ticket.dart';
import 'package:mtms/ui/auth/login_reg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:observable_ish/observable_ish.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../app/http_client.dart';
import '../models/auth_response.dart';
import '../models/driver.dart';

@injectable
class AuthenticationService with ReactiveServiceMixin {
  AuthenticationService() {}

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
      Response response = await dio.post(
        '/api/login-driver',
        data: {
          "licence": licence,
          "password": password,
        },
      );
      final SharedPreferences localStorage =
          await SharedPreferences.getInstance();

      AuthenticationResponse data =
          AuthenticationResponse.fromJson(response.data);
      print("Api returned this ==================== ** ");
      print(data.access_token);

      localStorage.setString('authtoken', data.access_token);

      localStorage.setString("dname", data.driver.name);
      localStorage.setInt("did", data.driver.id);
      localStorage.setString("dlicence", data.driver.licence);
      localStorage.setString("dwr", data.driver.working_route);
      localStorage.setString("dcreatedat", data.driver.created_at);
      localStorage.setInt("dtype", data.driver.driver_type);
      localStorage.setInt("dcaro", data.driver.car_owner);

      print('[AuthService] Logged in');

      return response;
    } on DioError catch (e) {
      handleError(e);
    }
  }

  Future getTicket(
      {required String token,
      required int driverid,
      required String startingpoint,
      required String destination,
      required int amount,
      required int canceled}) async {
    print('------------ SP ---------------');
    print(startingpoint);
    print('------------ Dp ---------------');
    print(destination);
    print('------------ Am ---------------');
    print(amount);
    print('------------ Is Canceled ---------------');
    print(canceled);
    print('------------ Driver Id ---------------');
    print(driverid);
    print('---- token ____');
    print(token);
    print('------------ ENDND ---------------');

    try {
      print('Buying ticket');

      dio.options.headers['Authorization'] = "Bearer $token";

      Response response = await dio.post('/api/get-ticket', data: {
        'starting_point': startingpoint,
        'destination': destination,
        'amount': amount,
        'driver_id': driverid,
        'canceled': canceled
      });
      print("Inside of the Try catch");
      Ticket data = Ticket.fromJson(response.data);
      print("Api returned this ==================== ** ");
      print(data.starting_point);
      print(data.destination);
      Fluttertoast.showToast(
          msg: data.starting_point,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } on DioError catch (e) {
      print(e.toString());
    }
  }
  // "driver": {
  //   "id": 1,
  //   "name": "driver1",
  //   "licence": "driver111",
  //   "working_route": "Bishoftu",
  //   "driver_type": 1,
  //   "car_owner": null,
  //   "created_at": "2021-09-13T17:58:29.000000Z",
  //   "updated_at": "2021-09-13T17:58:29.000000Z"
  // },

  ///Logs out the user.

  /// @return void
  Future logout() async {
    try {
      // await dio.get(
      //   '/api/logout',
      //   options: authorizationHeader,
      // );

      deleteToken();
      // _user.value = User(id: 0);
    } on DioError catch (e) {
      print(e.toString());
    }
  }

  /// Use the authorization header with Bearer token.
  ///
  /// @return [Options]
  // Options get authorizationHeader {
  //   return Options(
  //     headers: {
  //       "Authorization": "Bearer ${_token.value}",
  //       "accept": "application/json",
  //     },
  //   );
  // }

  /// Destroy the auth token from state and in [SharedPreferences]
  ///
  /// @return void
  void deleteToken() async {
    // Fluttertoast.showToast(
    //     msg: localStorage.getString(authTokenKey) ?? '',
    //     toastLength: Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.CENTER,
    //     timeInSecForIosWeb: 1,
    //     backgroundColor: Colors.red,
    //     textColor: Colors.white,
    //     fontSize: 16.0);
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
