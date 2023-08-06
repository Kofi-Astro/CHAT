import 'package:flutter/material.dart';

import './register_controller.dart';
import '../../widgets/my_button.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = '/register';

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  RegisterController? _registerController;

  @override
  void initState() {
    super.initState();
    _registerController = RegisterController(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object?>(
        stream: _registerController!.streamController.stream,
        builder: (context, snapshot) {
          return Scaffold(
            body: SafeArea(
              child: Container(
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            alignment: Alignment.centerLeft,
                            child: IconButton(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.all(0),
                              color: Colors.blue,
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const Text(
                            'Register',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            'Create an account',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(
                            height: 60,
                          ),
                          TextField(
                            cursorColor: Theme.of(context).primaryColor,
                            controller: _registerController!.emailController,
                            decoration:
                                const InputDecoration(labelText: 'Email'),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextField(
                            cursorColor: Theme.of(context).primaryColor,
                            controller: _registerController!.usernameController,
                            decoration:
                                const InputDecoration(labelText: 'Username'),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextField(
                            cursorColor: Theme.of(context).primaryColor,
                            controller: _registerController!.passwordController,
                            decoration:
                                const InputDecoration(labelText: 'Password'),
                            obscureText: true,
                          ),
                          const SizedBox(
                            height: 45,
                          ),
                          MyButton(
                            title: _registerController!.formSubmitting
                                ? 'REGISTERING ....'
                                : 'REGISTED',
                            onTap: _registerController!.submitForm,
                            disabled: !_registerController!.isFormValid ||
                                _registerController!.formSubmitting,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
