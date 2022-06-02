import 'package:flutter/material.dart';
import 'package:flutter_attendance/components/rounded_button.dart';
import 'package:flutter_attendance/constants.dart';
import 'package:flutter_attendance/maindrawer.dart';
import 'package:getwidget/getwidget.dart';

import '../../blocs/Auth_bloc.dart';
import '../../repository/auth_repository.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isvisible = !_isvisible;
                  });
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 90, 103, 136),
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                ),
                child: const Text("Senin")),
            const SizedBox(
              height: 15.0,
            ),
            Visibility(
              visible: _isvisible,
              child: const Text("Presensi Datang          07.00"),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Visibility(
              visible: _isvisible,
              child: const Text("Presensi Pulang          16.00"),
            ),
            const SizedBox(
              height: 25.0,
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isvisible2 = !_isvisible2;
                  });
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 90, 103, 136),
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                ),
                child: const Text("Selasa")),
            const SizedBox(
              height: 15.0,
            ),
            Visibility(
              visible: _isvisible2,
              child: const Text("Presensi Datang          07.00"),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Visibility(
              visible: _isvisible2,
              child: const Text("Presensi Pulang          16.00"),
            ),
            const SizedBox(
              height: 25.0,
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isvisible3 = !_isvisible3;
                  });
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 90, 103, 136),
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                ),
                child: const Text("Rabu")),
            const SizedBox(
              height: 15.0,
            ),
            Visibility(
              visible: _isvisible3,
              child: const Text("Presensi Datang          07.00"),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Visibility(
              visible: _isvisible3,
              child: const Text("Presensi Pulang          16.00"),
            ),
            const SizedBox(
              height: 25.0,
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isvisible4 = !_isvisible4;
                  });
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 90, 103, 136),
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                ),
                child: const Text("Kamis")),
            const SizedBox(
              height: 15.0,
            ),
            Visibility(
              visible: _isvisible4,
              child: const Text("Presensi Datang          07.00"),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Visibility(
              visible: _isvisible4,
              child: const Text("Presensi Pulang          16.00"),
            ),
            const SizedBox(
              height: 25.0,
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isvisible5 = !_isvisible5;
                  });
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 90, 103, 136),
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                ),
                child: const Text("Jumat")),
            const SizedBox(
              height: 15.0,
            ),
            Visibility(
              visible: _isvisible5,
              child: const Text("Presensi Datang          07.00"),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Visibility(
              visible: _isvisible5,
              child: const Text("Presensi Pulang          16.00"),
            ),
          ],
        ),
      ),
    );
  }
}
