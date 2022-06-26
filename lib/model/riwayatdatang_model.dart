import 'dart:convert';

RiwayatDatangResponse riwayatDatangResponseFromJson(String str) =>
    RiwayatDatangResponse.fromJson(json.decode(str));

String riwayatDatangResponseToJson(RiwayatDatangResponse data) =>
    json.encode(data.toJson());

class RiwayatDatangResponse {
  RiwayatDatangResponse({
    required this.message,
    required this.data,
  });

  final String message;
  final List<RiwayatDatangDataResponse> data;

  factory RiwayatDatangResponse.fromJson(Map<String, dynamic> json) =>
      RiwayatDatangResponse(
        message: json["message"],
        data: List<RiwayatDatangDataResponse>.from(
            json["data"].map((x) => RiwayatDatangDataResponse.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class RiwayatDatangDataResponse {
  RiwayatDatangDataResponse({
    required this.id,
    required this.idUser,
    required this.latitude,
    required this.longtitude,
    required this.fotoDatang,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String idUser;
  final String latitude;
  final String longtitude;
  final String fotoDatang;
  final String status;
  final dynamic createdAt;
  final dynamic updatedAt;

  factory RiwayatDatangDataResponse.fromJson(Map<String, dynamic> json) =>
      RiwayatDatangDataResponse(
        id: json["id"],
        idUser: json["user_id"],
        latitude: json["latitude"],
        longtitude: json["longtitude"],
        fotoDatang: json["foto_datang"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": idUser,
        "latitude": latitude,
        "longtitude": longtitude,
        "foto_datang": fotoDatang,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
