import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_attendance/pages/login/blocs/Auth_bloc.dart';
import 'package:flutter_attendance/pages/login/blocs/auth_event.dart';
import 'package:flutter_attendance/pages/login/blocs/auth_state.dart';
import '../../ui/constants.dart';
import '../regis/regis.dart';
import '../regis/register.dart';
import 'components/background.dart';
import '../home/HomePage.dart';

class LoginPage extends StatefulWidget {
  final AuthBloc authBloc;

  const LoginPage({Key? key, required this.authBloc}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthBloc get _authBloc => widget.authBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _authBloc,
      child: LoginForm(
        authBloc: _authBloc,
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  final AuthBloc authBloc;

  LoginForm({Key? key, required this.authBloc}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  AuthBloc get _authBloc => widget.authBloc;
  final TextEditingController emailController = TextEditingController(text: "");

  final TextEditingController passwordController =
      TextEditingController(text: "");

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
                                "LOGIN",
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
                                  onPressed: _login,
                                  child: (state is AuthLoading)
                                      ? const Text("Please wait")
                                      : const Text(
                                          "LOGIN",
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
                              (state is LoginFailed)
                                  ? Text(state.error)
                                  : const Text(""),
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (context) => RegisterPage(
                                                  authBloc: _authBloc,
                                                )));
                                  },
                                  child: Text(
                                    'Create New Account',
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
}
