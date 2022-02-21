import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_attendance/components/date_picker.dart';
import 'package:flutter_attendance/pages/login/login_screen.dart';
import 'package:flutter_attendance/pages/profile/profile.dart';

import 'pages/home/home.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MaindrawState createState() => _MaindrawState();
}

class _MaindrawState extends State<MainDrawer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        child: Padding(
          padding: EdgeInsets.only(top: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 80,
                backgroundColor: Color(00000),
                child: ClipOval(
                  child: new SizedBox(
                    width: 160.0,
                    height: 130.0,
                    child: Image.asset(
                      "assets/images/user.png",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 2.0,
              ),
              Text(
                " Nama User ",
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
            ],
          ),
        ),
      ),
      SizedBox(
        height: 20.0,
      ),
      ListTile(
        onTap: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => HomePage())),
        leading: Icon(
          Icons.home,
          color: Colors.indigo[400],
        ),
        title: Text("Home"),
      ),
      ListTile(
        onTap: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ProfilePage())),
        leading: Icon(
          Icons.person,
          color: Colors.indigo[400],
        ),
        title: Text("Profile Account"),
      ),
      ListTile(
        onTap: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => HomePage())),
        leading: Icon(
          Icons.camera_enhance_rounded,
          color: Colors.indigo[400],
        ),
        title: Text("Presensi"),
      ),
      ListTile(
        onTap: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => HomePage())),
        leading: Icon(
          Icons.access_time_filled_outlined,
          color: Colors.indigo[400],
        ),
        title: Text("Jadwal Presensi"),
      ),
      ListTile(
        onTap: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => DatePickerWidget())),
        leading: Icon(
          Icons.history,
          color: Colors.indigo[400],
        ),
        title: Text("Riwayat Presensi"),
      ),
      ListTile(
        onTap: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => LoginScreen())),
        leading: Icon(
          Icons.logout,
          color: Colors.indigo[400],
        ),
        title: Text("Sign Out"),
      ),
    ]);
  }
}
