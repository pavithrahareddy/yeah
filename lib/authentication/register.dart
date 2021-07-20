import 'package:flutter/material.dart';
import 'package:yeah/Theme/constants.dart';
import 'package:sizer/sizer.dart';

class RegisterScreen extends StatefulWidget {
  static const String id = 'register_screen';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            backgroundTheme,
            Container(
              height: 80.h,
              width: 80.w,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.all(Radius.circular(30))
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Morse \nChat",textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 30.sp),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
