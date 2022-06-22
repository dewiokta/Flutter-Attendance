import 'package:flutter_attendance/pages/profile/bloc/profile_bloc.dart';

class Endpoint {
  const Endpoint._();

  static const getDataAnggota =
      'https://attendance.putraprima.id/api/anggota-detail';
  
  static const createPresensiPulang = "https://attendance.putraprima.id/api/presensi-datang/";
}
