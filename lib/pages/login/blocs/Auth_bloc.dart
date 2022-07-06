import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_attendance/pages/login/blocs/auth_event.dart';
import 'package:flutter_attendance/model/data_model.dart';
import 'package:flutter_attendance/pages/login/blocs/auth_repository.dart';
import 'package:flutter_attendance/pages/login/blocs/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required this.authRepository})
      : assert(authRepository != null),
        super(AuthInit()) {
    on<AuthCheck>(_onAuthCheck);
    on<LoginProcess>(_onAuthLoginProcess);
    on<GetDataWithToken>(_onGetData);
    on<LoggedOut>(_onLogout);
  }

  final AuthRepository authRepository;

  void _onAuthCheck(AuthEvent event, Emitter<AuthState> emit) async {
    if (event is AuthCheck) {
      emit(AuthLoading());

      final hasToken = await authRepository.hasToken();
      if (hasToken != null) {
        emit(AuthHasToken(token: hasToken));
      } else {
        emit(AuthFailed());
      }
    }

    if (event is GetDataWithToken) {
      emit(AuthLoading());

      final user = await authRepository.getData(event.token);
      emit(AuthData(email: user.email, name: user.name, id: user.id));
    }
    if (event is LoggedOut) {
      final String token = await authRepository.hasToken();
      try {
        final Logout logout = await authRepository.userLogout(token);
        if (logout.message == "success") {
          await authRepository.unsetToken();
          emit(AuthFailed());
        }
      } catch (e) {}
    }
  }

  void _onAuthLoginProcess(AuthEvent event, Emitter<AuthState> emit) async {
    if (event is LoginProcess) {
      emit(AuthLoading());
      try {
        final login =
            await authRepository.loginUser(event.email, event.password);
        if (login.message != "failed") {
          emit(LoginSuccess());
          await authRepository.setLocalToken(login.data.token);
          emit(AuthHasToken(token: login.data.token));
        }
      } catch (e) {
        emit(LoginFailed("Login Gagal"));
      }
    }
    if (event is LoggedOut) {
      final String token = await authRepository.hasToken();
      try {
        final Logout logout = await authRepository.userLogout(token);
        if (logout.message == "success") {
          await authRepository.unsetToken();
          emit(AuthFailed());
        }
      } catch (e) {}
    }
  }

  void _onGetData(AuthEvent event, Emitter<AuthState> emit) async {
    if (event is GetDataWithToken) {
      emit(AuthLoading());

      final user = await authRepository.getData(event.token);
      emit(AuthData(email: user.email, name: user.name, id: user.id));
    }
    if (event is LoggedOut) {
      final String token = await authRepository.hasToken();
      try {
        final Logout logout = await authRepository.userLogout(token);
        if (logout.message == "success") {
          await authRepository.unsetToken();
          emit(AuthFailed());
        }
      } catch (e) {}
    }
  }

  void _onLogout(AuthEvent event, Emitter<AuthState> emit) async {
    if (event is LoggedOut) {
      final String token = await authRepository.hasToken();
      try {
        final Logout logout = await authRepository.userLogout(token);
        if (logout.message == "success") {
          await authRepository.unsetToken();
          emit(AuthFailed());
        }
      } catch (e) {}
    }
  }
}
