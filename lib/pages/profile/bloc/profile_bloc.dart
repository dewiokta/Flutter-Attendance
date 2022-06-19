import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_attendance/pages/login/blocs/auth_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AuthRepository authRepository;
  ProfileBloc(
    this.authRepository,
  )   : assert(authRepository != null),
        super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) {
      on<GetDataAnggota>(_onGetDataAnggota);
    });
  }

  void _onGetDataAnggota(ProfileEvent event, Emitter<ProfileState> emit) async {
    if (event is GetDataAnggota) {
      emit(ProfileLoading());

      final anggota = await authRepository.getDataAnggota(event.token);
      emit(DataAnggota(
          name: anggota.name,
          ttl: anggota.ttl,
          alamat: anggota.alamat,
          jabatan: anggota.jabatan,
          jenisKelamin: anggota.jenisKelamin));
      // print(anggota.ttl);
      // print(anggota.name);
      // print(anggota.alamat);
      // print(anggota.jabatan);
      // print(anggota.jenisKelamin);
    }
  }
}
