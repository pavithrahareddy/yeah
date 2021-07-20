import 'package:flutter/material.dart';

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
          width: 250.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            //color: Color.fromRGBO(255, 255, 2555, 0.5),
            color: Colors.white70.withOpacity(0.2),
          ),





          ),
        ),
      );

  }
}
