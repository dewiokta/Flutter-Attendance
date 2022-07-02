import 'package:flutter/material.dart';
import 'package:flutter_attendance/pages/login/blocs/Auth_bloc.dart';
import '../../maindrawer.dart';
import '../../model/anggota_model.dart';
import '../../network/api_service.dart';
import '../login/blocs/auth_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_attendance/theme.dart';
import 'bloc/profile_bloc.dart';

class ProfilePage extends StatefulWidget {
  final AuthBloc authBloc;
  const ProfilePage({Key? key, required this.authBloc}) : super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthRepository authRepository = AuthRepository();
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
      child: FutureBuilder<AnggotaResponse?>(
        future: apiService.getDataAnggota(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            AnggotaResponse? dataanggota = snapshot.data;
            if (dataanggota != null) {
              AnggotaDataResponse anggotaData = dataanggota.data;
              return Scaffold(
                appBar: AppBar(
                  title: Text("Asistencia"),
                  backgroundColor: Colors.indigo[400],
                ),
                drawer: Drawer(
                  child: MainDrawer(
                    authBloc: _authBloc,
                  ),
                ),
                body: Container(
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
                                    anggotaData.name,
                                    style: text,
                                  )
                                ],
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(top: 40)),
                            menuAccount("Nama", anggotaData.name),
                            Padding(padding: EdgeInsets.only(top: 20)),
                            menuAccount(
                                "Tempat Tanggal Lahir", anggotaData.ttl),
                            Padding(padding: EdgeInsets.only(top: 20)),
                            menuAccount("Alamat", anggotaData.alamat),
                            Padding(padding: EdgeInsets.only(top: 20)),
                            menuAccount(
                                "Jenis Kelamin", anggotaData.jenisKelamin),
                            Padding(padding: EdgeInsets.only(top: 20)),
                            menuAccount("Jabatan", anggotaData.jabatan),
                            Padding(padding: EdgeInsets.only(top: 20)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
          }
          return const Center(child: CircularProgressIndicator());
        },
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
