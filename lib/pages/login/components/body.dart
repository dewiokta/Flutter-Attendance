import 'package:flutter/material.dart';
import 'package:flutter_attendance/components/rounded_button.dart';
import 'package:flutter_attendance/pages/home/home.dart';
import 'package:flutter_attendance/pages/login/components/background.dart';
import 'package:flutter_attendance/pages/login/components/forgor_password.dart';
import 'package:flutter_attendance/pages/login/components/rounded_field_password.dart';
import 'package:flutter_attendance/pages/login/components/rounded_field_username.dart';
import 'package:flutter_attendance/pages/login/login_screen.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "LOGIN",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 29, 126, 172)),
          ),
          SizedBox(height: size.height * 0.03),
          Image.asset("assets/images/logo.png", height: size.height * 0.2),
          SizedBox(height: size.height * 0.03),
          RoundedInputField(
            hintText: "Username",
            onChanged: (value) {},
          ),
          RoundedFieldPassword(
            onChanged: (value) {},
          ),
          SizedBox(height: size.height * 0.03),
          RoundedButton(
            text: "LOGIN",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return HomeScreen();
                  },
                ),
              );
            },
          ),
          SizedBox(height: size.height * 0.03),
          ForgotPassword(),
        ],
      ),
    );
  }
}
