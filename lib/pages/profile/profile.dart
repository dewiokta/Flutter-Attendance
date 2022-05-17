import 'package:flutter/material.dart';
import 'package:flutter_attendance/event/auth_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/Auth_bloc.dart';
import '../../maindrawer.dart';
import '../../repository/auth_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_attendance/theme.dart';

import '../../state/auth_state.dart';

class ProfilePage extends StatefulWidget {
  final AuthBloc authBloc;
  const ProfilePage({Key? key, required this.authBloc}) : super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthRepository authRepository = AuthRepository();
  AuthBloc get _authBloc => widget.authBloc;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Asistencia"),
        backgroundColor: Colors.indigo[400],
      ),
      drawer: Drawer(
        child: MainDrawer(authBloc: _authBloc),
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
          bloc: _authBloc,
          builder: (context, state) {
            if (state is AuthData) {
              return Container(
                child: SingleChildScrollView(
                    child: SafeArea(
                        child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(padding: EdgeInsets.only(top: 40)),
                      Center(
                        child: Column(
                          children: [
                            Icon(
                              CupertinoIcons.profile_circled,
                              size: 80,
                              color: purple,
                            ),
                            Padding(padding: EdgeInsets.only(top: 10)),
                            Text(
                              state.name,
                              style: text,
                            )
                          ],
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 40)),
                      menuAccount("Nama", state.name),
                      Padding(padding: EdgeInsets.only(top: 20)),
                      menuAccount("Email", state.email),
                      Padding(padding: EdgeInsets.only(top: 20)),
                      menuAccount("Alamat", "Alamat User"),
                      Padding(padding: EdgeInsets.only(top: 20)),
                      menuAccount("Jenis Kelamin", "Laki-Laki"),
                      Padding(padding: EdgeInsets.only(top: 20)),
                      menuAccount("Tanggal Lahir", "29 Februari 1997"),
                      Padding(padding: EdgeInsets.only(top: 20)),
                    ],
                  ),
                ))),
              );
            }
            return Container();
          }),
    );
  }

  Row menuAccount(String data, data1) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data,
              style: text,
            ),
            Text(
              data1,
              style: desc,
            )
          ],
        ),
      ],
    );
  }
}
