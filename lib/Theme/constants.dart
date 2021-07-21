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

const buttonGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Color(0xFF380CEA),
    Color(0xFF664AE2),
    Color(0xFFE300FF),
    Color(0xFFEC0DCE),
  ],
  stops: [0.1,0.4, 0.7, 0.9],
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