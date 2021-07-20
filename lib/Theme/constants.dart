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
      stops: [0.1,0.4, 0.7, 0.9],
    ),
  ),
);