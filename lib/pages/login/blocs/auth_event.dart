import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AppStarted extends AuthEvent {}

class AuthCheck extends AuthEvent {}

class GetDataWithToken extends AuthEvent {
  final String token;

  GetDataWithToken(this.token);

  @override
  List<Object> get props => [token];
}

class LoggedOut extends AuthEvent {
  // @override
  // // TODO: implement props
  // List<Object> get props => [];
}

class LoginProcess extends AuthEvent {
  final String email;
  final String password;

  LoginProcess({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

// class GetDataAnggota extends AuthEvent {
//   final String token;

//   GetDataAnggota(this.token);

//   @override
//   List<Object> get props => [token];
// }
