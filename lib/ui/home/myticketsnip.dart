import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';
import 'package:mtms/ui/home/mainpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Retrieve Ticket from backend using the rest

class TicketSnip extends StatefulWidget {
  const TicketSnip({Key? key}) : super(key: key);

  @override
  State<TicketSnip> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<TicketSnip> {
  String? startingp;
  String? destination;
  String? createdat;

  @override
  void initState() {
    _checkTicket();
    super.initState();
  }

  void _checkTicket() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var stp = localStorage.getString('ticket.startingpoint');
    if (stp != null) {
      setState(() {
        startingp = stp;
        destination = localStorage.getString('ticket.destination');
        createdat = localStorage.getString('ticket.createdat');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 600,
      height: 600,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/flut2.jpg"), fit: BoxFit.fill)),
      padding: const EdgeInsets.all(32),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /*2*/
            Container(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                startingp ?? 'No ticket yet, Buy one.',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                destination ?? '...',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                createdat ?? '',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                destination == '' || destination == null
                    ? ""
                    : "Amount in birr 20",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton(
                child: startingp == null
                    ? const Text('Get Ticket')
                    : const Text('Cancel'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => startingp == null
                            ? const MainContentPage()
                            : const MainContentPage()),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
