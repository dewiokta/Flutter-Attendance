import 'package:flutter/material.dart';
import 'package:flutter_attendance/pages/profile/bloc/profile_bloc.dart';
import 'package:flutter_attendance/pages/riwayat/riwayat.dart';
import 'package:flutter_attendance/constants.dart';
import 'package:flutter_attendance/pages/profile/profile.dart';
import 'package:flutter_attendance/view/LoginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'homeMenu.dart';
import '../../maindrawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_attendance/blocs/Auth_bloc.dart';
import 'package:flutter_attendance/event/auth_event.dart';
import 'package:flutter_attendance/repository/auth_repository.dart';
import 'package:flutter_attendance/state/auth_state.dart';

class HomePage extends StatefulWidget {
  final AuthBloc authBloc;
  final ProfileBloc profileBloc;

  const HomePage({Key? key, required this.authBloc, required this.profileBloc})
      : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthRepository authRepository = AuthRepository();
  AuthBloc get _authBloc => widget.authBloc;
  ProfileBloc get _profileBloc => widget.profileBloc;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Asistencia"),
        backgroundColor: kPrimaryColor,
      ),
      drawer: Drawer(
        child: MainDrawer(
          authBloc: _authBloc,
          profileBloc: _profileBloc,
        ),
      ),
      backgroundColor: Colors.white,
      body: BlocBuilder<AuthBloc, AuthState>(
          bloc: _authBloc,
          builder: (context, state) {
            if (state is AuthHasToken) {
              _authBloc.add(GetDataWithToken(state.token));
              return Container();
            }
            if (state is AuthData) {
              return Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Nama : " + state.name,
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      "Email : " + state.email,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              );
            }
            return Container(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    HomeMenu(
                      text: "Home Page",
                      icon: "Icons.",
                      press: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => HomePage(
                                authBloc: _authBloc,
                                profileBloc: _profileBloc,
                              ))),
                    ),
                    HomeMenu(
                      text: "Profile",
                      icon: "assets/icons/Bell.svg",
                      press: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ProfilePage(
                                authBloc: _authBloc,
                                profileBloc: _profileBloc,
                              ))),
                    ),
                    HomeMenu(
                      text: "Presensi",
                      icon: "assets/icons/Settings.svg",
                      press: () {},
                    ),
                    HomeMenu(
                      text: "Jadwal Presensi",
                      icon: "assets/icons/Question mark.svg",
                      press: () {},
                    ),
                    HomeMenu(
                      text: "Riwayat Presensi",
                      icon: "assets/icons/Log out.svg",
                      press: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => RiwayatWidget(
                                authBloc: _authBloc,
                                profileBloc: _profileBloc,
                              ))),
                    ),
                    HomeMenu(
                      text: "Log Out",
                      icon: "assets/icons/Log out.svg",
                      press: () async {
                        SharedPreferences pref =
                            await SharedPreferences.getInstance();
                        await pref.clear();
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) =>
                                  LoginPage(authBloc: _authBloc),
                            ),
                            (route) => false);
                      },
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
