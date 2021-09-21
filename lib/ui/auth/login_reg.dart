import 'package:flutter/material.dart';
import 'package:mtms/ui/home/home.dart';
import 'package:stacked/stacked.dart';
import './login_regviewmodel.dart';

class HomeView extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _licenceController = TextEditingController(text: 'driver112');
  final _passwordController = TextEditingController(text: 'password');

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Home View'),
            centerTitle: true,
          ),
          body: SizedBox(
            width: double.infinity,
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    model.tokenval ? _loginForm(model) : _loggedInWidget(model),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column _loggedInWidget(HomeViewModel model) {
    return Column(
      children: [
        !model.isBusy
            ? ElevatedButton(
                child: const Text('Logout'),
                onPressed: () {
                  // model.logout();
                },
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
        const MyStatefulWidget(),
        // Text(model.token),
      ],
    );
  }

  Column _loginForm(HomeViewModel model) {
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
                  }
                },
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ],
    );
  }
}
