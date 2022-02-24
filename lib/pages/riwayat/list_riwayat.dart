import 'package:flutter/material.dart';

class ListRiwayat extends StatefulWidget {
  const ListRiwayat({
    Key? key,
  }) : super(key: key);

  @override
  State<ListRiwayat> createState() => _ListRiwayatState();
}

class _ListRiwayatState extends State<ListRiwayat> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: const <Widget>[
              Image(
                image: AssetImage("assets/images/riwayat.png"),
                height: 50,
              )
            ],
          ),
          Column(
            children: const <Widget>[
              Text("Senin",),
            ],
          ),
          Column(
            children: const <Widget>[
              Text("Hadir",),
            ],
          ),
          Column(
            children: const <Widget>[
              Text("08.00",),
            ],
          ),
          Column(
            children: const <Widget>[
              Text("Pulang",),
            ],
          ),
          Column(
            children: const <Widget>[
              Text("16.00",),
            ],
          ),
          Column(
            children: const <Widget>[
              Image(
                image: AssetImage("assets/images/centang-riwayat.png"),
                height: 20,
              )
            ],
          ),
        ],
      ),
      
    );
  }
}
