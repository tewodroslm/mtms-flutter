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
        builder: (context, model, child) => SafeArea(
              child: Container(
                  padding: const EdgeInsets.all(32),
                  color: Colors.white38,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /*2*/
                        Container(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: const Text(
                            "Buy ticket here",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: const Text(
                            "Starting from",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DropdownButton<String>(
                          value: dropdownValue1,
                          icon: const Icon(Icons.arrow_downward),
                          iconSize: 24,
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple),
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
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: const Text(
                            "Destination",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DropdownButton<String>(
                          value: dropdownValue2,
                          icon: const Icon(Icons.arrow_downward),
                          iconSize: 24,
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple),
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
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: const Text(
                            "Amount 20",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        !model.isBusy
                            ? ElevatedButton(
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
                  )),
            ));
  }
}


//  'starting_point' => 'required|string',
//             'destination' => 'required|string',
//             'amount' => 'required',
//             'driver_id' => 'required|integer',   no need here
//             'canceled' => 'required'