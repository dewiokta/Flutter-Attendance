import 'package:flutter/material.dart';
import 'package:flutter_attendance/pages/login/blocs/Auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'components/body.dart';

class LoginScreen extends StatefulWidget {
  final AuthBloc authBloc;
  const LoginScreen({Key? key, required this.authBloc}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthBloc get _authBloc => widget.authBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _authBloc,
      child: Body(
        authBloc: _authBloc,
      ),
    );
  }
}
