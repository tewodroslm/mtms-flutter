import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';
import 'package:mtms/ui/viewmodels/payfine_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/services.dart';

import 'package:shared_preferences/shared_preferences.dart';

// Pay fine page

class PayFine extends StatefulWidget {
  const PayFine({Key? key}) : super(key: key);

  @override
  State<PayFine> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<PayFine> {
  @override
  void initState() {
    _getTokn();
    super.initState();
  }

  String? token;
  int? _did;

  final _amountController = TextEditingController(text: '');
  final _bankAccountContorller = TextEditingController(text: '');

  void _getTokn() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    setState(() {
      token = localStorage.getString('authtoken');
      _did = localStorage.getInt('did');
    });
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PayFineViewModel>.reactive(
        viewModelBuilder: () => PayFineViewModel(),
        builder: (context, model, child) => Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/flut2.jpg"),
                    fit: BoxFit.fill)),
            child: Scaffold(
                backgroundColor: Colors.transparent,
                body: SafeArea(
                    child: Center(
                        child: Container(
                  padding: const EdgeInsets.all(46),
                  height: 380.0,
                  width: 500,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    border: Border.all(color: Colors.black87, width: 0.1),
                    borderRadius: const BorderRadius.all(Radius.circular(18.0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /*2*/
                      Container(
                        width: 300,
                        height: 50,
                        padding: const EdgeInsets.fromLTRB(40, 0, 40, 8),
                        margin: const EdgeInsets.fromLTRB(50, 0, 0, 0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.black26, width: 0.09),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8.0)),
                        ),
                        child: const Text(
                          "Pay Fine",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.black54,
                              fontStyle: FontStyle.italic),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 40),
                      TextFormField(
                        controller: _amountController,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: const InputDecoration(
                            labelText: 'Amount in br.',
                            border: OutlineInputBorder(),
                            hintText: '200'),
                        validator: (value) =>
                            value!.isEmpty ? 'This field is required' : null,
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _bankAccountContorller,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: const InputDecoration(
                            labelText: 'Account number',
                            border: OutlineInputBorder(),
                            hintText: '10002345677'),
                        validator: (value) =>
                            value!.isEmpty ? 'This field is required' : null,
                      ),
                      const SizedBox(height: 10),
                      !model.isBusy
                          ? ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  textStyle: const TextStyle(fontSize: 20),
                                  shadowColor: Colors.green),
                              child: const Text('Pay'),
                              onPressed: () {
                                model.payFine(
                                    token: token ?? '',
                                    driverid: _did ?? 0,
                                    amount: int.parse(_amountController.text),
                                    bankaccount: _bankAccountContorller.text);
                              })
                          : const Center(
                              child: CircularProgressIndicator(),
                            )
                    ],
                  ),
                ))))));
  }
}
