import 'dart:html';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_attendance/constants.dart';
import 'package:flutter/services.dart';
import 'package:flutter_attendance/maindrawer.dart';
import 'package:flutter_attendance/pages/presensi/camera.dart';

class PresensiHadir extends StatefulWidget {
  @override
  State<PresensiHadir> createState() => _PresensiHadirState();
}

class _PresensiHadirState extends State<PresensiHadir> {
  String cameraStatus = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Presensi Hadir"),
        backgroundColor: kPrimaryColor,
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(20),
            child: Row(
              children: [
                Column(
                  children: const <Widget>[
                    Image(
                      image: AssetImage("assets/images/doc.png"),
                      height: 60,
                    )
                  ],
                ),
                Column(
                  children: const <Widget>[
                    Text(
                      "Presensi Hadir",
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      "10.10 AM",
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 470),
          FlatButton(
            onPressed: () async {
              PermissionStatus cameraStatus =
                  await Permission.camera.request();

              if (cameraStatus == PermissionStatus.granted) {
                //open kamera
              }

              if (cameraStatus == PermissionStatus.denied) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("You need to provide camera permission")));
              }
            },
            child: const Text(
              "Presensi",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            color: kPrimaryColor,
            minWidth: 200,
            height: 50,
          ),
        ],
      ),
    );
  }
}
