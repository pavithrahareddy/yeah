import 'package:flutter/material.dart';
import 'package:flutter_morse_util/morse_util.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class Logo extends StatelessWidget {
  const Logo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "Morsogram",
      textAlign: TextAlign.center,
      style: GoogleFonts.bilbo(
        fontSize: 56.sp,
        color: Colors.white,
        fontWeight: FontWeight.w900,
      ),
    );
  }
}

class SmallLogo extends StatelessWidget {
  const SmallLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "Morsogram",
      textAlign: TextAlign.center,
      style: GoogleFonts.bilbo(
        fontSize: 30.sp,
        color: Colors.white,
        fontWeight: FontWeight.w900,
      ),
    );
  }
}

class H3Heading extends StatelessWidget {
  const H3Heading({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.overlock(
        fontSize: 16.sp,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class H4Heading extends StatelessWidget {
  const H4Heading({
    required this.text,
    Key? key,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: GoogleFonts.overlock(
          fontSize: 14.sp,
          color: Colors.white,
          fontWeight: FontWeight.w600),
    );
  }
}

class H5Heading extends StatelessWidget {
  const H5Heading({
    required this.text,
    Key? key,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: GoogleFonts.overlock(
          fontSize: 12.sp,
          color: Colors.white,
          fontWeight: FontWeight.w600),
    );
  }
}


class Aphabets extends StatelessWidget {
  const Aphabets({
    Key? key,
    required this.items,
    required MorseUtil morseUtil,
  }) : _morseUtil = morseUtil, super(key: key);

  final List<String> items;
  final MorseUtil _morseUtil;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      mainAxisSpacing: 10.0,
      crossAxisSpacing: 10.0,
      crossAxisCount: 3 ,
      children:  List.generate(36,(index){
        return Card(
            elevation: 10,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
            color: Colors.white,
            child: Container(
              padding: EdgeInsets.all(2.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(items[index],style: GoogleFonts.overlock(
                    fontSize: 25.sp,
                    color: Color(0xFFD70988),
                    fontWeight: FontWeight.w600,
                  ),),
                  Text(_morseUtil.encode(items[index]),textAlign:TextAlign.center,style: GoogleFonts.overlock(
                    fontSize: 35.sp,
                    color: Color(0xFF0C5DD7),
                    fontWeight: FontWeight.bold,
                  ),),
                ],
              ),
            )
        );
      }),
    );
  }
}