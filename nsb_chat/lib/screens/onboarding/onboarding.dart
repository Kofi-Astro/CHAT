import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nsb_chat/data/local_database/db_provider.dart';
import 'package:nsb_chat/data/providers/chats_provider.dart';
import 'package:provider/provider.dart';

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
    DBProvider.db.createDatabase();

    verifyUserLoggedInAndRedirect();
  }

  @override
  void didChangeDependencies() {
    Provider.of<ChatsProvider>(context).updateChats();
    super.didChangeDependencies();
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
