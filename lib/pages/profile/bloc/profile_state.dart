part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class DataAnggota extends ProfileState {
  final String name;
  final String ttl;
  final String alamat;
  final String jabatan;
  final String jenisKelamin;

  DataAnggota(
      {required this.ttl,
      required this.name,
      required this.alamat,
      required this.jabatan,
      required this.jenisKelamin});
  @override
  List<Object> get props => [name, ttl, alamat, jabatan, jenisKelamin];
}
