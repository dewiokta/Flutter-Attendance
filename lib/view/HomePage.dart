import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_attendance/blocs/Auth_bloc.dart';
import 'package:flutter_attendance/event/auth_event.dart';
import 'package:flutter_attendance/repository/auth_repository.dart';
import 'package:flutter_attendance/state/auth_state.dart';

import '../constants.dart';
import '../maindrawer.dart';
import '../pages/home/homeMenu.dart';
import '../pages/profile/profile.dart';
import '../pages/riwayat/riwayat.dart';

class HomePage extends StatefulWidget {
  final AuthBloc authBloc;

  const HomePage({Key? key, required this.authBloc}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthRepository authRepository = AuthRepository();
  AuthBloc get _authBloc => widget.authBloc;

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
                    // RaisedButton(
                    //   onPressed: () {
                    //     _authBloc.add(LoggedOut());
                    //   },
                    //   child: Text("Logout"),
                    // )
                  ],
                ),
              );
            }
            return Container();
          }),
      // SingleChildScrollView(
      //       padding: EdgeInsets.symmetric(vertical: 20),
      //       child: Column(
      //         children: [
      //           SizedBox(height: 20),
      //           HomeMenu(
      //             text: "Home Page",
      //             icon: "Icons.",
      //             press: () => Navigator.of(context).push(MaterialPageRoute(
      //                 builder: (context) => HomePage(authBloc: _authBloc))),
      //           ),
      //           HomeMenu(
      //             text: "Profile",
      //             icon: "assets/icons/Bell.svg",
      //             press: () => Navigator.of(context).push(MaterialPageRoute(
      //                 builder: (context) =>
      //                     ProfilePage(authBloc: _authBloc))),
      //           ),
      //           HomeMenu(
      //             text: "Presensi",
      //             icon: "assets/icons/Settings.svg",
      //             press: () {},
      //           ),
      //           HomeMenu(
      //             text: "Jadwal Presensi",
      //             icon: "assets/icons/Question mark.svg",
      //             press: () {},
      //           ),
      //           HomeMenu(
      //             text: "Riwayat Presensi",
      //             icon: "assets/icons/Log out.svg",
      //             press: () => Navigator.of(context).push(MaterialPageRoute(
      //                 builder: (context) =>
      //                     RiwayatWidget(authBloc: _authBloc))),
      //           ),
      //           HomeMenu(
      //             text: "Log Out",
      //             icon: "assets/icons/Log out.svg",
      //             press: () {},
      //           ),
      //         ],
      //       ),
      //     ),
    );
  }
}
