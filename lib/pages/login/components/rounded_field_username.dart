import 'package:flutter/material.dart';
import 'package:flutter_attendance/blocs/Auth_bloc.dart';
import 'package:flutter_attendance/constants.dart';
import 'package:flutter_attendance/pages/login/components/textField.dart';

class RoundedInputField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const RoundedInputField({
    Key? key,
    required this.hintText,
    this.icon = Icons.person,
    required this.onChanged, required this.controller,
  }) : super(key: key);

  @override
  State<RoundedInputField> createState() => _RoundedInputFieldState();
}

class _RoundedInputFieldState extends State<RoundedInputField> {
  final TextEditingController emailController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: widget.onChanged,
        // controller: emailController,
        decoration: InputDecoration(
          icon: Icon(
            widget.icon,
            color: kPrimaryColor,
          ),
          hintText: widget.hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
