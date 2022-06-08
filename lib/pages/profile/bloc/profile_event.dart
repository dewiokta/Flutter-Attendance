part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class GetDataAnggota extends ProfileEvent {
  final String token;

  GetDataAnggota(this.token);

  @override
  List<Object> get props => [token];
}
