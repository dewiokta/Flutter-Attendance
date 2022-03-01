import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_attendance/pages/profile/card_item.dart';
import 'package:flutter_attendance/pages/profile/stack_contanier.dart';

import '../../blocs/Auth_bloc.dart';
import '../../maindrawer.dart';
import '../../repository/auth_repository.dart';

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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            StackContainer(),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => CardItem(),
              shrinkWrap: true,
              itemCount: 4,
            )
          ],
        ),
      ),
    );
  }
}
