import 'package:flutter/material.dart';
import 'package:yeah/authentication/register.dart';

import 'login.dart';

class LandingScreen extends StatefulWidget {
  static const String id = 'landing_screen';

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF380CEA),
            Color(0xFF664AE2),
            Color(0xFFE300FF),
            Color(0xFFEC0DCE),
          ],
          stops: [0.1,0.4, 0.7, 0.9],
        ),
      ),
      child: Center(
        child: Container(
          height: 550.0,
          width: 270.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            //color: Color.fromRGBO(255, 255, 2555, 0.5),
            color: Colors.white70.withOpacity(0.2),
          ),
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
           Container(
           width: 25.0,
           height: 25.0,
           ),
          SizedBox(
            height: 5.0,
          ),
            Container(
              margin: const EdgeInsets.fromLTRB(30, 10, 30, 30),
              child: MaterialButton(
                height: 50.0,
                minWidth: 0,
                padding: EdgeInsets.all(1.0),
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                      side: BorderSide(color: Color(0xFFEA02B1),)
                ),
                textColor: Color(0xFFEA02B1),
                child: Text("LOGIN",
                style: TextStyle(
                  fontSize: 17,
                ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                },
              ),
            ),
             Container(
               margin: const EdgeInsets.fromLTRB(30, 10, 30, 30),
               child: MaterialButton(
                 height: 50.0,
                 minWidth: 0,
                 padding: EdgeInsets.all(1.0),
                 color: Colors.white,
                 shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(30.0),
                     side: BorderSide(color: Color(0xFFEA02B1),)
                 ),
                 textColor: Color(0xFFEA02B1),
                 child:  Text("REGISTER",
                   style: TextStyle(
                     fontSize: 17,
                   ),
                 ),
                 onPressed: () {
                   Navigator.pushNamed(context, RegisterScreen.id);
                 },
               ),
             ),
           ],
        ),
        ),
      ),
    );
  }
}
