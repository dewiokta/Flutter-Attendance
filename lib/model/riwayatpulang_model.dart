import 'dart:convert';

RiwayatPulangResponse RiwayatPulangResponseFromJson(String str) =>
    RiwayatPulangResponse.fromJson(json.decode(str));

String RiwayatPulangResponseToJson(RiwayatPulangResponse data) =>
    json.encode(data.toJson());

class RiwayatPulangResponse {
  RiwayatPulangResponse({
    required this.data,
  });

  final List<RiwayatPulangDataResponse> data;

  factory RiwayatPulangResponse.fromJson(Map<String, dynamic> json) =>
      RiwayatPulangResponse(
        data: List<RiwayatPulangDataResponse>.from(
            json["data"].map((x) => RiwayatPulangDataResponse.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class RiwayatPulangDataResponse {
  RiwayatPulangDataResponse({
    required this.latitude,
    required this.longitude,
    required this.fotoPulang,
    required this.status,
    required this.waktu,
  });

  final String latitude;
  final String longitude;
  final String fotoPulang;
  final String status;
  final String waktu;

  factory RiwayatPulangDataResponse.fromJson(Map<String, dynamic> json) =>
      RiwayatPulangDataResponse(
        latitude: json["latitude"].toString(),
        longitude: json["longitude"].toString(),
        fotoPulang: json["foto_pulang"],
        status: json["status"],
        waktu: json["waktu"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude.toString(),
        "longitude": longitude.toString(),
        "foto_pulang": fotoPulang,
        "status": status,
        "waktu": waktu,
      };
}
