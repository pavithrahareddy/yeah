import 'package:flutter/material.dart';
import 'package:flutter_morse_util/morse_util.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:yeah/Theme/constants.dart';
import 'package:yeah/widgets/button_widgets.dart';
import 'package:flutter_mobile_vision_2/flutter_mobile_vision_2.dart';
import 'package:yeah/widgets/text_widgets.dart';

class ScanScreen extends StatefulWidget {
  static const String id = 'scan_screen';

  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  TextEditingController inputController = TextEditingController();

  MorseUtil _morseUtil = MorseUtil();
  int _cameraOcr = FlutterMobileVision.CAMERA_BACK;

  Future<Null> _read() async {
    List<OcrText> texts = [];
    try {
      texts = await FlutterMobileVision.read(
          camera: _cameraOcr, waitTap: true, fps: 2.0);
        inputController.text = (texts[0].value);
    } on Exception {
      texts.add(new OcrText('Failed to recognize text.'));
    }
  }

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        width: 100.w,
        height: 100.h,
        padding: EdgeInsets.all(5.w),
        decoration: BoxDecoration(
          gradient: lightBackgroundTheme,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                      print("pressed");
                      await _read();
                      print(inputController.text);
                    },
                    child: ButtonIcon(icon: Icons.qr_code_scanner_sharp,text: "Scan",),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  GestureDetector(
                    onTap: () async {
                      morseEncode();
                    },
                      child: ButtonText(iconText: "-/.-./-",text: "Encode",)
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  GestureDetector(
                    onTap: () async {
                      morseDecode();
                    },
                    child: ButtonText(iconText: "AaBb",text: "Decode",)
                  ),
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              Container(
                width: 80.w,
                height: 40.h,
                padding: EdgeInsets.all(8.w),
                decoration: inputBoxDecoration,
                child: TextField(
                  minLines: 100,
                  controller: inputController,
                  maxLines: null,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                       hintText: 'Type your text here'),
                ),
              ),
            ],
          ),
        ),
    );
  }

  void morseDecode() {
    String decodeString = inputController.text;
    if ('' == decodeString) {
      Fluttertoast.showToast(msg: 'Please enter some text');
      return;
    }
    try {
      if (decodeString.startsWith(RegExp('-')) ||
          decodeString.startsWith(RegExp('.'))) {
        String decodeResult = _morseUtil.decode(decodeString);
        inputController.text = decodeResult;
      } else {
        int index_dit = decodeString.indexOf(RegExp('.'));
        int index_dah = decodeString.indexOf(RegExp('-'));
        if (index_dit == -1 || index_dah == -1) {
          inputController.text = '';
          return;
        }
        if (index_dit > index_dah) {
          String dahString = decodeString.substring(index_dah).trim();
          String dahResult = _morseUtil.decode(dahString);
          inputController.text = dahResult;
        } else {
          String ditString = decodeString.substring(index_dit).trim();
          String ditResult = _morseUtil.decode(ditString);
          inputController.text = ditResult;
        }
      }
    } catch (e) {
      print('Decoding Failed');
      inputController.text = '';
    }
  }

  void morseEncode() {
    print(inputController.text);
    String decodeString = inputController.text;
    if ('' == decodeString) {
      Fluttertoast.showToast(msg: "Please enter some text");

      return;
    }
    try {
      String encodeString = _morseUtil.encode(decodeString);
      inputController.text = encodeString;
    } catch (e) {
      print("Encoding failed");
      inputController.text = '';
    }
  }

}

