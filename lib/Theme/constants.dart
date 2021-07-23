import 'package:flutter/material.dart';

final backgroundTheme = Container(
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
      stops: [0.2,0.4, 0.6, 0.9],
    ),
  ),
);

final lightBackgroundTheme = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Color(0xFF0C5DD7).withOpacity(0.8),
    Color(0xFFEC0DCE).withOpacity(0.8),
  ],
);

const appBarGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color(0xFF1B52AF),
    Color(0xFFD70988),
  ],
);


const buttonGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color(0xFF2687EE),
    Color(0xFF237CDB),
    Color(0xFF2283CE),
  ],
);

const textInputDecoration = InputDecoration(
  border: InputBorder.none,
  focusedBorder: InputBorder.none,
  enabledBorder: InputBorder.none,
  errorBorder: InputBorder.none,
  disabledBorder: InputBorder.none,
  contentPadding: EdgeInsets.only(left: 15, top: 17, right: 15),
  hintStyle: TextStyle(
    color: Color(0xFFEA02B1),
  ),
  errorStyle: TextStyle(
    color: Color(0xFFEA02B1),
  ),
);

const inputBoxDecoration = BoxDecoration(
  borderRadius: BorderRadius.all(Radius.circular(30)),
  color: Color(0xFFFFFFFF),
);