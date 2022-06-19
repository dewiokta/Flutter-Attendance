import 'package:flutter_attendance/model/presensidatang_model.dart';
import 'package:flutter_attendance/model/presensipulang_model.dart';
import 'package:dio/dio.dart';

abstract class Services {
  static Future<PresensiDatangModel?> createPresensiDatang(
      String user_id,
      String latitude,
      String longtitude,
      String foto_datang,
      String status) async {
    try {
      var response = await Dio()
          .post("https://attendance.putraprima.id/api/presensi-datang/",
              data: {
                'user_id': int.tryParse(user_id),
                'latitude': double.tryParse(latitude),
                'longtitude': double.tryParse(longtitude),
                'foto_datang': foto_datang,
                'status': status
              },
              options: Options(
                  followRedirects: false,
                  validateStatus: (status) {
                    return status! < 500;
                  }));
      if (response.statusMessage != null) {
        return PresensiDatangModel(
            userId: int.tryParse(response.data['user_id'].toString()) ?? 0,
            latitude:
                double.tryParse(response.data['latitude'].toString()) ?? 0,
            longtitude:
                double.tryParse(response.data['longtitude'].toString()) ?? 0,
            fotoDatang: response.data['foto_datang'],
            status: response.data['status']);
      }
      return null;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<PresensiPulangModel?> createPresensiPulang(
      String user_id,
      String latitude,
      String longtitude,
      String foto_pulang,
      String status) async {
    try {
      var response = await Dio()
          .post("https://attendance.putraprima.id/api/presensi-pulang/", data: {
        'user_id': user_id,
        'latitude': latitude,
        'longtitude': longtitude,
        'foto_datang': foto_pulang,
        'status': status
      });
      if (response.statusCode == 201) {
        return PresensiPulangModel(
            latitude: response.data['latitude'],
            longtitude: response.data['longtitude'],
            foto_pulang: response.data['foto_pulang'],
            status: response.data['status'],
            user_id: response.data['user_id']);
      }
      return null;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
