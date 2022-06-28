import 'package:flutter/material.dart';
import 'package:flutter_attendance/components/rounded_button.dart';
import 'package:flutter_attendance/constants.dart';
import 'package:flutter_attendance/maindrawer.dart';
import 'package:flutter_attendance/pages/profile/bloc/profile_bloc.dart';
import 'package:flutter_attendance/pages/riwayat/list_riwayat.dart';
import 'package:getwidget/getwidget.dart';

import '../../model/riwayatdatang_model.dart';
import '../../network/api_service.dart';
import '../login/blocs/Auth_bloc.dart';
import '../login/blocs/auth_repository.dart';

class RiwayatWidget extends StatefulWidget {
  final AuthBloc authBloc;
  final ProfileBloc profileBloc;
  const RiwayatWidget(
      {Key? key, required this.authBloc, required this.profileBloc})
      : super(key: key);
  @override
  State<RiwayatWidget> createState() => _RiwayatWidgetState();
}

class _RiwayatWidgetState extends State<RiwayatWidget> {
  final AuthRepository authRepository = AuthRepository();
  AuthBloc get _authBloc => widget.authBloc;
  ProfileBloc get _profileBloc => widget.profileBloc;
  late BuildContext context;
  late ApiService apiService;
  @override
  void initState() {
    super.initState();
    apiService = ApiService();
  }

  Widget build(BuildContext context) {
    this.context = context;
    return SafeArea(
      child: FutureBuilder(
        future: apiService.getDataRiwayatDatang(),
        builder: (BuildContext context,
            AsyncSnapshot<RiwayatDatangResponse> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                  "Something wrong with message: ${snapshot.error.toString()}"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            List<RiwayatDatangDataResponse>? datariwayat = snapshot.data?.data;
            return _buildListView(datariwayat!);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _buildListView(List<RiwayatDatangDataResponse> datariwayat) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Riwayat Presensi"),
        backgroundColor: kPrimaryColor,
      ),
      drawer: Drawer(
        child: MainDrawer(authBloc: _authBloc, profileBloc: _profileBloc),
      ),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            child: ListView.builder(
              itemBuilder: (context, index) {
                RiwayatDatangDataResponse state = datariwayat[index];
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Row(
                            children: const [
                              Text(
                                "Detail Riwayat Mingguan",
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: const <Widget>[
                                  Image(
                                    image:
                                        AssetImage("assets/images/riwayat.png"),
                                    height: 50,
                                  )
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Text(
                                    state.waktu,
                                  ),
                                ],
                              ),
                              Column(
                                children: const <Widget>[
                                  Text(
                                    "Datang",
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Text(
                                    state.status,
                                  ),
                                ],
                              ),
                              Column(
                                children: const <Widget>[
                                  Image(
                                    image: AssetImage(
                                        "assets/images/centang-riwayat.png"),
                                    height: 20,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: datariwayat.length,
            ),
          ),
        ],
      ),
    );
  }
}
