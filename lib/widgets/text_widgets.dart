import 'package:flutter/material.dart';
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