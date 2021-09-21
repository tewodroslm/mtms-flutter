// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// /// This is the stateful widget that the main application instantiates.
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'package:flutter/widgets.dart';
import 'package:mtms/ui/auth/login_regviewmodel.dart';

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return const Text("Home");
  }
}
