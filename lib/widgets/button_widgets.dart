import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:yeah/Theme/constants.dart';
import 'package:yeah/widgets/text_widgets.dart';


class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 60.w,
        height: 7.h,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFF2F5FF),
              Color(0xFFE5EDF8),
              Color(0xFFECECEC),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Color(0xFFDE60A1),
              offset: Offset(1, 1),
              spreadRadius: 1,

            )
          ],
        ),
        child: Center(
          child: Text(
            text,style: GoogleFonts.overlock(
              fontSize: 18.sp,
              color: Color(0xFFE50277),
              fontWeight: FontWeight.w600),
          ),
        )
    );
  }
}


class GradientButton extends StatelessWidget {
  String text;
  GradientButton({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment:
      Alignment.center,
      height: 7.h,
      width: 40.w,
      decoration:
      BoxDecoration(
        gradient: buttonGradient,
        borderRadius:
        BorderRadius
            .circular(30),
      ),
      child:
        H3Heading(text: "Log In",),

    );
  }
}