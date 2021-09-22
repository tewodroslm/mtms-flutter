import 'package:flutter/material.dart';
import 'package:mtms/ui/home/mainpage.dart';
import 'package:flutter/widgets.dart';
// No ticket class

class NoTicketPage extends StatefulWidget {
  const NoTicketPage({Key? key}) : super(key: key);

  @override
  State<NoTicketPage> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<NoTicketPage> {
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
              "Get ticket! You haven't bought ticket.",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ElevatedButton(
              child: const Text('Get Ticket'),
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
