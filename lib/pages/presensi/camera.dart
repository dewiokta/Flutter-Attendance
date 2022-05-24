import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_attendance/maindrawer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../blocs/Auth_bloc.dart';
import '../../theme.dart';

class CameraScreen extends StatefulWidget {
  final AuthBloc authBloc;
  const CameraScreen({Key? key, required this.authBloc}) : super(key: key);
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  AuthBloc get _authBloc => widget.authBloc;

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

  Future<void> saveData() async {
    setState(() {
      bool showSpinner = true;
    });
    var stream = new http.ByteStream(_image!.openRead());
    stream.cast();
    var length = await _image!.length();
    var uri = Uri.parse('https://attendance.putraprima.id/api/presensi-datang');
    var request = new http.MultipartRequest('POST', uri);
    request.fields['longtitude'] = _longtitude;
    request.fields['latitude'] = _latitude;
    var multiport = new http.MultipartFile('image', stream, length);
    request.files.add(multiport);
    var response = await request.send();
    print(response.stream.toString());
    if (response.statusCode == 200) {
      setState(() {
        bool showSpinner = false;
      });
      print('image uploaded');
    } else {
      print('failed');
      setState(() {
        bool showSpinner = false;
      });
    }
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
      appBar: AppBar(
        title: Text("Asistencia"),
        backgroundColor: Colors.indigo[400],
      ),
      drawer: Drawer(
        child: MainDrawer(authBloc: _authBloc),
      ),
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
              onPressed: () {
                saveData();
              },
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
