import 'package:flutter/material.dart';
import 'package:flutter_morse_util/morse_util.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sizer/sizer.dart';
import 'package:yeah/Theme/constants.dart';
import 'package:yeah/widgets/button_widgets.dart';
import 'package:flutter_mobile_vision_2/flutter_mobile_vision_2.dart';

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
              GestureDetector(
                onTap: () {
                  print(inputController.text);
                },
                child: Container(
                  height: 25.h,
                  width: 50.w,
                  decoration: BoxDecoration(
                      gradient: appBarGradient,
                      borderRadius: BorderRadius.circular(50)),
                  child: Icon(
                    Icons.qr_code_scanner_sharp,
                    size: 20.h,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              GestureDetector(
                onTap: () async {
                  print("pressed");
                  await _read();
                  print(inputController.text);
                },
                child: GradientButton(
                  text: "yahoo",
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Container(
                width: 80.w,
                height: 20.h,
                padding: EdgeInsets.all(5.w),
                decoration: inputBoxDecoration,
                child: TextField(
                  minLines: 100,
                  controller: inputController,
                  maxLines: null,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                       hintText: 'Type your text here'),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: MaterialButton(
                      elevation: 5,
                      color: Colors.blue,
                      textColor: Colors.white,
                      splashColor: Colors.deepPurpleAccent,
//              padding: EdgeInsets.all(15),
                      child: Text(
                        'encode)',
                        style: TextStyle(fontSize: 12),
                      ),
                      onPressed: () {
                        morseEncode();
                      },
                    ),
                  ),
                  SizedBox(width: 30),
                  Expanded(
                    child: MaterialButton(
                      elevation: 5,
                      color: Colors.blue,
                      textColor: Colors.white,
                      splashColor: Colors.deepPurpleAccent,
                      child: Text(
                        'decode)',
                        style: TextStyle(fontSize: 12),
                      ),
                      onPressed: () {
                        morseDecode();
                      },
                    ),
                  ),

                ],
              )
            ],
          ),
        ),);
  }

  ///摩尔斯电码输入框
  Widget _inputWidget() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      margin: EdgeInsets.only(bottom: 20),
      child: TextField(
        minLines: 100,
//        autofocus: true,
        controller: inputController,
        maxLines: null,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
            border: OutlineInputBorder(), hintText: '请输入摩尔斯电码/中文'),
      ),
    );
  }

  ///编码/解码功能按钮
  Widget _decodeBtnWidget() {
    return Container(
      width: 100,
      height: 60,
      margin: EdgeInsets.only(left: 30, right: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: MaterialButton(
              elevation: 5,
              color: Colors.blue,
              textColor: Colors.white,
              splashColor: Colors.deepPurpleAccent,
//              padding: EdgeInsets.all(15),
              child: Text(
                'encode)',
                style: TextStyle(fontSize: 12),
              ),
              onPressed: () {
                morseEncode();
              },
            ),
          ),
          SizedBox(width: 30),
          Expanded(
            child: MaterialButton(
              elevation: 5,
              color: Colors.blue,
              textColor: Colors.white,
              splashColor: Colors.deepPurpleAccent,
              child: Text(
                'decode)',
                style: TextStyle(fontSize: 12),
              ),
              onPressed: () {
                morseDecode();
              },
            ),
          ),
        ],
      ),
    );
  }

  ///在线编码/解码按钮
  Widget _netMorseBtnWidget() {
    return Container(
      width: 100,
      height: 60,
      margin: EdgeInsets.only(top: 10, left: 30, right: 30, bottom: 10),
      child: RaisedButton(
        elevation: 5,
        color: Colors.blue,
        textColor: Colors.white,
        splashColor: Colors.deepPurpleAccent,
        child: Text(
          '使用网络morse编/解码',
          style: TextStyle(fontSize: 12),
        ),
        onPressed: _launchURL,
      ),
    );
  }

  _launchURL() async {
    const url = 'https://tool.lu/morse';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  ///摩尔斯解码
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
