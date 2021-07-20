import 'package:flutter/material.dart';
import 'package:yeah/authentication/landing.dart';
import 'package:yeah/authentication/login.dart';
import 'package:yeah/authentication/register.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: LandingScreen.id,
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        RegisterScreen.id: (context) => RegisterScreen(),
        LandingScreen.id: (context) => LandingScreen(),
      },
    );
  }
}


