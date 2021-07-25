import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:yeah/Theme/constants.dart';

final requiredValidator =MultiValidator([RequiredValidator(errorText: '             Field is required'),]);

final emailValidator = MultiValidator([
  RequiredValidator(errorText: '            Field is required'),
  EmailValidator(errorText: '            Enter a valid email address')
]);

final passwordValidator = MultiValidator([
  RequiredValidator(errorText: '            Field is required'),
  MinLengthValidator(8,
      errorText: '            Password must be at least 8 digits long'),
  PatternValidator(r'(?=.*?[#?!@$%^&*-])',
      errorText:
      '            Password must have at least one special character')
]);

class InputDetails extends StatelessWidget {
  const InputDetails({
    Key? key,
    required TextEditingController name,
    required this.hint,
    required this.icon,
    required this.multiValidator,
  }) : _name = name, super(key: key);

  final TextEditingController _name;
  final MultiValidator multiValidator;
  final String hint;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
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
          hintText: hint,
          prefixIcon: Icon(
            icon,
            color: Color(0xFFE50277),
          ),
        ),
        controller: _name,
        validator: multiValidator,
      ),
    );
  }
}

Widget password(TextEditingController password,bool _passwordVisible,Function passwordVisibility, bool type){

  return Container(
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
      controller: password,
      validator: type ? passwordValidator : requiredValidator,
    ),
  );
}


class ConfirmPassword extends StatelessWidget {
  const ConfirmPassword({
    Key? key,
    required bool passwordVisible,
    required TextEditingController confirmPassword,
    required TextEditingController password,
  }) : _passwordVisible = passwordVisible, _confirmPassword = confirmPassword, _password = password, super(key: key);

  final bool _passwordVisible;
  final TextEditingController _confirmPassword;
  final TextEditingController _password;

  @override
  Widget build(BuildContext context) {
    return Container(
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
          hintText: "Confirm Your Password",
          prefixIcon: Icon(
            Icons.lock,
            color: Color(0xFFE50277),
          ),
        ),
        controller: _confirmPassword,
        validator: (val) => MatchValidator(
            errorText:
            '            Passwords do not match')
            .validateMatch(
            _password.text, _confirmPassword.text),
      ),
    );
  }
}


