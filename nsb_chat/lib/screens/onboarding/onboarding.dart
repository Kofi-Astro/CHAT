import 'dart:async';

import 'package:flutter/material.dart';

import '../home/home.dart';
import '../login/login.dart';
import '../../utils/custom_shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  void verifyUserLoggedInAndRedirect() async {
    String routeName = HomeScreen.routeName;
    String? token = await CustomSharedPreferences.get('token');
    if (token == null) {
      routeName = LoginScreen.routeName;
    }
    Timer.run(() {
      // In case user is already logged in, go to home screen
      // otherwise, go to login screen

      Navigator.of(context).pushReplacementNamed(routeName);
    });
  }

  @override
  void initState() {
    super.initState();

    verifyUserLoggedInAndRedirect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[600]!.withOpacity(0.65),
      body: Container(
        // color: Colors.blue,

        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/nsb_logo.png',
              height: MediaQuery.of(context).size.height * 0.30,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text('NSB CHAT')
          ],
        )),
      ),
    );
  }
}
