import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';

import '../../theme.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  var _latitude = "";
  var _longtitude = "";
  var _address = "";

  File? _image;
  final imagePicker = ImagePicker();

  Future<void> _updatePosition() async {
    Position pos = await _determinePosition();
    List pm = await placemarkFromCoordinates(pos.latitude, pos.longitude);
    final image = await imagePicker.getImage(source: ImageSource.camera);
    // ignore: unused_element
    setState(() {
      _latitude = pos.latitude.toString();
      _longtitude = pos.longitude.toString();
      _address = pm[0].toString();
      _image = File(image!.path);
    });
  }

  check() {
    // final form = _key.currentState;
    // if (form.validate()) {
    //   form.save();
    //   submit();
    // }
  }
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location service are disabled!');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission == await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error('Location permission are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permission are permanently denied');
    }
    return await Geolocator.getCurrentPosition();
  }

  // Future getImage() async {
  //   final image = await imagePicker.getImage(source: ImageSource.camera);
  //   setState(() {
  //     _image = File(image!.path);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(children: [
            Center(
              child: _image == null
                  ? Text("Klik Icon Kamera untuk Presensi")
                  : Image.file(_image!, width: 250),
            ),
            const SizedBox(
              height: 10,
            ),
          ]),
          Column(
            children: [
              Padding(padding: EdgeInsets.only(top: 40)),
              menuAccount("Longtitude", _longtitude),
              Padding(padding: EdgeInsets.only(top: 20)),
              menuAccount("Latitude", _latitude),
              Padding(padding: EdgeInsets.only(top: 20)),
              menuAccount("Address", _address),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            width: 0.5,
            height: 45,
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 120, 100, 210),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {},
              child: const Text(
                "Simpan",
                style: TextStyle(
                  color: Color(0xffffffff),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _updatePosition,
        backgroundColor: const Color.fromARGB(255, 120, 100, 210),
        child: Icon(Icons.camera_alt),
      ),
    );
  }

  Row menuAccount(String data, data1) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data,
              style: text,
            ),
            Text(
              data1,
              style: desc,
            )
          ],
        ),
      ],
    );
  }
}
