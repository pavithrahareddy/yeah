import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yeah/authentication/land.dart';
import 'package:yeah/authentication/login.dart';
import 'package:yeah/authentication/register.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:yeah/chats/chat_screen.dart';
import 'package:yeah/chats/chatrooms.dart';
import 'package:yeah/chats/search_list.dart';
import 'package:yeah/home/home_screen.dart';
import 'package:yeah/learn/learn_screen.dart';
import 'package:yeah/scanner/scan_screen.dart';

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
            initialRoute: FirebaseAuth.instance.currentUser == null? LandScreen.id : HomeScreen.id,
            theme: ThemeData(
              primaryColor: Color(0xFFEC0DCE),
            ),
            routes: {
              LoginScreen.id: (context) => LoginScreen(),
              RegisterScreen.id: (context) => RegisterScreen(),
              LandScreen.id: (context) => LandScreen(),
              HomeScreen.id: (context) => HomeScreen(),
              ScanScreen.id: (context) => ScanScreen(),
              LearnScreen.id: (context) => LearnScreen(),
              SearchList.id: (context) => SearchList(),
              ChatScreen.id: (context) => ChatScreen("","","",""),
              ChatRooms.id: (context) => ChatRooms()
            },
          );
        }
    );
  }
}


