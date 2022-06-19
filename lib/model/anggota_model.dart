import 'dart:convert';

AnggotaResponse AnggotaResponseFromJson(String str) =>
    AnggotaResponse.fromJson(json.decode(str));

String AnggotaResponseToJson(AnggotaResponse data) =>
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
  final int id;
  final int idUser;
  final String name;
  final String alamat;
  final String ttl;
  final String jenisKelamin;
  final String jabatan;
  final String createdAt;

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

  factory AnggotaDataResponse.fromJson(Map<String, dynamic> json) =>
      AnggotaDataResponse(
        id: json["id"],
        idUser: json["user_id"],
        name: json["name"],
        alamat: json["alamat"],
        ttl: json["ttl"],
        jenisKelamin: json["jenisKelamin"],
        jabatan: json["jabatan"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": idUser,
        "name": name,
        "alamat": alamat,
        "ttl": ttl,
        "jenisKelamin": jenisKelamin,
        "jabatan": jabatan,
        "created_at": createdAt,
      };
}
