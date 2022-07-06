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
    required this.idUser,
    required this.name,
    required this.alamat,
    required this.ttl,
    required this.jenisKelamin,
    required this.jabatan,
    required this.createdAt,
  });

  final int id;
  final int idUser;
  final String name;
  final String alamat;
  final String ttl;
  final String jenisKelamin;
  final String jabatan;
  final String createdAt;

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
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": idUser,
        "full_name": name,
        "alamat": alamat,
        "ttl": ttl,
        "jenis_kelamin": jenisKelamin,
        "jabatan": jabatan,
        "created_at": createdAt,
      };
}
