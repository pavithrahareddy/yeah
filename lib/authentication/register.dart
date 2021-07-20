import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:yeah/Theme/constants.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatefulWidget {
  static const String id = 'register_screen';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();

  final emailValidator = MultiValidator([
    RequiredValidator(errorText: 'Email is required'),
    EmailValidator(errorText: 'enter a valid email address')
  ]);

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Password is required'),
    MinLengthValidator(8, errorText: 'Password must be at least 8 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'Password must have at least one special character')
  ]);

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
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            backgroundTheme,
            Container(
              height: 80.h,
              width: 80.w,
              padding: EdgeInsets.all(6.w),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Morsogram",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.bilbo(
                      fontSize: 56.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    "Enter Details To Sign Up",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.overlock(
                        fontSize: 14.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: inputBoxDecoration,
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onFieldSubmitted: (value) {},
                      style: TextStyle(
                        color: Color(
                            0xFFEA02B1), //TextFormField title background color change
                      ),
                      keyboardType: TextInputType.emailAddress,
                      decoration: textInputDecoration.copyWith(
                        hintText: "Enter Your Email",
                        prefixIcon: Icon(
                          Icons.email,
                          color: Color(0xFFEA02B1),
                        ),
                      ),
                      controller: _email,
                      validator: emailValidator,
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: inputBoxDecoration,
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onFieldSubmitted: (value) {},
                      style: TextStyle(
                        color: Color(
                            0xFFEA02B1), //TextFormField title background color change
                      ),
                      obscureText: !_passwordVisible,
                      decoration: textInputDecoration.copyWith(
                        hintText: "Enter Your Password",
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Color(0xFFEA02B1),
                        ),
                        suffixIcon: GestureDetector(
                          onLongPress: () {
                            passwordVisibility();
                          },
                          onLongPressUp: () {
                            passwordVisibility();
                          },
                          child: Icon(
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Color(0xFFEA02B1),
                          ),
                        ),
                      ),
                      controller: _password,
                      validator: passwordValidator,
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: inputBoxDecoration,
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onFieldSubmitted: (value) {},
                      style: TextStyle(
                        color: Color(
                            0xFFEA02B1), //TextFormField title background color change
                      ),
                      obscureText: !_passwordVisible,
                      decoration: textInputDecoration.copyWith(
                        hintText: "Confirm Your Password",
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Color(0xFFEA02B1),
                        ),
                        suffixIcon: GestureDetector(
                          onLongPress: () {
                            passwordVisibility();
                          },
                          onLongPressUp: () {
                            passwordVisibility();
                          },
                          child: Icon(
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Color(0xFFEA02B1),
                          ),
                        ),
                      ),
                      controller: _confirmPassword,
                      validator: (val) => MatchValidator(
                              errorText: 'Passwords do not match')
                          .validateMatch(_password.text, _confirmPassword.text),
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF5F42E3),
                      elevation: 5,
                      minimumSize: Size(50.w, 7.h),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                    ),
                    child: Text(
                      'Sign Up',
                      style: GoogleFonts.overlock(
                        fontSize: 16.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    "Already a user? Login",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.overlock(
                        fontSize: 14.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
