import 'package:flutter/material.dart';

import './login_controller.dart';
import '../../widgets/my_button.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginController _loginController;

  @override
  void initState() {
    super.initState();

    _loginController = LoginController(context: context);
  }

  @override
  void dispose() {
    _loginController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object?>(
        stream: _loginController.streamController.stream,
        builder: (context, snapshot) {
          return Scaffold(
            body: SafeArea(
                child: Container(
              child: ListView(children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        height: 150,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/images/nsb_logo.png',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextField(
                        cursorColor: Theme.of(context).primaryColor,
                        controller: _loginController.usernameController,
                        decoration: const InputDecoration(
                          labelText: 'Username',
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextField(
                        cursorColor: Theme.of(context).primaryColor,
                        controller: _loginController.passwordController,
                        decoration:
                            const InputDecoration(labelText: 'Password'),
                        onSubmitted: (_) {
                          _loginController.submitForm();
                        },
                        obscureText: true,
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      MyButton(
                        title: _loginController.formSubmitting
                            ? 'Logging in ....'
                            : 'Log in',
                        onTap: _loginController.submitForm,
                        disabled: !_loginController.isFormValid ||
                            _loginController.formSubmitting,
                      ),
                    ],
                  ),
                )
              ]),
            )),
          );
        });
  }
}
