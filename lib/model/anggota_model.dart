import 'package:meta/meta.dart';
import 'dart:convert';

AnggotaResponse anggotaResponseFromJson(String str) =>
    AnggotaResponse.fromJson(json.decode(str));

String anggotaResponseToJson(AnggotaResponse data) =>
    json.encode(data.toJson());

class AnggotaResponse {
  AnggotaResponse({
    required this.message,
    required this.data,
  });

  final String message;
  final AnggotaDataResponse data;

  factory AnggotaResponse.fromJson(Map<String, dynamic> json) =>
      AnggotaResponse(
        message: json["message"],
        data: AnggotaDataResponse.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
      };
}

class AnggotaDataResponse {
  AnggotaDataResponse({
    required this.id,
<<<<<<< HEAD
    required this.idUser,
    required this.name,
=======
    required this.user_id,
    required this.full_name,
>>>>>>> 79b110a6d2701333591bceb05fa30360f4a476dd
    required this.alamat,
    required this.ttl,
    required this.jenis_kelamin,
    required this.jabatan,
    required this.createdAt,
<<<<<<< HEAD
  });

  final int id;
  final int idUser;
  final String name;
=======
    required this.updatedAt,
  });

  final int id;
  final int user_id;
  final String full_name;
>>>>>>> 79b110a6d2701333591bceb05fa30360f4a476dd
  final String alamat;
  final String ttl;
  final String jenis_kelamin;
  final String jabatan;
  final String createdAt;
<<<<<<< HEAD

  factory AnggotaDataResponse.fromJson(Map<String, dynamic> json) =>
      AnggotaDataResponse(
        id: json["id"],
        idUser: json["user_id"],
        name: json["full_name"],
        alamat: json["alamat"],
        ttl: json["ttl"],
        jenisKelamin: json["jenis_kelamin"],
        jabatan: json["jabatan"],
        createdAt: json["created_at"],
=======
  final String updatedAt;

  factory AnggotaDataResponse.fromJson(Map<String, dynamic> json) =>
      AnggotaDataResponse(
        id: json['id'],
        user_id: json['user_id'],
        full_name: json['full_name'],
        alamat: json['alamat'],
        ttl: json['ttl'],
        jenis_kelamin: json['jenis_kelamin'],
        jabatan: json['jabatan'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
>>>>>>> 79b110a6d2701333591bceb05fa30360f4a476dd
      );

  Map<String, dynamic> toJson() => {
        "id": id,
<<<<<<< HEAD
        "user_id": idUser,
        "full_name": name,
        "alamat": alamat,
        "ttl": ttl,
        "jenis_kelamin": jenisKelamin,
        "jabatan": jabatan,
        "created_at": createdAt,
=======
        "user_id": user_id,
        "full_name": full_name,
        "alamat": alamat,
        "ttl": ttl,
        "jenis_kelamin": jenis_kelamin,
        "jabatan": jabatan,
        "created_at": createdAt,
        "updated_at": updatedAt,
>>>>>>> 79b110a6d2701333591bceb05fa30360f4a476dd
      };
}