import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yeah/Theme/constants.dart';
import 'package:sizer/sizer.dart';
import 'package:yeah/authentication/login.dart';
import 'package:yeah/authentication/register.dart';
import 'package:yeah/widgets/button_widgets.dart';
import 'package:yeah/widgets/text_widgets.dart';

class LandScreen extends StatefulWidget {
  static const String id = 'land_screen';

  @override
  _LandScreenState createState() => _LandScreenState();
}

class _LandScreenState extends State<LandScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          backgroundTheme,
          Padding(
            padding: EdgeInsets.only(top: 2.h),
            child: Container(
              height: 80.h,
              width: 80.w,
              padding: EdgeInsets.all(5.w),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Logo(),
                  Image.asset(
                    "images/morse.png",
                    width: 40.w,
                    height: 40.w,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, LoginScreen.id);
                      },
                      child: CustomButton(
                        text: "Login",
                      )),
                  SizedBox(
                    height: 3.h,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RegisterScreen.id);
                      },
                      child: CustomButton(
                        text: "Register",
                      )),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
