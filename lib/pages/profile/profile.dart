import 'package:flutter/material.dart';
import 'package:flutter_attendance/pages/login/blocs/Auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../maindrawer.dart';
import '../../model/anggota_model.dart';
import '../../network/api_service.dart';
import '../login/blocs/auth_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_attendance/theme.dart';

import '../login/blocs/auth_state.dart';
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
  late BuildContext context;
  late ApiService apiService;

  @override
  void initState() {
    super.initState();
    apiService = ApiService();
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return SafeArea(
      child: FutureBuilder(
        future: apiService.getDataAnggota(),
        builder:
            (BuildContext context, AsyncSnapshot<AnggotaResponse> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                  "Something wrong with message: ${snapshot.error.toString()}"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            AnggotaDataResponse dataanggota = snapshot.data!.data;

            return _buildListView(dataanggota);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _buildListView(AnggotaDataResponse dataanggota) {
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
      body: Container(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  AnggotaDataResponse profile = dataanggota;
                  child:
                  Column(
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
                              profile.name,
                              style: text,
                            )
                          ],
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 40)),
                      menuAccount("Nama", profile.name),
                      Padding(padding: EdgeInsets.only(top: 20)),
                      menuAccount("Tempat Tanggal Lahir", profile.ttl),
                      Padding(padding: EdgeInsets.only(top: 20)),
                      menuAccount("Alamat", profile.alamat),
                      Padding(padding: EdgeInsets.only(top: 20)),
                      menuAccount("Jenis Kelamin", profile.jenisKelamin),
                      Padding(padding: EdgeInsets.only(top: 20)),
                      menuAccount("Jabatan", profile.jabatan),
                      Padding(padding: EdgeInsets.only(top: 20)),
                    ],
                  );
                  return Container();
                },
              ),
            ),
          ),
        ),
      ),
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
