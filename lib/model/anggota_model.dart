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
    required this.name,
    required this.alamat,
    required this.ttl,
    required this.jenisKelamin,
    required this.jabatan,
  });

  final String name;
  final String alamat;
  final String ttl;
  final String jenisKelamin;
  final String jabatan;

  factory AnggotaDataResponse.fromJson(Map<String, dynamic> json) =>
      AnggotaDataResponse(
        name: json["name"],
        alamat: json["alamat"],
        ttl: json["ttl"],
        jenisKelamin: json["jenisKelamin"],
        jabatan: json["jabatan"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "alamat": alamat,
        "ttl": ttl,
        "jenisKelamin": jenisKelamin,
        "jabatan": jabatan,
      };
}
