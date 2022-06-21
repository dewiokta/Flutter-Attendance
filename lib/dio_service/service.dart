import 'package:flutter_attendance/model/presensidatang_model.dart';
import 'package:flutter_attendance/model/presensipulang_model.dart';
import 'package:dio/dio.dart';

abstract class Services {
  static Future<PresensiDatangModel?> createPresensiDatang(
      int user_id,
      double latitude,
      double longtitude,
      String foto_datang,
      String status) async {
    try {
      var response = await Dio()
          .post("https://attendance.putraprima.id/api/presensi-datang/",
              data: {
                'user_id': user_id,
                'latitude': latitude,
                'longtitude': longtitude,
                'foto_datang': foto_datang,
                'status': status
              },
              options: Options(
                  followRedirects: true,
                  validateStatus: (status) {
                    return status! < 500;
                  },
                  headers: {"Accept": "application/json"}));
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
            latitude: double.tryParse(response.data['latitude']) ?? 0,
            longtitude: double.tryParse(response.data['longtitude']) ?? 0,
            fotoDatang: response.data['foto_datang'],
            status: response.data['status']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // static Future<PresensiPulangModel?> createPresensiPulang(
  //     String user_id,
  //     String latitude,
  //     String longtitude,
  //     String foto_pulang,
  //     String status) async {
  //   try {
  //     var response = await Dio()
  //         .post("https://attendance.putraprima.id/api/presensi-pulang/", data: {
  //       'user_id': user_id,
  //       'latitude': latitude,
  //       'longtitude': longtitude,
  //       'foto_datang': foto_pulang,
  //       'status': status
  //     });
  //     if (response.statusCode == 201) {
  //       return PresensiPulangModel(
  //           latitude: response.data['latitude'],
  //           longtitude: response.data['longtitude'],
  //           foto_pulang: response.data['foto_pulang'],
  //           status: response.data['status'],
  //           user_id: response.data['user_id']);
  //     }
  //     return null;
  //   } catch (e) {
  //     throw Exception(e.toString());
  //   }
  // }
}
