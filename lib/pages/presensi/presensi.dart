import 'package:flutter/material.dart';
import 'package:flutter_attendance/maindrawer.dart';
import 'package:flutter_attendance/pages/presensi/presensi_datang.dart';
import 'package:flutter_attendance/pages/presensi/presensi_pulang.dart';
import '../../ui/constants.dart';
import '../login/blocs/Auth_bloc.dart';
import '../login/blocs/auth_repository.dart';

class Presensi extends StatefulWidget {
  final AuthBloc authBloc;
  const Presensi({Key? key, required this.authBloc}) : super(key: key);
  @override
  State<Presensi> createState() => _PresensiState();
}

class _PresensiState extends State<Presensi> {
  final AuthRepository authRepository = AuthRepository();
  AuthBloc get _authBloc => widget.authBloc;
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
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PresensiDatang(
                        authBloc: _authBloc,
                      ))),
              leading: const Image(
                image: AssetImage("assets/images/presensi.png"),
              ),
              title: const Text("Presensi Datang"),
              trailing: const Icon(Icons.arrow_forward),
            ),
            const SizedBox(height: 10),
            ListTile(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PresensiPulang(
                        authBloc: _authBloc,
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
