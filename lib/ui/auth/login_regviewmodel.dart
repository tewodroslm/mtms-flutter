import 'package:stacked/stacked.dart';

import '../../../app/locator.dart';
import '../../../services/authentication_service.dart'
    show AuthenticationService;

class HomeViewModel extends ReactiveViewModel {
  HomeViewModel() {
    print("Home view model loaded! ");
  }
  final _authService = locator<AuthenticationService>();

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_authService];

  login({
    required String licence,
    required String password,
  }) async {
    setBusy(true);

    print(licence);
    print(password);

    await _authService.loginWithLicence(
      licence: licence,
      password: password,
    );

    setBusy(false);
  }

  void logout() async {
    setBusy(true);

    await _authService.logout();

    setBusy(false);
  }
}
