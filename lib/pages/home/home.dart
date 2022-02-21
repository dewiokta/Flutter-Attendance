import 'package:flutter/material.dart';
import 'package:flutter_attendance/constants.dart';

import 'package:flutter_attendance/pages/profile/profile.dart';
import 'homeMenu.dart';
import '../../maindrawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Asistencia"),
        backgroundColor: kPrimaryColor,
      ),
      drawer: Drawer(
        child: MainDrawer(),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            SizedBox(height: 20),
            HomeMenu(
              text: "Home Page",
              icon: "Icons.",
              press: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HomePage())),
            ),
            HomeMenu(
              text: "Profile",
              icon: "assets/icons/Bell.svg",
              press: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => ProfilePage())),
            ),
            HomeMenu(
              text: "Presensi",
              icon: "assets/icons/Settings.svg",
              press: () {},
            ),
            HomeMenu(
              text: "Jadwal Presensi",
              icon: "assets/icons/Question mark.svg",
              press: () {},
            ),
            HomeMenu(
              text: "Riwayat Presensi",
              icon: "assets/icons/Log out.svg",
              press: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => ProfilePage())),
            ),
            HomeMenu(
              text: "Log Out",
              icon: "assets/icons/Log out.svg",
              press: () {},
            ),
          ],
        ),
      ),
    );
  }
}
