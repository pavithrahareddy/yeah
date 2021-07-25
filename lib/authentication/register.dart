import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:yeah/Theme/constants.dart';
import 'package:sizer/sizer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:yeah/authentication/login.dart';
import 'package:yeah/widgets/button_widgets.dart';
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
  TextEditingController _username = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();

  List allUsers = [];

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
  bool loading = false;
  bool availabilityIndicator = false;
  bool taken = false;

  @override
  void initState() {
    _passwordVisible = false;
    getUserNames();
    loading = false;
    super.initState();
  }

  void passwordVisibility() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  void loadingState() {
    setState(() {
      loading = !loading;
    });
  }

  getUserNames() async {
    QuerySnapshot getUsers =
        await FirebaseFirestore.instance.collection("users").get();
    for (int i = 0; i < getUsers.docs.length; i++) {
      var user = getUsers.docs[i];
      allUsers.add(user['username']);
      print(user['username']);
    }
    print(allUsers);
  }

  bool availabilty(String username) {
    if (allUsers.contains(username)) {
      print("taken");
      return true;
    } else {
      print("not taken");
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: loading,
      opacity: 0.5,
      progressIndicator: CircularProgressIndicator(
        color: Color(0xFF4C2AE3),
      ),
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            backgroundTheme,
            Padding(
              padding: EdgeInsets.only(top: 2.h),
              child: Container(
                height: 90.h,
                width: 80.w,
                padding: EdgeInsets.only(
                    top: 7.w, right: 5.w, left: 5.w, bottom: 3.w),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Logo(),
                        SizedBox(
                          height: 2.h,
                        ),
                        H4Heading(text: "Enter Details To Sign Up"),
                        SizedBox(
                          height: 3.h,
                        ),
                        InputDetails(
                          name: _name,
                          icon: Icons.person,
                          hint: "Enter Your Display Name",
                          multiValidator: requiredValidator,
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: inputBoxDecoration,
                          child: TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            onFieldSubmitted: (value) {},
                            style: TextStyle(
                              color: Color(
                                  0xFFEA02B1), //TextFormField title background color change
                            ),
                            keyboardType: TextInputType.emailAddress,
                            decoration: textInputDecoration.copyWith(
                              suffixIcon: availabilityIndicator
                                  ? Transform.scale(
                                      scale: 0.5,
                                      child: SizedBox(
                                        child: CircularProgressIndicator(
                                          color: Color(0xFFE50277),
                                        ),
                                        height: 10,
                                        width: 10,
                                      ),
                                    )
                                  : SizedBox(),
                              hintText: "Enter Unique Username",
                              prefixIcon: Icon(
                                Icons.person,
                                color: Color(0xFFE50277),
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                availabilityIndicator = true;
                              });
                              if (value != null) {
                                setState(() {
                                  taken = availabilty(value);
                                  availabilityIndicator = false;
                                });
                              }
                            },
                            controller: _username,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Username is Required";
                              } else if (taken) {
                                return "Username is already taken";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        InputDetails(
                          name: _email,
                          multiValidator: emailValidator,
                          icon: Icons.mail,
                          hint: "Enter Your Email",
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        password(_password, _passwordVisible,
                            passwordVisibility, true),
                        SizedBox(
                          height: 3.h,
                        ),
                        ConfirmPassword(
                            passwordVisible: _passwordVisible,
                            confirmPassword: _confirmPassword,
                            password: _password),
                        SizedBox(
                          height: 3.h,
                        ),
                        GestureDetector(
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                loadingState();
                                try {
                                  // returns a Future
                                  final newUser = await _auth
                                      .createUserWithEmailAndPassword(
                                          email: _email.text,
                                          password: _password.text);
                                  await newUser.user!.sendEmailVerification();
                                  AlertDialog(
                                    content: Text(
                                        "Email Verification Link Sent To Mail!"),
                                  );
                                  newUser.user!
                                      .updateDisplayName(_username.text);
                                  await _fireStore
                                      .collection('users')
                                      .doc(newUser.user!.uid)
                                      .set({
                                    'name': _name.text,
                                    'email': _email.text,
                                    'username': _username.text,
                                  });
                                  loadingState();
                                  Navigator.popAndPushNamed(
                                      context, LoginScreen.id);
                                } catch (e) {
                                  loadingState();
                                  print(e);
                                  if (e.toString() ==
                                      "[firebase_auth/email-already-in-use] The email address is already in use by another account.") {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            content: Text(
                                                "Oops! Email address already used by another account."),
                                          );
                                        });
                                  }
                                }
                              }
                            },
                            child: GradientButton(text: "Sign Up")),
                        SizedBox(
                          height: 3.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.popAndPushNamed(context, LoginScreen.id);
                          },
                          child: H4Heading(
                            text: "Already a user? Login",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
