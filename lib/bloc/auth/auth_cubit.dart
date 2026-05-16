// ============================================================
// lib/bloc/auth/auth_cubit.dart
// ============================================================

import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/api/api_endpoints.dart';
import '../../data/models/entity_model.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState.initial());

  // ──────────────────────────────────────────────────────────
  // LOAD ENTITIES API
  // ──────────────────────────────────────────────────────────
  Future<void> loadEntities() async {
    try {
      emit(state.copyWith(isEntityLoading: true));

      final response = await http.get(
        Uri.parse(ApiEndpoints.getEntity),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final List<EntityModel> entities =
            (data["data"] as List).map((e) => EntityModel.fromJson(e)).toList();

        emit(
          state.copyWith(
            entities: entities,
            isEntityLoading: false,
          ),
        );
      } else {
        emit(
          state.copyWith(
            isEntityLoading: false,
            error: "Failed to load entities",
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          isEntityLoading: false,
          error: e.toString(),
        ),
      );
    }
  }

  // ──────────────────────────────────────────────────────────
  // SELECT ENTITY
  // ──────────────────────────────────────────────────────────
  void selectEntity(EntityModel entity) {
    emit(
      state.copyWith(
        selectedEntity: entity,
      ),
    );
  }

  // ──────────────────────────────────────────────────────────
  // LOAD CAPTCHA API
  // ──────────────────────────────────────────────────────────
  Future<void> loadCaptcha() async {
    try {
      emit(state.copyWith(isCaptchaLoading: true));

      final response = await http.get(
        Uri.parse(ApiEndpoints.getCaptcha),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final captcha = EntityModel.fromJson(data);

        emit(
          state.copyWith(
            captcha: captcha,
            isCaptchaLoading: false,
          ),
        );
      } else {
        emit(
          state.copyWith(
            isCaptchaLoading: false,
            error: "Failed to load captcha",
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          isCaptchaLoading: false,
          error: e.toString(),
        ),
      );
    }
  }

  // ──────────────────────────────────────────────────────────
  // REFRESH CAPTCHA
  // ──────────────────────────────────────────────────────────
  Future<void> refreshCaptcha() async {
    await loadCaptcha();
  }

  // ──────────────────────────────────────────────────────────
  // LOGIN API
  // ──────────────────────────────────────────────────────────
  Future<void> login({
    required String username,
    required String password,
    required String captchaInput,
  }) async {
    try {
      emit(state.copyWith(isLoading: true));

      if (username.isEmpty || password.isEmpty) {
        emit(
          state.copyWith(
            isLoading: false,
            error: "Username & Password required",
          ),
        );
        return;
      }

      final response = await http.post(
        Uri.parse(ApiEndpoints.login),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "username": username,
          "password": password,
          "entity_id": state.selectedEntity?.id,
          "captcha_input": captchaInput,
          "captcha_key": state.captcha?.captchaKey,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final token = data["token"] ?? "";

        final prefs = await SharedPreferences.getInstance();

        await prefs.setString("token", token);

        emit(
          state.copyWith(
            token: token,
            isLoggedIn: true,
            isLoading: false,
          ),
        );
      } else {
        emit(
          state.copyWith(
            isLoading: false,
            error: data["message"] ?? "Login failed",
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          error: e.toString(),
        ),
      );
    }
  }

  // ──────────────────────────────────────────────────────────
  // CLEAR ERROR
  // ──────────────────────────────────────────────────────────
  void clearError() {
    emit(
      state.copyWith(
        error: null,
      ),
    );
  }

  // ──────────────────────────────────────────────────────────
  // LOGOUT
  // ──────────────────────────────────────────────────────────
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove("token");

    emit(AuthState.initial());
  }
}
