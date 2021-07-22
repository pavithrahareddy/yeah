import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:yeah/Theme/constants.dart';
import 'package:yeah/widgets/button_widgets.dart';

class ScanScreen extends StatefulWidget {
  static const String id = 'scan_screen';

  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 100.w,
      height: 100.h,
      decoration: BoxDecoration(
          gradient: lightBackgroundTheme,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 25.h,
            width: 50.w,
            decoration: BoxDecoration(
                gradient: appBarGradient,
                borderRadius: BorderRadius.circular(50)
            ),
            child: Icon(Icons.qr_code_scanner_sharp,size: 20.h,color: Colors.white,),
          ),
          SizedBox(
            height: 5.h,
          ),
          ConstrainedBox(
            constraints: BoxConstraints.tightFor(width: 40.w, height: 7.h),
            child: ElevatedButton(onPressed: (){
            }, child: Text("Tap to Scan!",style: TextStyle(fontSize: 14.sp,color: Color(0xFFEC0DCE))),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                    )
                )
            ),),
          )
        ],
      )

    );
  }
}
