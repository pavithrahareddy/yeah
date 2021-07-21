import 'package:flutter/material.dart';
import 'package:yeah/authentication/landing.dart';
import 'package:yeah/authentication/login.dart';
import 'package:yeah/authentication/register.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(
        builder: (context, orientation, deviceType){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: RegisterScreen.id,
            routes: {
              LoginScreen.id: (context) => LoginScreen(),
              RegisterScreen.id: (context) => RegisterScreen(),
              LandingScreen.id: (context) => LandingScreen(),
            },
          );
        }
    );
  }
}


