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

class Custom2Button extends StatelessWidget {
  const Custom2Button({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(width: 40.w, height: 7.h),
      child: ElevatedButton(onPressed: (){
      }, child: Text(text,style: TextStyle(fontSize: 14.sp,color: Color(0xFFEC0DCE))),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                )
            )
        ),),
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
        H3Heading(text: text,),

    );
  }
}


class ButtonText extends StatelessWidget {
  const ButtonText({
    Key? key,
    required this.iconText,
    required this.text,
  }) : super(key: key);

  final String iconText;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.center,
            height: 10.h,
            width: 20.w,
            decoration: BoxDecoration(
                gradient: appBarGradient,
                borderRadius: BorderRadius.circular(30)),
            child: Text(
              iconText,style: GoogleFonts.overlock(
              fontSize: 20.sp,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
            )
        ),
        H4Heading(text: text),
      ],
    );
  }
}

class ButtonIcon extends StatelessWidget {
  const ButtonIcon({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 10.h,
          width: 20.w,
          decoration: BoxDecoration(
              gradient: appBarGradient,
              borderRadius: BorderRadius.circular(30)),
          child: Icon(
            icon,
            size: 5.h,
            color: Colors.white,
          ),
        ),
        H4Heading(text: text),
      ],
    );
  }
}