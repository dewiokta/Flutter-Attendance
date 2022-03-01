import 'package:flutter/material.dart';
import 'package:flutter_attendance/components/rounded_button.dart';
import 'package:flutter_attendance/constants.dart';
import 'package:flutter_attendance/maindrawer.dart';
import 'package:flutter_attendance/pages/riwayat/list_riwayat.dart';
import 'package:getwidget/getwidget.dart';

import '../../blocs/Auth_bloc.dart';
import '../../repository/auth_repository.dart';

class RiwayatWidget extends StatefulWidget {
  final AuthBloc authBloc;
  const RiwayatWidget({Key? key, required this.authBloc}) : super(key: key);
  @override
  State<RiwayatWidget> createState() => _RiwayatWidgetState();
}

class _RiwayatWidgetState extends State<RiwayatWidget> {
  DateTimeRange dateRange =
      DateTimeRange(start: DateTime(2022, 2, 15), end: DateTime(2022, 3, 15));
  final AuthRepository authRepository = AuthRepository();
  AuthBloc get _authBloc => widget.authBloc;
  @override
  Widget build(BuildContext context) {
    final start = dateRange.start;
    final end = dateRange.end;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Riwayat Presensi"),
        backgroundColor: kPrimaryColor,
      ),
      drawer: Drawer(
        child: MainDrawer(authBloc: _authBloc),
      ),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.all(20),
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
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 140,
                      child: GFButton(
                        onPressed: pickDate,
                        text: "${start.year}/${start.month}/${start.day}",
                        shape: GFButtonShape.square,
                        type: GFButtonType.outline2x,
                        color: kPrimaryColor,
                      ),
                    ),
                    const SizedBox(
                      child: Icon(Icons.arrow_right),
                    ),
                    SizedBox(
                      width: 140,
                      child: GFButton(
                        onPressed: pickDate,
                        text: "${end.year}/${end.month}/${end.day}",
                        shape: GFButtonShape.square,
                        type: GFButtonType.outline2x,
                        color: kPrimaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: const [
                    Text(
                      "see all",
                      style: TextStyle(fontSize: 15, color: kPrimaryColor),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                SizedBox(height: 20),
                const ListRiwayat(),
                SizedBox(height: 20),
                const ListRiwayat(),
                SizedBox(height: 20),
                const ListRiwayat(),
                SizedBox(height: 20),
                const ListRiwayat(),
                SizedBox(height: 20),
                const ListRiwayat(),
                SizedBox(height: 20),
                const ListRiwayat(),
                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future pickDate() async {
    DateTimeRange? newDateRange = await showDateRangePicker(
      context: context,
      initialDateRange: dateRange,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (newDateRange == null) return; //press X

    setState(() => dateRange = newDateRange);
  }
}
