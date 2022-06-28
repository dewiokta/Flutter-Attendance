import 'dart:io';

import 'package:meta/meta.dart';
import 'dart:convert';

PresensiPulangModel PresensiPulangModelFromJson(String str) =>
    PresensiPulangModel.fromJson(json.decode(str));

String presensiPulangModelToJson(PresensiPulangModel data) =>
    json.encode(data.toJson());

class PresensiPulangModel {
  final double latitude;
  final double longtitude;
  final File? fotoPulang;
  final String status;

  PresensiPulangModel({
    required this.latitude,
    required this.longtitude,
    required this.fotoPulang,
    required this.status,
  });

  factory PresensiPulangModel.fromJson(Map<String, dynamic> json) =>
      PresensiPulangModel(
        latitude: json["latitude"].toDouble(),
        longtitude: json["longtitude"].toDouble(),
        fotoPulang: json["foto_datang"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longtitude": longtitude,
        "foto_datang": fotoPulang,
        "status": status,
      };
}
