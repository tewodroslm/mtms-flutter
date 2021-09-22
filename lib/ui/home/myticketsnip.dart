import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';
import 'package:mtms/ui/home/mainpage.dart';

// Retrieve Ticket from backend using the rest

class TicketSnip extends StatefulWidget {
  const TicketSnip({Key? key}) : super(key: key);

  @override
  State<TicketSnip> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<TicketSnip> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.indigo,
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /*2*/
          Container(
            padding: const EdgeInsets.only(bottom: 8),
            child: const Text(
              "From Addis To DeberZeit",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 8),
            child: const Text(
              "Time 2:00 pm",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 8),
            child: const Text(
              "Amount 20",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ElevatedButton(
              child: const Text('Cancle Ticket'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MainContentPage()),
                );
              }),
        ],
      ),
    );
  }
}
