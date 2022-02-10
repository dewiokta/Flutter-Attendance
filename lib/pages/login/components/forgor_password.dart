import 'package:flutter/material.dart';
import 'package:flutter_attendance/constants.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({
    Key? key,  
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () {},
          child: Text(
            "Forgot Password ?",
            style: TextStyle(
              color: kPrimaryColor,
            ),
          ),
        )
      ],
    );
  }
}
