import 'dart:io';
import 'package:intl/intl.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_attendance/maindrawer.dart';
import 'package:flutter_attendance/model/presensipulang_model.dart';
import 'package:flutter_attendance/network/api_service.dart';
import 'package:flutter_attendance/pages/login/blocs/auth_event.dart';
import 'package:flutter_attendance/pages/login/blocs/auth_state.dart';
import 'package:flutter_attendance/pages/presensi/presensi.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'dart:async';
import '../../ui/theme.dart';
import '../login/blocs/Auth_bloc.dart';

class PresensiPulang extends StatefulWidget {
  final AuthBloc authBloc;
  const PresensiPulang({Key? key, required this.authBloc}) : super(key: key);
  @override
  _PresensiPulangState createState() => _PresensiPulangState();
}

class _PresensiPulangState extends State<PresensiPulang> {
  PresensiPulangModel? presensi;
  AuthBloc get _authBloc => widget.authBloc;

  var _latitude = "";
  var _longtitude = "";
  var _address = "";
  var _status = "";
  var _waktu ="";
  var _foto_datang = "";

  File? _image;
  final imagePicker = ImagePicker();

  Future<void> _updatePosition() async {
    Position pos = await _determinePosition();
    DateTime now = DateTime.now();
    String time = DateFormat.Hms().format(now);
    List pm = await placemarkFromCoordinates(pos.latitude, pos.longitude);
    final image = await imagePicker.getImage(source: ImageSource.camera);
    // ignore: unused_element
    setState(() {
      _latitude = pos.latitude.toString();
      _longtitude = pos.longitude.toString();
      _address = pm[0].toString();
      _image = File(image!.path);
      _waktu = time;
      if (_waktu == "16:00:00" || _waktu == "15:00:00") {
        _status = "On Time";
      }else{
        _status = "Late";
      }
    });
  }

  Future<void> submit() async {
    PresensiPulangModel? result = await ApiService()
        .createPresensiPulang(_latitude, _longtitude, _image, _status);
    print(_longtitude);
    print(_latitude);
    print(_status);
    print(_image);
    if (result != null) {
      setState(() {
        presensi = result;
      });
    }
    CoolAlert.show(
      context: context,
      type: CoolAlertType.success,
      text: 'Presensi Sukses! Anda tidak perlu presensi lagi !',
    ).then((value) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Presensi(authBloc: _authBloc)));
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Asistencia"),
        backgroundColor: Colors.indigo[400],
      ),
      drawer: Drawer(
        child: MainDrawer(authBloc: _authBloc),
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
          bloc: _authBloc,
          builder: (context, state) {
            if (state is AuthHasToken) {
              _authBloc.add(GetDataWithToken(state.token));
              return Container();
            }
            if (state is AuthData) {
              return Container(
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(children: [
                      Center(
                        child: _image == null
                            ? const Text("Klik Icon Kamera untuk Presensi")
                            : Image.file(_image!, width: 250),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ]),
                    Column(
                      children: [
                        const Padding(padding: const EdgeInsets.only(top: 20)),
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
                          backgroundColor:
                              const Color.fromARGB(255, 120, 100, 210),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: submit,
                        child: const Text(
                          "Simpan",
                          style: TextStyle(
                            color: Color(0xffffffff),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
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
        child: const Icon(Icons.camera_alt),
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
