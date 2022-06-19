import 'package:flutter/material.dart';
import 'package:flutter_attendance/pages/login/blocs/Auth_bloc.dart';
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
  final TextEditingController passwordController =
      TextEditingController(text: "");
  bool _isHidden = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextField(
          obscureText: _isHidden,
          decoration: InputDecoration(
            hintText: 'Password',
            suffix: InkWell(
              onTap: _togglePasswordView,
              child: Icon(
                _isHidden ? Icons.visibility : Icons.visibility_off,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}
