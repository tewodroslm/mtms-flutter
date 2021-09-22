import 'package:flutter/material.dart';
import 'package:mtms/ui/home/myticketsnip.dart';
import 'package:stacked/stacked.dart';
import './login_regviewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Mtms.io',
      debugShowCheckedModeBanner: false,
      home: CheckAuth(),
    );
  }
}

class CheckAuth extends StatefulWidget {
  const CheckAuth({Key? key}) : super(key: key);

  @override
  _CheckAuthState createState() => _CheckAuthState();
}

class _CheckAuthState extends State<CheckAuth> {
  bool isAuth = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _licenceController = TextEditingController(text: 'driver112');
  final _passwordController = TextEditingController(text: 'password');
  @override
  void initState() {
    _checkIfLoggedIn();
    super.initState();
  }

  void _checkIfLoggedIn() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('authtoken');
    if (token != null) {
      setState(() {
        isAuth = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Home View'),
            centerTitle: true,
            backgroundColor: Colors.indigo,
          ),
          backgroundColor: Colors.indigo,
          body: SizedBox(
            width: double.infinity,
            child: Form(
              key: _formKey,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: isAuth
                      ? _loggedInWidget(model, context)
                      : _loginForm(model, context)),
            ),
          ),
        ),
      ),
    );
  }

  Column _loginForm(HomeViewModel model, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
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
          obscureText: true,
          controller: _passwordController,
          decoration: const InputDecoration(
            labelText: 'Password',
            border: OutlineInputBorder(),
          ),
          validator: (value) =>
              value!.isEmpty ? 'This field is required' : null,
        ),
        const SizedBox(height: 10),
        !model.isBusy
            ? ElevatedButton(
                child: const Text('Login'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    model.login(
                      licence: _licenceController.text,
                      password: _passwordController.text,
                    );
                    _loggedInWidget(model, context);
                  }
                },
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
        const SizedBox(height: 20),
        TextButton(
          onPressed: () {
            //action
          },
          child: const Text(
            'Register here', //title
            textAlign: TextAlign.end, //aligment
          ),
        ),
        Container(
            // child: Text(model.token),
            ),
      ],
    );
  }

  Column _loggedInWidget(HomeViewModel model, BuildContext context) {
    return Column(
      children: [
        // !model.isBusy
        //     ? ElevatedButton(
        //         child: const Text('Logout'),
        //         onPressed: () {
        //           // model.logout();
        //         },
        //       )
        //     : const Center(
        //         child: CircularProgressIndicator(),
        //       ),

        // When no ticket
        // NoTicketPage(),

        // When there is ticket
        const TicketSnip(),
        ElevatedButton(
          child: const Text('Log out!'),
          onPressed: () {
            model.logout();
            _loginForm(model, context);
          },
        ), // Text(model.token),
        Container(
            // child: Text(model.token),
            ),
      ],
    );
  }
}
