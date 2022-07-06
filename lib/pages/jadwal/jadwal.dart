import 'package:flutter/material.dart';
import 'package:flutter_attendance/constants.dart';
import 'package:flutter_attendance/maindrawer.dart';
import '../login/blocs/Auth_bloc.dart';
import '../login/blocs/auth_repository.dart';

class JadwalPages extends StatefulWidget {
  final AuthBloc authBloc;
  const JadwalPages({Key? key, required this.authBloc}) : super(key: key);
  @override
  State<JadwalPages> createState() => _JadwalPagesState();
}

class _JadwalPagesState extends State<JadwalPages> {
  final AuthRepository authRepository = AuthRepository();
  AuthBloc get _authBloc => widget.authBloc;
  bool _isvisible = false;
  bool _isvisible2 = false;
  bool _isvisible3 = false;
  bool _isvisible4 = false;
  bool _isvisible5 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Jadwal Presensi"),
        backgroundColor: kPrimaryColor,
      ),
      drawer: Drawer(
        child: MainDrawer(authBloc: _authBloc),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(8),
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    children: const <Widget>[
                      Image(
                        image: AssetImage("assets/images/riwayat2.png"),
                        height: 60,
                      )
                    ],
                  ),
                  Column(
                    children: const [
                      Text(
                        "Senin  ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      FlatButton.icon(
                        onPressed: () {
                          setState(() {
                            _isvisible = !_isvisible;
                          });
                        },
                        label: const Text('', textAlign: TextAlign.start),
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          size: 24.0,
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 100, vertical: 15),
                      ),
                    ],
                  ),
                ],
              ),
              Visibility(
                visible: _isvisible,
                child: const Text("Presensi Datang          07.00 WIB"),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Visibility(
                visible: _isvisible,
                child: const Text("Presensi Pulang          16.00 WIB"),
              ),
              Row(
                children: [
                  Column(
                    children: const <Widget>[
                      Image(
                        image: AssetImage("assets/images/riwayat2.png"),
                        height: 60,
                      )
                    ],
                  ),
                  Column(
                    children: const [
                      Text(
                        "Selasa",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      FlatButton.icon(
                        onPressed: () {
                          setState(() {
                            _isvisible2 = !_isvisible2;
                          });
                        },
                        label: const Text('', textAlign: TextAlign.start),
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          size: 24.0,
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 100, vertical: 15),
                      ),
                    ],
                  ),
                ],
              ),
              Visibility(
                visible: _isvisible2,
                child: const Text("Presensi Datang          07.00 WIB"),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Visibility(
                visible: _isvisible2,
                child: const Text("Presensi Pulang          16.00 WIB"),
              ),
              Row(
                children: [
                  Column(
                    children: const <Widget>[
                      Image(
                        image: AssetImage("assets/images/riwayat2.png"),
                        height: 60,
                      )
                    ],
                  ),
                  Column(
                    children: const [
                      Text(
                        "Rabu   ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      FlatButton.icon(
                        onPressed: () {
                          setState(() {
                            _isvisible3 = !_isvisible3;
                          });
                        },
                        label: const Text('', textAlign: TextAlign.start),
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          size: 24.0,
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 100, vertical: 15),
                      ),
                    ],
                  ),
                ],
              ),
              Visibility(
                visible: _isvisible3,
                child: const Text("Presensi Datang          07.00 WIB"),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Visibility(
                visible: _isvisible3,
                child: const Text("Presensi Pulang          16.00 WIB"),
              ),
              Row(
                children: [
                  Column(
                    children: const <Widget>[
                      Image(
                        image: AssetImage("assets/images/riwayat2.png"),
                        height: 60,
                      )
                    ],
                  ),
                  Column(
                    children: const [
                      Text(
                        "Kamis ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      FlatButton.icon(
                        onPressed: () {
                          setState(() {
                            _isvisible4 = !_isvisible4;
                          });
                        },
                        label: const Text('', textAlign: TextAlign.start),
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          size: 24.0,
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 100, vertical: 15),
                      ),
                    ],
                  ),
                ],
              ),
              Visibility(
                visible: _isvisible4,
                child: const Text("Presensi Datang          07.00 WIB"),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Visibility(
                visible: _isvisible4,
                child: const Text("Presensi Pulang          16.00 WIB"),
              ),
              Row(
                children: [
                  Column(
                    children: const <Widget>[
                      Image(
                        image: AssetImage("assets/images/riwayat2.png"),
                        height: 60,
                      )
                    ],
                  ),
                  Column(
                    children: const [
                      Text(
                        "Jumat ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      FlatButton.icon(
                        onPressed: () {
                          setState(() {
                            _isvisible5 = !_isvisible5;
                          });
                        },
                        label: const Text('', textAlign: TextAlign.start),
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          size: 24.0,
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 100, vertical: 15),
                      ),
                    ],
                  ),
                ],
              ),
              Visibility(
                visible: _isvisible5,
                child: const Text("Presensi Datang          07.00 WIB"),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Visibility(
                visible: _isvisible5,
                child: const Text("Presensi Pulang          16.00 WIB"),
              ),
              const SizedBox(
                height: 25.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
