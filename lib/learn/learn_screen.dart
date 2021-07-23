import 'package:flutter/material.dart';
import 'package:flutter_morse_util/morse_util.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yeah/Theme/constants.dart';
import 'package:sizer/sizer.dart';

class LearnScreen extends StatefulWidget {
  static const String id = 'learn_screen';

  @override
  _LearnScreenState createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen> {
  List<String> items = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","0","1","2","3","4","5","6","7","8","9"];

  MorseUtil _morseUtil = MorseUtil();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(1.w),
      decoration: BoxDecoration(gradient: lightBackgroundTheme),
      child: GridView.count(
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
        ),
      );
  }
}
