import 'package:flutter/material.dart';
import 'package:flutter_attendance/maindrawer.dart';
import 'package:flutter_attendance/model/riwayatdatang_model.dart';
import '../../network/api_service.dart';
import '../../ui/constants.dart';
import '../login/blocs/Auth_bloc.dart';
import '../login/blocs/auth_repository.dart';

class RiwayatDatangWidget extends StatefulWidget {
  final AuthBloc authBloc;
  const RiwayatDatangWidget({Key? key, required this.authBloc})
      : super(key: key);
  @override
  State<RiwayatDatangWidget> createState() => _RiwayatDatangWidgetState();
}

class _RiwayatDatangWidgetState extends State<RiwayatDatangWidget> {
  final AuthRepository authRepository = AuthRepository();
  AuthBloc get _authBloc => widget.authBloc;
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
        future: apiService.getRiwayatDatang(),
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
        title: const Text("Riwayat Presensi Datang"),
        backgroundColor: kPrimaryColor,
      ),
      drawer: Drawer(
        child: MainDrawer(
          authBloc: _authBloc,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: ListView.builder(
          itemBuilder: (context, index) {
            RiwayatDatangDataResponse profile = datariwayat[index];
            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              children: const <Widget>[
                                Image(
                                  image:
                                      AssetImage("assets/images/riwayat.png"),
                                  height: 40,
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(profile.waktu),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(profile.status),
                              ],
                            ),
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
                      // Text(
                      //   profile.status,
                      //   style: Theme.of(context).textTheme.headline6,
                      // ),
                      // Text(profile.waktu),
                      // Text(profile.latitude),
                    ],
                  ),
                ),
              ),
            );
          },
          itemCount: datariwayat.length,
        ),
      ),
    );
  }
}
