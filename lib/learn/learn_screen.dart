import 'package:flutter/material.dart';
import 'package:flutter_morse_util/morse_util.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yeah/Theme/constants.dart';
import 'package:sizer/sizer.dart';
import 'package:yeah/widgets/text_widgets.dart';

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
      child: Aphabets(items: items, morseUtil: _morseUtil),
      );
  }
}

