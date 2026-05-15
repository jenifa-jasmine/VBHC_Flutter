// lib/bloc/auth/auth_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState.initial());

  // setUser() - AuthSlice setUser
  Future<void> setUser(Map<String, dynamic> userData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", userData["token"] ?? "");
    emit(state.copyWith(user: userData, token: userData["token"]));
  }

  // setCsrf()
  Future<void> setCsrf(String csrfToken, String csrfCookie) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("csrfToken", csrfToken);
    await prefs.setString("csrfCookie", csrfCookie);
    emit(state.copyWith(csrfToken: csrfToken, csrfCookie: csrfCookie));
  }

  // logout()
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("token");
    await prefs.remove("csrfToken");
    await prefs.remove("csrfCookie");
    emit(AuthState.initial());
  }
}