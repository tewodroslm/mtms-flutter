import 'package:stacked/stacked.dart';

import '../../../app/locator.dart';
import '../../../services/authentication_service.dart'
    show AuthenticationService;

class BuyTicketViewModel extends ReactiveViewModel {
  BuyTicketViewModel() {
    print("buy ticket view model loaded! ");
  }
  final _authService = locator<AuthenticationService>();

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_authService];

  buy(
      {required String token,
      required int driverid,
      required String startingpoint,
      required String destination,
      required int amount,
      required int canceled}) async {
    if (startingpoint == destination) {
      print("Staring point and destination are the same");
    }
    setBusy(true);

    await _authService.getTicket(
        token: token,
        driverid: driverid,
        startingpoint: startingpoint,
        destination: destination,
        amount: amount,
        canceled: canceled);

    setBusy(false);
  }
}
