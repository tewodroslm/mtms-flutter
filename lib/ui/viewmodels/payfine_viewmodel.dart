import 'package:stacked/stacked.dart';

import '../../../app/locator.dart';
import '../../../services/authentication_service.dart'
    show AuthenticationService;

class PayFineViewModel extends ReactiveViewModel {
  PayFineViewModel() {
    print("buy ticket view model loaded! ");
  }
  final _authService = locator<AuthenticationService>();

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_authService];

  payFine(
      {required String token,
      required int driverid,
      required int amount,
      required String bankaccount}) async {
    setBusy(true);

    await _authService.payFine(
        token: token,
        driverid: driverid,
        amount: amount,
        bankaccount: bankaccount);

    setBusy(false);
  }
}
//  'amount' => 'integer',
//             'driver_id' => 'integer',
//             'bank_account' => 'string'
