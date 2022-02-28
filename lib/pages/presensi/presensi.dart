// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_attendance/constants.dart';
import 'package:flutter_attendance/maindrawer.dart';
import 'package:flutter_attendance/pages/presensi/presensi_hadir.dart';
import 'package:flutter_attendance/pages/presensi/presensi_pulang.dart';

class Presensi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Presensi"),
        backgroundColor: kPrimaryColor,
      ),
      drawer: Drawer(
        child: MainDrawer(),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => PresensiHadir())),
              leading: const Image(
                image: AssetImage("assets/images/presensi.png"),
              ),
              title: Text("Presensi Datang"),
              trailing: Icon(Icons.arrow_forward),
            ),
            const SizedBox(height: 10),
            ListTile(
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => PresensiPulang())),
              leading: const Image(
                image: AssetImage("assets/images/riwayat.png"),
              ),
              title: const Text("Presensi Pulang"),
              trailing: const Icon(Icons.arrow_forward),
            ),
            const SizedBox(height: 450),
            FlatButton(
              onPressed: () {},
              child: const Text(
                "Presensi",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              color: kPrimaryColor,
              minWidth: 400,
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
