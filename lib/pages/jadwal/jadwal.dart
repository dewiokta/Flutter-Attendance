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
      body: SingleChildScrollView(
        child: Column(
          children: [
            FlatButton.icon(
              onPressed: () {
                setState(() {
                  _isvisible = !_isvisible;
                });
              },
              icon: Icon(
                Icons.arrow_downward,
                size: 24.0,
              ),
              label: Text('Senin'),
              padding: EdgeInsets.symmetric(horizontal: 100, vertical: 20),
            ),
            const SizedBox(
              height: 15.0,
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
            const SizedBox(
              height: 25.0,
            ),
            FlatButton.icon(
              onPressed: () {
                setState(() {
                  _isvisible2 = !_isvisible2;
                });
              },
              icon: Icon(
                Icons.arrow_downward,
                size: 24.0,
              ),
              label: Text('Selasa'),
              padding: EdgeInsets.symmetric(horizontal: 100, vertical: 20),
            ),
            const SizedBox(
              height: 15.0,
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
            const SizedBox(
              height: 25.0,
            ),
            FlatButton.icon(
              onPressed: () {
                setState(() {
                  _isvisible3 = !_isvisible3;
                });
              },
              icon: Icon(
                Icons.arrow_downward,
                size: 24.0,
              ),
              label: Text('Rabu'),
              padding: EdgeInsets.symmetric(horizontal: 100, vertical: 20),
            ),
            const SizedBox(
              height: 15.0,
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
            const SizedBox(
              height: 25.0,
            ),
            FlatButton.icon(
              onPressed: () {
                setState(() {
                  _isvisible4 = !_isvisible4;
                });
              },
              icon: Icon(
                Icons.arrow_downward,
                size: 24.0,
              ),
              label: Text('Kamis'),
              padding: EdgeInsets.symmetric(horizontal: 100, vertical: 20),
            ),
            const SizedBox(
              height: 15.0,
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
            const SizedBox(
              height: 25.0,
            ),
            FlatButton.icon(
              onPressed: () {
                setState(() {
                  _isvisible5 = !_isvisible5;
                });
              },
              icon: Icon(
                Icons.arrow_downward,
                size: 24.0,
              ),
              label: Text('Jumat'),
              padding: EdgeInsets.symmetric(horizontal: 100, vertical: 20),
            ),
            const SizedBox(
              height: 15.0,
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
          ],
        ),
      ),
    );
  }
}
