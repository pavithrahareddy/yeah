import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:yeah/Theme/constants.dart';
import 'package:sizer/sizer.dart';
import 'package:yeah/authentication/register.dart';
import 'package:yeah/widgets/button_widgets.dart';
import 'package:yeah/widgets/input_widgets.dart';
import 'package:yeah/widgets/text_widgets.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  final _formKey = GlobalKey<FormState>();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool _passwordVisible = false;




  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  void passwordVisibility() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.center,
        children: [
          backgroundTheme,
          Padding(
            padding: EdgeInsets.only(top: 2.h),
            child: Container(
              height: 80.h,
              width: 80.w,
              padding: EdgeInsets.only(
                  top: 10.w, right: 5.w, left: 5.w, bottom: 5.w),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Logo(),
                    SizedBox(
                      height: 5.h,
                    ),
                    InputDetails(name: _email, multiValidator: emailValidator,icon: Icons.mail,hint: "Enter Your Email",),
                    SizedBox(
                      height: 3.h,
                    ),
                    password(_password, _passwordVisible, passwordVisibility,false),
                    SizedBox(
                      height: 1.5.h,
                    ),
                    H5Heading(text: "Forgot Password?",),
                    SizedBox(
                      height: 3.h,
                    ),
                    GradientButton(text: "Login"),
                    SizedBox(
                      height: 7.h,
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.popAndPushNamed(context, RegisterScreen.id);
                      },
                        child: H4Heading(text: "Don't have an account? Register",)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
