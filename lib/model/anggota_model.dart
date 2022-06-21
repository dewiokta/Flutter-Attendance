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
  final List<AnggotaDataResponse> data;

  factory AnggotaResponse.fromJson(Map<String, dynamic> json) =>
      AnggotaResponse(
        message: json["message"],
        data: List<AnggotaDataResponse>.from(
            json["data"].map((x) => AnggotaDataResponse.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class AnggotaDataResponse {
  AnggotaDataResponse({
    required this.id,
    required this.user_id,
    required this.full_name,
    required this.alamat,
    required this.ttl,
    required this.jenis_kelamin,
    required this.jabatan,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final int user_id;
  final String full_name;
  final String alamat;
  final String ttl;
  final String jenis_kelamin;
  final String jabatan;
  final String createdAt;
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
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": user_id,
        "full_name": full_name,
        "alamat": alamat,
        "ttl": ttl,
        "jenis_kelamin": jenis_kelamin,
        "jabatan": jabatan,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}