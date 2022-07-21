import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_attendance/pages/login/LoginPage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_attendance/pages/login/blocs/Auth_bloc.dart';
import 'package:flutter_attendance/pages/login/blocs/auth_event.dart';
import 'package:flutter_attendance/pages/login/blocs/auth_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../network/networkregist.dart';
import '../../ui/constants.dart';
import '../login/components/background.dart';
import '../regis/register.dart';
import '../home/HomePage.dart';

class RegisterPage extends StatefulWidget {
  final AuthBloc authBloc;

  const RegisterPage({Key? key, required this.authBloc}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  AuthBloc get _authBloc => widget.authBloc;

  // TextEditingController nameController = TextEditingController();
  // TextEditingController emailController = TextEditingController();
  // TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _authBloc,
      child: SignUpForm(
        authBloc: _authBloc,
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  final AuthBloc authBloc;

  SignUpForm({Key? key, required this.authBloc}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  AuthBloc get _authBloc => widget.authBloc;
  final TextEditingController emailController = TextEditingController(text: "");
  final TextEditingController passwordController =
      TextEditingController(text: "");
  TextEditingController nameController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocListener<AuthBloc, AuthState>(
        bloc: widget.authBloc,
        listener: (context, state) {
          if (state is AuthHasToken) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: ((context) => HomePage(
                      authBloc: _authBloc,
                    ))));
          }
        },
        child: BlocBuilder(
            bloc: widget.authBloc,
            builder: (context, state) {
              return Scaffold(
                  backgroundColor: Colors.white,
                  body: Background(
                    child: SingleChildScrollView(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Text(
                                "Sign Up",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 29, 126, 172),
                                    fontSize: 20),
                              ),
                              SizedBox(height: size.height * 0.03),
                              Image.asset("assets/images/logo.png",
                                  height: size.height * 0.2),
                              SizedBox(height: size.height * 0.03),
                              SizedBox(
                                width: 300,
                                child: TextField(
                                  controller: nameController,
                                  decoration: InputDecoration(
                                    labelText: "Username",
                                    filled: true,
                                    fillColor: kPrimaryColorLight,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(29),
                                        borderSide: const BorderSide(
                                          color: kPrimaryColorLight,
                                        )),
                                  ),
                                ),
                              ),
                              SizedBox(height: size.height * 0.03),
                              SizedBox(
                                width: 300,
                                child: TextField(
                                  controller: emailController,
                                  decoration: InputDecoration(
                                    labelText: "Email",
                                    filled: true,
                                    fillColor: kPrimaryColorLight,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(29),
                                        borderSide: const BorderSide(
                                          color: kPrimaryColorLight,
                                        )),
                                  ),
                                ),
                              ),
                              SizedBox(height: size.height * 0.03),
                              SizedBox(
                                width: 300,
                                child: TextField(
                                  controller: passwordController,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    labelText: "Password",
                                    filled: true,
                                    fillColor: kPrimaryColorLight,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(29),
                                        borderSide: const BorderSide(
                                          color: kPrimaryColorLight,
                                        )),
                                  ),
                                ),
                              ),
                              SizedBox(height: size.height * 0.03),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(29),
                                child: FlatButton(
                                  onPressed: _handleLogin,
                                  child: (state is AuthLoading)
                                      ? const Text("Please wait")
                                      : const Text(
                                          "Sign Up",
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 40),
                                  color: kPrimaryColor,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (context) => LoginPage(
                                                  authBloc: _authBloc,
                                                )));
                                  },
                                  child: Text(
                                    'Already Have an Account? Please Login',
                                    textDirection: TextDirection.ltr,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15.0,
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ));
            }));
  }

  void _login() {
    widget.authBloc.add(LoginProcess(
      email: emailController.text,
      password: passwordController.text,
    ));
  }

  void _handleLogin() async {
    var data = {
      'name': nameController.text,
      'email': emailController.text,
      'password': passwordController.text,
    };

    var res = await CallApi().postData(data, 'register');
    CoolAlert.show(
      context: context,
      type: CoolAlertType.success,
      text: 'Create Account Succes! Silahkan Login Untuk Masuk Sistem',
    ).then((value) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => LoginPage(authBloc: _authBloc)));
    });
  }
}
