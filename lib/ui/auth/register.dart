import 'package:flutter/material.dart';
import 'package:mtms/ui/auth/login_reg.dart';
import 'package:mtms/ui/home/myticketsnip.dart';
import 'package:stacked/stacked.dart';
import './login_regviewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String workingroute = 'Addis';
  String dereja = '1';
  String owner = 'yes';
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
        viewModelBuilder: () => HomeViewModel(),
        builder: (context, model, child) => SafeArea(
              child: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/flut2.jpg"),
                        fit: BoxFit.fitHeight)),
                child: Center(
                  child: Scaffold(
                    appBar: AppBar(
                      title: const Text('Register here'),
                      centerTitle: true,
                      backgroundColor: Colors.white24,
                      automaticallyImplyLeading: false,
                    ),
                    backgroundColor: Colors.white24,
                    body: _registrationWidget(model, context),
                  ),
                ),
              ),
            ));
  }

  final _licenceController = TextEditingController(text: 'driver112');
  final _passwordController = TextEditingController(text: 'password');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Container _registrationWidget(HomeViewModel model, BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(30),
      width: 400,
      height: 600,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _licenceController,
              decoration: const InputDecoration(
                labelText: 'LIcence',
                border: OutlineInputBorder(),
              ),
              validator: (value) =>
                  value!.isEmpty ? 'This field is required' : null,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _licenceController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
              validator: (value) =>
                  value!.isEmpty ? 'This field is required' : null,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text('Working route'),
                const SizedBox(width: 30),
                DropdownButton<String>(
                  value: workingroute,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
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
                      workingroute = newValue!;
                    });
                  },
                  items: <String>['Addis', 'Bishoftu', 'Adama', 'Bahir', 'Jima']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text('Type or Dereja'),
                const SizedBox(width: 30),
                DropdownButton<String>(
                  value: dereja,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  hint: const Text(
                    "Please choose dereja ",
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
                      dereja = newValue!;
                    });
                  },
                  items: <String>[
                    '1',
                    '2',
                    '3',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text('I own the vehicle'),
            DropdownButton<String>(
              value: owner,
              icon: const Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: const TextStyle(color: Colors.deepPurple),
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
                  owner = newValue!;
                });
              },
              items: <String>[
                'yes',
                'no',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _licenceController,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              validator: (value) =>
                  value!.isEmpty ? 'This field is required' : null,
            ),
            const SizedBox(height: 10),
            TextFormField(
              obscureText: true,
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Confirm password',
                border: OutlineInputBorder(),
              ),
              validator: (value) =>
                  value!.isEmpty ? 'This field is required' : null,
            ),
            const SizedBox(height: 10),
            !model.isBusy
                ? ElevatedButton(
                    child: const Text('Register'),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        model.login(
                          licence: _licenceController.text,
                          password: _passwordController.text,
                        );
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) =>
                        //           _loggedInWidget(model, context)),
                        // );
                      }
                    },
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
            const SizedBox(height: 20),
            TextButton(
              child: const Text(
                'Login',
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CheckAuth()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
