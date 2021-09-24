import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/widgets.dart';
import 'package:mtms/ui/viewmodels/buyticket_viewmodel.dart';
// No ticket class

class GetTicket extends StatefulWidget {
  const GetTicket({Key? key}) : super(key: key);

  @override
  State<GetTicket> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<GetTicket> {
  @override
  void initState() {
    _getTokn();
    super.initState();
  }

  String dropdownValue1 = 'Addis';
  String dropdownValue2 = 'Bishoftu';

  List<String> st1 = <String>['Addis', 'Bishoftu', 'Adama', 'Bahir', 'Jima'];
  List<String> st2 = <String>['Bishoftu', 'Addis', 'Adama', 'Bahir', 'Jima'];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? token;
  int? _did;

  void _getTokn() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    setState(() {
      token = localStorage.getString('authtoken');
      _did = localStorage.getInt('did');
    });
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BuyTicketViewModel>.reactive(
        viewModelBuilder: () => BuyTicketViewModel(),
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
                      padding: const EdgeInsets.fromLTRB(16, 6, 16, 6),
                      height: 530.0,
                      width: 400,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        border: Border.all(color: Colors.black87, width: 0.001),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(18.0)),
                      ),
                      child: Column(children: [
                        Container(
                          // padding: const EdgeInsets.only(bottom: 8),
                          // padding: const EdgeInsets.fromLTRB(40, 0, 40, 8),
                          width: 300,
                          height: 50,
                          padding: const EdgeInsets.fromLTRB(40, 0, 40, 8),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.white10, width: 0.2),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8.0)),
                          ),
                          child: const Text(
                            "Buy ticket here",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.black54,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /*2*/

                              const SizedBox(height: 4),
                              Container(
                                color: Colors.indigoAccent,
                                width: 300,
                                height: 1,
                              ),
                              const SizedBox(height: 44),
                              Container(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: const Text(
                                  "Starting from",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                              DropdownButton<String>(
                                value: dropdownValue1,
                                icon: const Icon(Icons.arrow_downward),
                                iconSize: 24,
                                elevation: 16,
                                style:
                                    const TextStyle(color: Colors.deepPurple),
                                hint: const Text(
                                  "Please choose Starting place ",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                underline: Container(
                                  height: 2,
                                  color: Colors.deepPurpleAccent,
                                ),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownValue1 = newValue!;
                                  });
                                },
                                items: <String>[
                                  'Addis',
                                  'Bishoftu',
                                  'Adama',
                                  'Bahir',
                                  'Jima'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                              const SizedBox(height: 44),
                              Container(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: const Text(
                                  "Destination",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              DropdownButton<String>(
                                value: dropdownValue2,
                                icon: const Icon(Icons.arrow_downward),
                                iconSize: 24,
                                elevation: 16,
                                style:
                                    const TextStyle(color: Colors.deepPurple),
                                hint: const Text(
                                  "Please choose Starting place ",
                                  style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                underline: Container(
                                  height: 2,
                                  color: Colors.deepPurpleAccent,
                                ),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownValue2 = newValue!;
                                  });
                                },
                                items: <String>[
                                  'Bishoftu',
                                  'Addis',
                                  'Adama',
                                  'Bahir',
                                  'Jima'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                              const SizedBox(height: 44),
                              Container(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: const Text(
                                  "Amount in birr 20",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30),
                              !model.isBusy
                                  ? ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          textStyle:
                                              const TextStyle(fontSize: 20),
                                          shadowColor: Colors.green),
                                      child: const Text('Buy ticket'),
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          model.buy(
                                              token: token ?? '',
                                              driverid: _did ?? 0,
                                              startingpoint: dropdownValue1,
                                              destination: dropdownValue2,
                                              amount: 20,
                                              canceled: 0);
                                        }
                                      },
                                    )
                                  : const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                            ],
                          ),
                        )
                      ]),
                    ),
                  ),
                ),
              ),
            ));
  }
}
