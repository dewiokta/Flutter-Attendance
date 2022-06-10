import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_attendance/event/auth_event.dart';
import 'package:flutter_attendance/maindrawer.dart';
import 'package:flutter_attendance/pages/profile/bloc/profile_bloc.dart';
import 'package:flutter_attendance/state/auth_state.dart';
import 'package:flutter_attendance/repository/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../blocs/Auth_bloc.dart';
import '../../theme.dart';
import 'package:path/path.dart' as path;

class PresensiDatang extends StatefulWidget {
  final AuthBloc authBloc;
  final ProfileBloc profileBloc;
  const PresensiDatang(
      {Key? key, required this.authBloc, required this.profileBloc})
      : super(key: key);
  @override
  _PresensiDatangState createState() => _PresensiDatangState();
}

class _PresensiDatangState extends State<PresensiDatang> {
  AuthBloc get _authBloc => widget.authBloc;
  ProfileBloc get _profileBloc => widget.profileBloc;

  getID(String id) {
    _user_id = id;
    // print(_user_id);
  }


  var _latitude = "";
  var _longtitude = "";
  var _address = "";
  var _status = "On Process";
  var _user_id = "";

  File? _image;
  final imagePicker = ImagePicker();
  final _key = new GlobalKey<FormState>();

  // getPref() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   setState(() {
  //     _user_id = preferences.getString("id");
  //   });
  // }

  // check() {
  //   final form = _key.currentState;
  //   submit();
  // }

  submit() async {
    String BaseUrl = "https://attendance.putraprima.id/api/presensi-datang";
    try {
      var stream = new http.ByteStream(_image!.openRead());
      var length = await _image?.length();
      var uri = Uri.parse(BaseUrl);
      var request = http.MultipartRequest("POST", uri);
      request.fields['longtitude'] = _longtitude;
      request.fields['latitude'] = _latitude;
      request.fields['user_id'] = _user_id;

      request.files.add(http.MultipartFile("foto_datang", stream, length!,
          filename: path.basename(_image!.path)));
      var response = await request.send();
      if (response.statusCode > 2) {
        print("image upload");
        setState(() {
          Navigator.pop(context);
        });
      } else {
        print("image failed");
      }
    } catch (e) {
      debugPrint("Error $e");
    }

    print(_longtitude);
    print(_user_id);
    print(_latitude);
    print(_status);
    print(_image);
  }

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
      _user_id = getID(_user_id);
    });
  }

  // Future<void> saveData() async {
  //   setState(() {
  //     bool showSpinner = true;
  //   });
  //   var stream = new http.ByteStream(_image!.openRead());
  //   stream.cast();
  //   var length = await _image!.length();
  //   var uri = Uri.parse('https://attendance.putraprima.id/api/presensi-datang');
  //   var request = new http.MultipartRequest('POST', uri);
  //   request.fields['longtitude'] = _longtitude;
  //   request.fields['latitude'] = _latitude;

  //   var multiport = new http.MultipartFile('image', stream, length);
  //   request.files.add(multiport);
  //   var response = await request.send();
  //   print(response.stream.toString());
  //   if (response.statusCode == 200) {
  //     setState(() {
  //       bool showSpinner = false;
  //     });
  //     print('image uploaded');
  //   } else {
  //     print('failed');
  //     setState(() {
  //       bool showSpinner = false;
  //     });
  //   }
  // }

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

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   getPref();
  // }

  final AuthRepository authRepository = AuthRepository();

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
              var _id = state.id.toString();
              getID(_id);
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
                        // Padding(padding: EdgeInsets.only(top: 20)),
                        // menuAccount("Status", _status),
                        // Padding(padding: EdgeInsets.only(top: 20)),
                        // menuAccount("USER ID", _id),
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
                        onPressed: () {
                          submit();
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
