import 'package:flutter/material.dart';
import 'package:flutter_attendance/maindrawer.dart';
import 'package:flutter_attendance/pages/riwayat/riwayat_datang.dart';
import 'package:flutter_attendance/pages/riwayat/riwayat_pulang.dart';

import '../../ui/constants.dart';
import '../login/blocs/Auth_bloc.dart';
import '../login/blocs/auth_repository.dart';

class RiwayatWidget extends StatefulWidget {
  final AuthBloc authBloc;
  const RiwayatWidget({Key? key, required this.authBloc}) : super(key: key);
  @override
  State<RiwayatWidget> createState() => _RiwayatWidgetState();
}

class _RiwayatWidgetState extends State<RiwayatWidget> {
  final AuthRepository authRepository = AuthRepository();
  AuthBloc get _authBloc => widget.authBloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Riwayat"),
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
                  builder: (context) => RiwayatDatangWidget(
                        authBloc: _authBloc,
                      ))),
              title: const Text("Riwayat Datang"),
              trailing: const Icon(Icons.arrow_forward),
            ),
            const SizedBox(height: 10),
            ListTile(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => RiwayatPulangWidget(
                        authBloc: _authBloc,
                      ))),
              title: const Text("Riwayat Pulang"),
              trailing: const Icon(Icons.arrow_forward),
            ),
          ],
        ),
      ),
    );
  }
}
