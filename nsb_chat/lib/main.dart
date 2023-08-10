import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import './theme.dart';
import '../screens/contact/contact.dart';
import 'package:provider/provider.dart';

import './screens/home/home.dart';
import './screens/login/login.dart';
import './screens/onboarding/onboarding.dart';
import './screens/register/register.dart';
import './screens/add_chat/add_chat.dart';
import './data/providers/chats_provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // FlutterStatusbarcolor.setStatusBarColor(Colors.blueAccent);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
      ),
    );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChatsProvider()),
      ],
      child: MaterialApp(
        title: 'Chat App',
        debugShowCheckedModeBanner: false,
        theme: lightTheme(context),
        // darkTheme: darkTheme(context),
        initialRoute: '/',
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/':
              return CupertinoPageRoute(
                  builder: (_) => const OnboardingScreen(), settings: settings);
            case '/login':
              return CupertinoPageRoute(
                  builder: (_) => const LoginScreen(), settings: settings);

            case '/register':
              return CupertinoPageRoute(
                  builder: (_) => const RegisterScreen(), settings: settings);
            case '/home':
              return CupertinoPageRoute(
                  builder: (_) => const HomeScreen(), settings: settings);
            case '/contact':
              return CupertinoPageRoute(
                  builder: (_) => const ContactScreen(), settings: settings);

            case '/add-chat':
              return CupertinoPageRoute(
                  builder: (_) => const AddChatScreen(), settings: settings);

            default:
              return CupertinoPageRoute(
                  builder: (_) => const OnboardingScreen(), settings: settings);
          }
        },
      ),
    );
  }
}
