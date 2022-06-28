import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_attendance/maindrawer.dart';
import 'package:flutter_attendance/model/presensidatang_model.dart';
import 'package:flutter_attendance/model/presensipulang_model.dart';
import 'package:flutter_attendance/network/api_service.dart';
import 'package:flutter_attendance/pages/login/blocs/auth_event.dart';
import 'package:flutter_attendance/pages/login/blocs/auth_state.dart';
import 'package:flutter_attendance/pages/profile/bloc/profile_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../login/blocs/Auth_bloc.dart';
import '../../dio_service/service.dart';
import '../../theme.dart';

class PresensiPulang extends StatefulWidget {
  final AuthBloc authBloc;
  final ProfileBloc profileBloc;
  const PresensiPulang(
      {Key? key, required this.authBloc, required this.profileBloc})
      : super(key: key);
  @override
  _PresensiPulangState createState() => _PresensiPulangState();
}

class _PresensiPulangState extends State<PresensiPulang> {
  PresensiDatangModel? presensi;
  AuthBloc get _authBloc => widget.authBloc;
  ProfileBloc get _profileBloc => widget.profileBloc;

  // getID(String id) {
  //   _user_id = id;
  //   // print(_user_id);
  // }

  var _latitude = "";
  var _longtitude = "";
  var _address = "";
  var _status = "On Process";
  // var _user_id = "";
  var _foto_datang = "";
  // var image = "";

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
      _status;
      // _foto_datang;
      // _user_id = getID(_user_id);
    });
    // print(_longtitude);
    // print(_user_id);
    // print(_latitude);
    // print(_status);
    // print(_image);
  }

  Future<void> _submit() async {
    PresensiDatangModel? result = await ApiService()
        .createPresensiDatang(_latitude, _longtitude, _image, _status);
    print(_longtitude);
    print(_latitude);
    print(_status);
    print(_image);
    if (result != null) {
      setState(() {
        presensi = result;
        // print(presensi);
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
        child: MainDrawer(authBloc: _authBloc, profileBloc: _profileBloc),
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
          bloc: _authBloc,
          builder: (context, state) {
            if (state is AuthHasToken) {
              _authBloc.add(GetDataWithToken(state.token));
              return Container();
            }
            if (state is AuthData) {
              // var _id = state.id.toString();
              // print(_id);
              // getID(_id);
              return Container(
                child: ListView(
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
                        Padding(padding: EdgeInsets.only(top: 20)),
                        menuAccount("Status", _status),
                        // Padding(padding: EdgeInsets.only(top: 20)),
                        // menuAccount("User id", _user_id),
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
                          backgroundColor:
                              const Color.fromARGB(255, 120, 100, 210),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: _submit,
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
              );
            }
            return Container();
          }),
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
