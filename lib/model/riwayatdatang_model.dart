import 'dart:convert';

RiwayatDatangResponse riwayatDatangResponseFromJson(String str) =>
    RiwayatDatangResponse.fromJson(json.decode(str));

String riwayatDatangResponseToJson(RiwayatDatangResponse data) =>
    json.encode(data.toJson());

class RiwayatDatangResponse {
  RiwayatDatangResponse({
    required this.data,
  });

  final List<RiwayatDatangDataResponse> data;

  factory RiwayatDatangResponse.fromJson(Map<String, dynamic> json) =>
      RiwayatDatangResponse(
        data: List<RiwayatDatangDataResponse>.from(
            json["data"].map((x) => RiwayatDatangDataResponse.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class RiwayatDatangDataResponse {
  RiwayatDatangDataResponse({
    required this.latitude,
    required this.longtitude,
    required this.fotoDatang,
    required this.status,
    required this.waktu,
  });

  final String latitude;
  final String longtitude;
  final String fotoDatang;
  final String status;
  final dynamic waktu;

  factory RiwayatDatangDataResponse.fromJson(Map<String, dynamic> json) =>
      RiwayatDatangDataResponse(
        latitude: json["latitude"],
        longtitude: json["longtitude"],
        fotoDatang: json["foto_datang"],
        status: json["status"],
        waktu: json["waktu"],
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longtitude": longtitude,
        "foto_datang": fotoDatang,
        "status": status,
        "waktu": waktu,
      };
}
