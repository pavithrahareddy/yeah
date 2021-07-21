import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:yeah/Theme/constants.dart';

final requiredValidator =MultiValidator([RequiredValidator(errorText: '            Name is required'),]);

final emailValidator = MultiValidator([
  RequiredValidator(errorText: '            Email is required'),
  EmailValidator(errorText: '            Enter a valid email address')
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