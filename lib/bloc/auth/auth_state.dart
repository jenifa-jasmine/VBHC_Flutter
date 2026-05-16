// ============================================================
// lib/bloc/auth/auth_state.dart
// ============================================================

import '../../data/models/auth_model.dart';
import '../../data/models/entity_model.dart';

// ============================================================

// ============================================================
// AUTH STATE
// ============================================================

class AuthState {
  final List<EntityModel> entities;
  final EntityModel? selectedEntity;

  final EntityModel? captcha;
  final LoginResponse? loginResponse;

  final List<UserModule> userModules;

  final Map<String, dynamic>? user;

  final String? token;
  final String? csrfToken;
  final String? csrfCookie;

  final bool isLoading;
  final bool isEntityLoading;
  final bool isCaptchaLoading;
  final bool isModulesLoading;
  final bool isLoggedIn;
  final bool forgotPasswordSuccess;

  final String? error;

  const AuthState({
    this.entities = const [],
    this.selectedEntity,
    this.captcha,
    this.loginResponse,
    this.userModules = const [],
    this.user,
    this.token,
    this.csrfToken,
    this.csrfCookie,
    this.isLoading = false,
    this.isEntityLoading = false,
    this.isCaptchaLoading = false,
    this.isModulesLoading = false,
    this.isLoggedIn = false,
    this.forgotPasswordSuccess = false,
    this.error,
  });

  // ──────────────────────────────────────────────────────────
  // INITIAL
  // ──────────────────────────────────────────────────────────
  factory AuthState.initial() {
    return const AuthState();
  }

  // ──────────────────────────────────────────────────────────
  // COPY WITH
  // ──────────────────────────────────────────────────────────
  AuthState copyWith({
    List<EntityModel>? entities,
    EntityModel? selectedEntity,
    EntityModel? captcha,
    LoginResponse? loginResponse,
    List<UserModule>? userModules,
    String? token,
    bool? isLoading,
    bool? isEntityLoading,
    bool? isCaptchaLoading,
    bool? isModulesLoading,
    bool? isLoggedIn,
    bool? forgotPasswordSuccess,
    String? error,
    bool clearError = false,
    bool clearEntity = false,

    // ADD THESE
    String? csrfToken,
    String? csrfCookie,
    Map<String, dynamic>? user,
  }) {
    return AuthState(
      entities: entities ?? this.entities,
      selectedEntity:
          clearEntity ? null : selectedEntity ?? this.selectedEntity,
      captcha: captcha ?? this.captcha,
      loginResponse: loginResponse ?? this.loginResponse,
      userModules: userModules ?? this.userModules,
      token: token ?? this.token,
      isLoading: isLoading ?? this.isLoading,
      isEntityLoading: isEntityLoading ?? this.isEntityLoading,
      isCaptchaLoading: isCaptchaLoading ?? this.isCaptchaLoading,
      isModulesLoading: isModulesLoading ?? this.isModulesLoading,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      forgotPasswordSuccess:
          forgotPasswordSuccess ?? this.forgotPasswordSuccess,
      error: clearError ? null : error ?? this.error,
    );
  }
}
