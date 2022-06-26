import 'package:flutter/material.dart';
import 'package:flutter_attendance/constants.dart';
import 'package:flutter_attendance/maindrawer.dart';
import 'package:flutter_attendance/pages/presensi/presensi_datang.dart';
import 'package:flutter_attendance/pages/presensi/presensi_pulang.dart';
import 'package:flutter_attendance/pages/profile/bloc/profile_bloc.dart';

import '../login/blocs/Auth_bloc.dart';
import '../login/blocs/auth_repository.dart';

class Presensi extends StatefulWidget {
  final AuthBloc authBloc;
  final ProfileBloc profileBloc;
  const Presensi({Key? key, required this.authBloc, required this.profileBloc})
      : super(key: key);
  @override
  State<Presensi> createState() => _PresensiState();
}

class _PresensiState extends State<Presensi> {
  final AuthRepository authRepository = AuthRepository();
  AuthBloc get _authBloc => widget.authBloc;
  ProfileBloc get _profileBloc => widget.profileBloc;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Presensi"),
        backgroundColor: kPrimaryColor,
      ),
      drawer: Drawer(
        child: MainDrawer(
          authBloc: _authBloc,
          profileBloc: _profileBloc,
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PresensiDatang(
                        authBloc: _authBloc,
                        profileBloc: _profileBloc,
                      ))),
              leading: const Image(
                image: AssetImage("assets/images/presensi.png"),
              ),
              title: Text("Presensi Datang"),
              trailing: Icon(Icons.arrow_forward),
            ),
            const SizedBox(height: 10),
            ListTile(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PresensiPulang(
                        authBloc: _authBloc,
                        profileBloc: _profileBloc,
                      ))),
              leading: const Image(
                image: AssetImage("assets/images/riwayat.png"),
              ),
              title: const Text("Presensi Pulang"),
              trailing: const Icon(Icons.arrow_forward),
            ),
          ],
        ),
      ),
    );
  }
}
