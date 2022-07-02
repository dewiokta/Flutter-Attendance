import 'dart:io';

import 'package:cool_alert/cool_alert.dart';
import 'package:dio/dio.dart';
import 'package:flutter_attendance/model/presensidatang_model.dart';
import 'package:flutter_attendance/model/presensipulang_model.dart';
import 'package:flutter_attendance/pages/riwayat/list_riwayat.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/anggota_model.dart';
import '../model/riwayatdatang_model.dart';
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

  Future<PresensiDatangModel?> createPresensiDatang(String latitude,
      String longtitude, File? foto_datang, String status) async {
    try {
      final token = await _loadToken();
      final String foto = foto_datang!.path.split('/').last;
      FormData formData = FormData.fromMap({
        'latitude': double.parse(latitude).toString(),
        'longtitude': double.parse(longtitude).toString(),
        'foto_datang':
            await MultipartFile.fromFile(foto_datang.path, filename: foto),
        'status': status
      });
      final response = await Dio().post(
        Endpoint.createPresensiDatang,
        data: formData,
        options: Options(
            followRedirects: true,
            validateStatus: (status) => true,
            headers: {
              "Accept": "application/json",
              "authorization": "Bearer $token"
            }),
      );
      var _response = response.data.toString();
      print(response.statusCode);
      print(response.toString());
      if (response.statusMessage == null) {
        print("gagal");
        return null;
      } else if (response.statusMessage ==
          "Sudah Absen Tidak Perlu Absen Lagi") {
      } else {
        // print("data berhasil diupload");
        return PresensiDatangModel(
            latitude:
                double.tryParse(response.data['latitude'].toString()) ?? 0,
            longtitude:
                double.tryParse(response.data['longtitude'].toString()) ?? 0,
            fotoDatang: response.data['foto_datang'],
            status: response.data['status']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<PresensiPulangModel?> createPresensiPulang(String latitude,
      String longtitude, File? foto_pulang, String status) async {
    try {
      final token = await _loadToken();
      final String foto = foto_pulang!.path.split('/').last;
      FormData formData = FormData.fromMap({
        'latitude': double.parse(latitude).toString(),
        'longtitude': double.parse(longtitude).toString(),
        'foto_pulang':
            await MultipartFile.fromFile(foto_pulang.path, filename: foto),
        'status': status
      });
      final response = await Dio().post(
        Endpoint.createPresensiPulang,
        data: formData,
        options: Options(
            followRedirects: true,
            validateStatus: (status) => true,
            headers: {
              "Accept": "application/json",
              "authorization": "Bearer $token"
            }),
      );
      var _response = response.data.toString();
      print(response.statusCode);
      print(response.toString());
      if (response.statusMessage == null) {
        print("gagal");
        return null;
      } else {
        // print("data berhasil diupload");
        return PresensiPulangModel(
            latitude:
                double.tryParse(response.data['latitude'].toString()) ?? 0,
            longtitude:
                double.tryParse(response.data['longtitude'].toString()) ?? 0,
            fotoPulang: response.data['foto_pulang'],
            status: response.data['status']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<RiwayatDatangResponse> getRiwayatDatang() async {
    final token = await _loadToken();
    final _response = await _dio.get(Endpoint.createPresensiDatang,
        options: Options(headers: {"authorization": "Bearer $token"}));
    print(_response);
    final ListRiwayat = RiwayatDatangResponse.fromJson(_response.data);
    return ListRiwayat;
  }
}
