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
      body: FutureBuilder(
        future: apiService.getDataRiwayatDatang(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text('OKE');
          } else {
            return Text('gagal');
          }
        },
      ),
    );
  }

//   Widget _buildListView(List<RiwayatDatangDataResponse> dataRiwayatDatang) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//       child: ListView.builder(
//         itemBuilder: (context, index) {
//           // RiwayatDatangDataResponse profile = dataRiwayatDatang[index];
//           return Padding(
//             padding: const EdgeInsets.only(top: 8.0),
//             child: Card(
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Text(
//                       dataRiwayatDatang[index].createdAt,
//                       style: Theme.of(context).textTheme.headline6,
//                     ),
//                     Text(dataRiwayatDatang[index].status),
//                     Text(dataRiwayatDatang[index].latitude),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//         itemCount: dataRiwayatDatang.length,
//       ),
//     );
//   }
}
