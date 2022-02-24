import 'package:flutter/material.dart';
import 'package:flutter_attendance/constants.dart';
import 'package:flutter_attendance/maindrawer.dart';

class PresensiHadir extends StatefulWidget {
  @override
  State<PresensiHadir> createState() => _PresensiHadirState();
}

class _PresensiHadirState extends State<PresensiHadir> {
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
        ],
      ),
    );
  }
}
