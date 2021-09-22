import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';
// No ticket class

class GetTicket extends StatefulWidget {
  const GetTicket({Key? key}) : super(key: key);

  @override
  State<GetTicket> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<GetTicket> {
  String dropdownValue1 = 'Addis';
  String dropdownValue2 = 'Bishoftu';

  List<String> st1 = <String>['Addis', 'Bishoftu', 'Adama', 'Bahir', 'Jima'];
  List<String> st2 = <String>['Bishoftu', 'Addis', 'Adama', 'Bahir', 'Jima'];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      color: Colors.indigo,
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
          _dDown(1, st1),
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
          _dDown(2, st2),
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
          ElevatedButton(
              child: const Text('Buy Ticket'),
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => SecondRoute()),
                // );
              }),
        ],
      ),
    );
  }

  DropdownButton _dDown(int dd, List<String> xss) {
    if (dropdownValue1 == dropdownValue2) {
      print("You Cant have THE SaMe ########");
    }

    return DropdownButton<String>(
      value: dd == 1 ? dropdownValue1 : dropdownValue2,
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
          if (dd == 1) {
            dropdownValue1 = newValue!;
          }
          dropdownValue2 = newValue!;
        });
      },
      items: xss.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}


//  'starting_point' => 'required|string',
//             'destination' => 'required|string',
//             'amount' => 'required',
//             'driver_id' => 'required|integer',
//             'canceled' => 'required'