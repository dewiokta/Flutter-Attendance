import 'package:flutter/material.dart';

import '../../maindrawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Asistencia"),
        backgroundColor: Colors.indigo[400],
      ),
      drawer: Drawer(
        child: MainDrawer(),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.all(12),
        physics: BouncingScrollPhysics(),
        children: [
          Container(height: 35),
          userTile(),
          divider(),
          colorTiles(),
          divider(),
        ],
      ),
    );
  }

  Widget userTile() {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage("assets/images/logo.png"),
      ),
      title: Text(
        "Nama User",
      ),
      subtitle: Text(" Anggota "),
    );
  }

  Widget divider() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Divider(
        thickness: 1.5,
      ),
    );
  }

  Widget colorTiles() {
    return Column(
      children: [
        colorTile(Icons.person_outline, Colors.deepPurple, "Profile"),
        colorTile(Icons.settings_outlined, Colors.blue, "Presensi Hadir"),
        colorTile(Icons.credit_card, Colors.pink, "Presensi Pulang"),
        colorTile(Icons.favorite_border, Colors.orange, "Jadwal"),
        colorTile(Icons.favorite_border, Colors.orange, "Riwayat Presensi"),
        colorTile(Icons.favorite_border, Colors.orange, "Log Out"),
      ],
    );
  }

  Widget colorTile(IconData icon, Color color, String text,
      {bool blackAndWhite = false}) {
    Color pickedColor = Color(0xfff3f4fe);
    return ListTile(
      leading: Container(
        child: Icon(icon, color: color),
        height: 45,
        width: 45,
        decoration: BoxDecoration(
          color: blackAndWhite ? pickedColor : color.withOpacity(0.09),
          borderRadius: BorderRadius.circular(18),
        ),
      ),
      title: Text(
        text,
      ),
      trailing: Icon(Icons.arrow_forward_ios, color: Colors.black, size: 20),
      onTap: () {},
    );
  }
}
