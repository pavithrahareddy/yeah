import 'package:flutter/material.dart';
import 'package:yeah/Theme/constants.dart';
import 'package:yeah/widgets/text_widgets.dart';
import 'package:sizer/sizer.dart';

class morsoBar extends StatelessWidget {
  const morsoBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 5,
      centerTitle: true,
      title: Padding(
          padding:EdgeInsets.only(top: 1.5.h),child: SmallLogo()),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: appBarGradient,
        ),
      ),
    );
  }
}