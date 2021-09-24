import 'package:flutter/material.dart';
import 'package:mtms/models/ticket.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../app/http_client.dart';
import '../models/auth_response.dart';

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

  Future payFine(
      {required String token,
      required int driverid,
      required int amount,
      required String bankaccount}) async {
    try {
      print('Buying ticket');
      print('=====================');
      print('Amount is $token');
      print('=====================');
      dio.options.headers['Authorization'] = "Bearer $token";

      Response response = await dio.post('/api/pay-fine', data: {
        'amount': amount,
        'driver_id': driverid,
        'bank_account': bankaccount
      });
      print('=====================');
      print('Fine paid Successfuly');
      print('=====================');
      Fluttertoast.showToast(
          msg: 'Paid Successfuly',
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

    final SharedPreferences localStorage =
        await SharedPreferences.getInstance();

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

      localStorage.setString('ticket.startingpoint', data.starting_point);
      localStorage.setString('ticket.destination', data.destination);
      localStorage.setString('cost', data.amount);
      localStorage.setString('ticket.createdat', data.created_at);
      localStorage.setInt('ticket.canceled', data.canceled);
    } on DioError catch (e) {
      print(e.toString());
    }
  }

  ///Logs out the user.

  /// @return void
  Future logout() async {
    final SharedPreferences localStorage =
        await SharedPreferences.getInstance();

    try {
      localStorage.remove('authtoken');

      localStorage.remove("dname");
      localStorage.remove("did");
      localStorage.remove("dlicence");
      localStorage.remove("dwr");
      localStorage.remove("dcreatedat");
      localStorage.remove("dtype");
      localStorage.remove("dcaro");
    } on DioError catch (e) {
      print(e.toString());
    }
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
