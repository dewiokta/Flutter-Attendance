import 'package:flutter/material.dart';
import 'package:flutter_attendance/pages/jadwal/jadwal.dart';
import 'package:flutter_attendance/pages/presensi/presensi.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_attendance/pages/login/blocs/Auth_bloc.dart';
import 'package:flutter_attendance/pages/login/blocs/auth_event.dart';
import 'package:flutter_attendance/pages/login/blocs/auth_repository.dart';
import 'package:flutter_attendance/pages/login/blocs/auth_state.dart';
import 'package:flutter_attendance/pages/login/LoginPage.dart';
import '../../maindrawer.dart';
import '../../ui/constants.dart';
import '../profile/profile.dart';
import '../riwayat/riwayat.dart';

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
        title: const Text("Asistencia"),
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
                padding: const EdgeInsets.all(18),
                child: ListView(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Welcome " + state.name + " !",
                          style: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          height: 200,
                          width: 300,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: kPrimaryColor,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  CircleAvatar(
                                    radius: 50,
                                    backgroundColor: const Color(00000),
                                    child: Image.asset(
                                      "assets/images/user2.png",
                                      // fit: BoxFit.fill,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: const [
                                      Text(
                                        "Asistencia ",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "" + state.name,
                                        style: const TextStyle(
                                            fontSize: 30, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ListTile(
                          onTap: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => HomePage(
                                        authBloc: _authBloc,
                                      ))),
                          leading: Icon(
                            Icons.home,
                            color: Colors.indigo[400],
                          ),
                          title: const Text("Home"),
                          trailing: const Icon(Icons.arrow_forward),
                        ),
                        ListTile(
                          onTap: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ProfilePage(
                                        authBloc: _authBloc,
                                      ))),
                          leading: Icon(
                            Icons.person,
                            color: Colors.indigo[400],
                          ),
                          title: const Text("Profile Account"),
                          trailing: const Icon(Icons.arrow_forward),
                        ),
                        ListTile(
                          onTap: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Presensi(
                                        authBloc: _authBloc,
                                      ))),
                          leading: Icon(
                            Icons.camera_enhance_rounded,
                            color: Colors.indigo[400],
                          ),
                          title: const Text("Presensi"),
                          trailing: const Icon(Icons.arrow_forward),
                        ),
                        ListTile(
                          onTap: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => JadwalPages(
                                        authBloc: _authBloc,
                                      ))),
                          leading: Icon(
                            Icons.access_time_filled_outlined,
                            color: Colors.indigo[400],
                          ),
                          title: const Text("Jadwal Presensi"),
                          trailing: const Icon(Icons.arrow_forward),
                        ),
                        ListTile(
                          onTap: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => RiwayatWidget(
                                        authBloc: _authBloc,
                                      ))),
                          leading: Icon(
                            Icons.history,
                            color: Colors.indigo[400],
                          ),
                          title: const Text("Riwayat Presensi"),
                          trailing: const Icon(Icons.arrow_forward),
                        ),
                        ListTile(
                          onTap: () async {
                            _authBloc.add(LoggedOut());
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) =>
                                    LoginPage(authBloc: _authBloc),
                              ),
                            );
                          },
                          leading: Icon(
                            Icons.logout,
                            color: Colors.indigo[400],
                          ),
                          title: const Text("Sign Out"),
                          trailing: const Icon(Icons.arrow_forward),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }
            return Container();
          }),
    );
  }
}
