import 'package:flutter/material.dart';
import 'package:flutter_attendance/constants.dart';
import 'package:flutter_attendance/pages/login/components/textField.dart';

class RoundedFieldPassword extends StatefulWidget {
  final ValueChanged<String> onChanged;
  const RoundedFieldPassword({
    Key? key, 
    required this.onChanged,
  }) : super(key: key);

  @override
  State<RoundedFieldPassword> createState() => _RoundedFieldPasswordState();
}

class _RoundedFieldPasswordState extends State<RoundedFieldPassword> {
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: true,
        onChanged: widget.onChanged ,
        decoration: InputDecoration(
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: kPrimaryColor,
          ),
          border: InputBorder.none
        ),
      ),);
  }
}
