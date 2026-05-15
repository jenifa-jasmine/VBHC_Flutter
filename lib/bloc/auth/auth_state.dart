// lib/bloc/auth/auth_state.dart
class AuthState {
  final Map<String, dynamic>? user;
  final String? token;
  final String? csrfToken;
  final String? csrfCookie;

  const AuthState({this.user, this.token, this.csrfToken, this.csrfCookie});

  factory AuthState.initial() => const AuthState();

  AuthState copyWith({Map<String, dynamic>? user, String? token,
      String? csrfToken, String? csrfCookie}) {
    return AuthState(
      user: user ?? this.user,
      token: token ?? this.token,
      csrfToken: csrfToken ?? this.csrfToken,
      csrfCookie: csrfCookie ?? this.csrfCookie,
    );
  }
}