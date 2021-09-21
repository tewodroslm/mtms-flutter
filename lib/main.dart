import 'package:flutter/material.dart';
import 'package:mtms/app/locator.dart';
import 'package:mtms/ui/auth/login_reg.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'mtms',
      home: HomeView(),
    );
  }
}
