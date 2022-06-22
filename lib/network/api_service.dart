import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_attendance/model/presensidatang_model.dart';
import 'package:flutter_attendance/pages/profile/bloc/profile_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/anggota_model.dart';
import 'endpoint.dart';

class ApiService {
  final _dio = Dio();
  String token = '';

  Future _loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token_sanctum') ?? '');
    return token;
  }

  Future<AnggotaResponse?> getDataAnggota() async {
    AnggotaResponse? listAnggota;
    final token = await _loadToken();
    try {
      final _response = await _dio.get(Endpoint.getDataAnggota,
          options: Options(headers: {"authorization": "Bearer $token"}));
      print(_response);
      listAnggota = AnggotaResponse.fromJson(_response.data);
      return listAnggota;
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(e.message);
      }
    }
    return listAnggota;
  }

  Future<PresensiDatangModel?> createPresensiDatang(
      int user_id,
      double latitude,
      double longtitude,
      String foto_datang,
      String status) async {
    try {
      final token = await _loadToken();
      final response = await Dio().post(
        Endpoint.createPresensiPulang,
        data: {
          'user_id': user_id,
          'latitude': latitude,
          'longtitude': longtitude,
          'foto_datang': foto_datang,
          'status': status
        },
        options: Options(
            followRedirects: true,
            validateStatus: (status) => true,
            // validateStatus: (status) {
            //   return status! < 500;
            // },
            headers: {
              "Accept": "application/json",
              "authorization": "Bearer $token"
            }),
      );
      var _response = response.data.toString();
      print(response.statusMessage);
      print(response.statusCode);
      if (response.statusMessage == null) {
        print("gagal");
        return null;
      } else {
        // print("data berhasil diupload");
        return PresensiDatangModel(
            userId: int.tryParse(response.data['user_id'].toString()) ?? 0,
            latitude: response.data['latitude'],
            longtitude: response.data['longtitude'],
            fotoDatang: response.data['foto_datang'],
            status: response.data['status']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
