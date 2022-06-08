import 'package:flutter/material.dart';
import 'package:flutter_attendance/blocs/Auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../maindrawer.dart';
import '../../repository/auth_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_attendance/theme.dart';

import '../../state/auth_state.dart';
import 'bloc/profile_bloc.dart';

class ProfilePage extends StatefulWidget {
  final ProfileBloc profileBloc;
  final AuthBloc authBloc;
  const ProfilePage(
      {Key? key, required this.profileBloc, required this.authBloc})
      : super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthRepository authRepository = AuthRepository();
  ProfileBloc get _profileBloc => widget.profileBloc;
  AuthBloc get _authBloc => widget.authBloc;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Asistencia"),
        backgroundColor: Colors.indigo[400],
      ),
      drawer: Drawer(
        child: MainDrawer(
          profileBloc: _profileBloc,
          authBloc: _authBloc,
        ),
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
          bloc: _profileBloc,
          builder: (context, state) {
            if (state is DataAnggota) {
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
                      menuAccount("Tempat Tanggal Lahir", state.ttl),
                      Padding(padding: EdgeInsets.only(top: 20)),
                      menuAccount("Alamat", state.alamat),
                      Padding(padding: EdgeInsets.only(top: 20)),
                      menuAccount("Jenis Kelamin", state.jenisKelamin),
                      Padding(padding: EdgeInsets.only(top: 20)),
                      menuAccount("Jabatan", state.jabatan),
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
