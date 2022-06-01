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
  bool _isvisible = true;
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
      body: ListView(
        children: [
          ElevatedButton(
              onPressed: () {
                setState(() {
                  _isvisible = !_isvisible;
                });
              },
              child: const Text("Senin")),
          const SizedBox(
            height: 30.0,
          ),
          Visibility(
            visible: _isvisible,
            child: const Text("Presensi Datang          07.00"),
          ),
          Visibility(
            visible: _isvisible,
            child: const Text("Presensi Pulang          16.00"),
          ),
        ],
      ),
    );
  }
}
