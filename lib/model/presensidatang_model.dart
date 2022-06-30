import 'dart:io';

import 'package:meta/meta.dart';
import 'dart:convert';

PresensiDatangModel presensiDatangModelFromJson(String str) =>
    PresensiDatangModel.fromJson(json.decode(str));

String presensiDatangModelToJson(PresensiDatangModel data) =>
    json.encode(data.toJson());

class PresensiDatangModel {
  final double latitude;
  final double longtitude;
  final String fotoDatang;
  final String status;

  PresensiDatangModel({
    required this.latitude,
    required this.longtitude,
    required this.fotoDatang,
    required this.status,
  });

  factory PresensiDatangModel.fromJson(Map<String, dynamic> json) =>
      PresensiDatangModel(
        latitude: json["latitude"].toDouble(),
        longtitude: json["longtitude"].toDouble(),
        fotoDatang: json["foto_datang"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longtitude": longtitude,
        "foto_datang": fotoDatang,
        "status": status,
      };
}
