import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';

// Pay fine page

class PayFine extends StatefulWidget {
  const PayFine({Key? key}) : super(key: key);

  @override
  State<PayFine> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<PayFine> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /*2*/
          Container(
            padding: const EdgeInsets.only(bottom: 8),
            child: const Text(
              "Pay Fine",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Amount in br.',
              border: OutlineInputBorder(),
            ),
            validator: (value) =>
                value!.isEmpty ? 'This field is required' : null,
          ),
          const SizedBox(height: 10),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Account number',
              border: OutlineInputBorder(),
            ),
            validator: (value) =>
                value!.isEmpty ? 'This field is required' : null,
          ),
          const SizedBox(height: 10),
          ElevatedButton(
              child: const Text('Pay'),
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
}
//  'amount' => 'integer',
//             'driver_id' => 'integer',
//             'bank_account' => 'string'



