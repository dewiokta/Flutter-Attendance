import 'package:flutter/material.dart';
import 'package:flutter_attendance/blocs/Auth_bloc.dart';
import 'package:flutter_attendance/components/rounded_button.dart';
import 'package:flutter_attendance/event/auth_event.dart';
import 'package:flutter_attendance/pages/home/home.dart';
import 'package:flutter_attendance/pages/login/components/background.dart';
import 'package:flutter_attendance/pages/login/components/forgor_password.dart';
import 'package:flutter_attendance/pages/login/components/rounded_field_password.dart';
import 'package:flutter_attendance/pages/login/components/rounded_field_username.dart';
import 'package:flutter_attendance/pages/login/login_screen.dart';
import 'package:flutter_attendance/state/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Body extends StatefulWidget {
  final AuthBloc authBloc;

  const Body({
    Key? key,
    required this.authBloc,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final TextEditingController emailController = TextEditingController(text: "");

  final TextEditingController passwordController =
      TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: BlocBuilder(
          bloc: widget.authBloc,
          builder: (context, state) {
            return Background(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    "LOGIN",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 29, 126, 172)),
                  ),
                  SizedBox(height: size.height * 0.03),
                  Image.asset("assets/images/logo.png",
                      height: size.height * 0.2),
                  SizedBox(height: size.height * 0.03),
                  RoundedInputField(
                    controller: emailController,
                    hintText: "Username",
                    onChanged: (value) {},
                  ),
                  RoundedFieldPassword(
                    onChanged: (value) {},
                  ),
                  SizedBox(height: size.height * 0.03),
                  RaisedButton(
                    onPressed: _login,
                    child: (state is AuthLoading)
                        ? Text("Please wait")
                        : Text("Login"),
                  ),
                  SizedBox(height: size.height * 0.03),
                  ForgotPassword(),
                ],
              ),
            );
          }),
    );
  }

  void _login() {
    widget.authBloc.add(LoginProcess(
      email: emailController.text,
      password: passwordController.text,
    ));
  }
}
