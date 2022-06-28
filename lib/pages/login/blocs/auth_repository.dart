import 'dart:convert';
import 'package:flutter_attendance/model/anggota_model.dart';
import 'package:flutter_attendance/model/data_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  Future loginUser(String _email, String _password) async {
    String baseUrl = "https://attendance.putraprima.id/api/auth/login";

    try {
      var response = await http.post(Uri.parse(baseUrl), body: {
        'email': _email,
        'password': _password,
      });

      var jsonResponse = json.decode(response.body);
      return LoginAuth.fromJson(jsonResponse);
    } catch (e) {
      return e;
    }
  }

  Future userLogout(String token) async {
    String baseUrl = "https://attendance.putraprima.id/api/auth/logout";

    try {
      var response = await http.post(Uri.parse(baseUrl), headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'applcation/json'
      });

      var resbody = json.decode(response.body);
      return Logout.fromJson(resbody);
    } catch (e) {
      return e;
    }
  }

  Future getData(String token) async {
    String baseUrl = "https://attendance.putraprima.id/api/me";

    try {
      var response = await http.get(Uri.parse(baseUrl), headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'applcation/json'
      });

      var body = json.decode(response.body);
      print(body);
      return User.fromJson(body);
    } catch (e) {
      return e;
    }
  }

  Future getDataAnggota(String token) async {
    String baseUrl = "https://attendance.putraprima.id/api/anggota-detail/";

    try {
      var response = await http.get(Uri.parse(baseUrl), headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'applcation/json'
      });

      var detail = json.decode(response.body);
      // print(detail);
      return Anggota.fromJson(detail);
    } catch (e) {
      return e;
    }
  }

  Future hasToken() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences local = await _prefs;
    final String? token = local.getString("token_sanctum") ?? null;
    if (token != null) return token;
    return null;
  }

  Future setLocalToken(String token) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences local = await _prefs;
    local.setString("token_sanctum", token);
  }

  Future unsetLocalToken() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences local = await _prefs;
    var value = null;
    local.setString("token_sanctum", value);
  }

  String token = '';

  Future unsetToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = null;
    token = (prefs.getString('token_sanctum') ?? value);
    return token;
  }
}
