import 'package:flutter/material.dart';
import 'package:flutter_attendance/constants.dart';
import 'package:flutter_attendance/pages/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_attendance/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_attendance/pages/profile/bloc/profile_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_attendance/repository/auth_repository.dart';
import 'package:flutter_attendance/state/auth_state.dart';
import 'package:flutter_attendance/login and home/HomePage.dart';
import 'blocs/Auth_bloc.dart';
import 'event/auth_event.dart';
import 'login and home/LoginPage.dart';

void main() {
  final AuthRepository authRepository = AuthRepository();
  BlocOverrides.runZoned(
    () => runApp(BlocProvider(
      create: (context) {
        return AuthBloc(authRepository: authRepository);
      },
      child: MyApp(
        authRepository: authRepository,
        authBloc: AuthBloc(authRepository: authRepository),
        profileBloc: ProfileBloc(authRepository),
      ),
    )),
  );
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepository;
  final AuthBloc authBloc;
  final ProfileBloc profileBloc;

  const MyApp(
      {Key? key,
      required this.authRepository,
      required this.authBloc,
      required this.profileBloc})
      : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocBuilder(
        bloc: authBloc,
        builder: (context, AuthState state) {
          if (state is AuthInit) {
            authBloc.add(AuthCheck());
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (state is AuthHasToken || state is AuthData)
            return HomePage(
              authBloc: authBloc,
              profileBloc: profileBloc,
            );
          if (state is AuthFailed || state is LoginFailed)
            return LoginPage(authBloc: authBloc);
          if (state is LoggedOut) return LoginPage(authBloc: authBloc);
          if (state is AuthLoading)
            return Container(
              color: Colors.white,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );

          return Container();
        },
      ),
    );
  }
}
