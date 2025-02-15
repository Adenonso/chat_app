import 'package:chat_app/auth/auth_gate.dart';
import 'package:chat_app/screens/home_screen.dart';
import 'package:chat_app/screens/loginPage.dart';
import 'package:chat_app/screens/main_screen.dart';
import 'package:chat_app/screens/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

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
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: AuthGate(),
      routes: {
        '/loginPage': (context) => Loginpage(),
        '/main_screen': (context) => MainScreen(),
        '/register': (context) => Register(),
      },
    );
  }
}
