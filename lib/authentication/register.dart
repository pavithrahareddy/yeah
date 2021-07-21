import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:yeah/Theme/constants.dart';
import 'package:sizer/sizer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:yeah/authentication/login.dart';
import 'package:yeah/widgets/input_widgets.dart';
import 'package:yeah/widgets/text_widgets.dart';

class RegisterScreen extends StatefulWidget {
  static const String id = 'register_screen';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;

  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();

  final _formKey = GlobalKey<FormState>();



  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: '            Password is required'),
    MinLengthValidator(8,
        errorText: '            Password must be at least 8 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText:
            '            Password must have at least one special character')
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
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          backgroundTheme,
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 2.h),
              child: Container(
                height: 90.h,
                width: 80.w,
                padding: EdgeInsets.all(5.w),
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
                      H4Heading(text: "Enter Details To Sign Up"),
                      SizedBox(
                        height: 3.h,
                      ),
                      InputDetails(name: _name,icon: Icons.person,hint: "Enter Your Name",multiValidator: requiredValidator,),
                      SizedBox(
                        height: 3.h,
                      ),
                      InputDetails(name: _email, multiValidator: emailValidator,icon: Icons.mail,hint: "Enter Your Email",),
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
                                0xFFE50277), //TextFormField title background color change
                          ),
                          obscureText: !_passwordVisible,
                          decoration: textInputDecoration.copyWith(
                            hintText: "Enter Your Password",
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Color(0xFFE50277),
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
                                color: Color(0xFFE50277),
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
                      ConfirmPassword(passwordVisible: _passwordVisible, confirmPassword: _confirmPassword, password: _password),
                      SizedBox(
                        height: 3.h,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            try {
                              // returns a Future
                              final newUser =
                                  await _auth.createUserWithEmailAndPassword(
                                      email: _email.text,
                                      password: _password.text);

                              await newUser.user!.sendEmailVerification();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Email Verification Link Sent',
                                  ),
                                ),
                              );
                              print(newUser);
                              print(_name.text);
                              print(_email.text);
                              print(_password.text);
                              await _fireStore
                                  .collection('users')
                                  .doc(newUser.user!.uid)
                                  .set({
                                'name': _name.text,
                                'email': _email.text,
                              });
                            } catch (e) {
                              print(e);
                              if(e.toString() == "[firebase_auth/email-already-in-use] The email address is already in use by another account."){
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        content: Text("Oops! Email address already used by another account."),
                                      );
                                    });
                              }
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFF5F42E3),
                          elevation: 5,
                          minimumSize: Size(50.w, 7.h),
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                        ),
                        child: H3Heading(text: 'Sign Up',),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, LoginScreen.id);
                        },
                        child: H4Heading(text: "Already a user? Login",),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}









