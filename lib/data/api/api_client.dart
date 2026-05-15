// lib/data/api/api_client.dart
//
// Dio-based HTTP client — Flutter equivalent of RTK Query's baseQueryWithRefresh.
// Handles:
//  • Auth token injection          (like prepareHeaders in baseQuery)
//  • Automatic token refresh       (like baseQueryWithRefresh)
//  • 401 → logout flow
//  • Multipart / JSON / blob support
//
// Usage:
//   final client = ApiClient(storage: secureStorage);
//   final res = await client.post(ApiEndpoints.login, data: {'username': ..., 'password': ...});

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../core/constants/environment.dart';
import 'dart:async';

// ─────────────────────────────────────────────────────────────────────────────
// Token storage keys
// ─────────────────────────────────────────────────────────────────────────────
class _Keys {
  static const accessToken = 'access_token';
  static const refreshToken = 'refresh_token';
}

// ─────────────────────────────────────────────────────────────────────────────
// ApiException — mirrors the shape RN throws on non-2xx
// ─────────────────────────────────────────────────────────────────────────────
class ApiException implements Exception {
  final int? statusCode;
  final String message;
  final dynamic data;

  const ApiException({this.statusCode, required this.message, this.data});

  @override
  String toString() => 'ApiException($statusCode): $message';
}

// ─────────────────────────────────────────────────────────────────────────────
// ApiClient
// ─────────────────────────────────────────────────────────────────────────────
class ApiClient {
  final FlutterSecureStorage _storage;
  late final Dio _dio;

  // Track if a refresh is already in-flight so concurrent 401s only refresh once.
  bool _isRefreshing = false;
  final List<void Function(String token)> _pendingRetries = [];

  ApiClient({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage() {
    _dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 60),
        // Individual endpoints set their full URL; no baseUrl needed here.
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: _onRequest,
        onError: _onError,
      ),
    );
  }

  // ── Inject access token ───────────────────────────────────────────────────
  Future<void> _onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _storage.read(key: _Keys.accessToken);
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  // ── Handle 401 with silent token refresh ─────────────────────────────────
  Future<void> _onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final statusCode = err.response?.statusCode;

    if (statusCode != 401) {
      handler.reject(
        DioException(
          requestOptions: err.requestOptions,
          error: ApiException(
            statusCode: statusCode,
            message: _extractMessage(err.response?.data) ??
                err.message ??
                'Unknown error',
            data: err.response?.data,
          ),
          response: err.response,
          type: err.type,
        ),
      );
      return;
    }

    // ── 401 path ─────────────────────────────────────────────────────────────
    if (_isRefreshing) {
      final completer = Completer<String>();

      _pendingRetries.add((token) {
        completer.complete(token);
      });

      final newToken = await completer.future;

      err.requestOptions.headers['Authorization'] = 'Bearer $newToken';

      handler.resolve(await _dio.fetch(err.requestOptions));

      return;
    }

    _isRefreshing = true;
    try {
      final refreshToken = await _storage.read(key: _Keys.refreshToken);
      if (refreshToken == null) {
        await _logout();
        handler.reject(err);
        return;
      }

      // Call refresh endpoint — adjust path to match your backend.
      final refreshResp = await _dio.post(
        '${Environment.userServiceUrl}/usrserv/refresh_token',
        data: {'refresh_token': refreshToken},
        options: Options(
          headers: {'Authorization': null}, // don't send old token
        ),
      );

      final newAccessToken = refreshResp.data['access_token'] as String?;
      final newRefreshToken = refreshResp.data['refresh_token'] as String?;

      if (newAccessToken == null) {
        await _logout();
        handler.reject(err);
        return;
      }

      await _storage.write(key: _Keys.accessToken, value: newAccessToken);
      if (newRefreshToken != null) {
        await _storage.write(key: _Keys.refreshToken, value: newRefreshToken);
      }

      // Drain pending retries.
      for (final retry in _pendingRetries) {
        retry(newAccessToken);
      }
      _pendingRetries.clear();

      // Retry the original request.
      err.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';
      handler.resolve(await _dio.fetch(err.requestOptions));
    } catch (_) {
      await _logout();
      handler.reject(err);
    } finally {
      _isRefreshing = false;
    }
  }

  Future<void> _logout() async {
    await _storage.deleteAll();
    // TODO: trigger your AuthCubit logout event here, e.g. via a global event bus.
  }

  // ── Public HTTP helpers ───────────────────────────────────────────────────

  /// GET request.
  Future<Response<T>> get<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) =>
      _dio.get<T>(url, queryParameters: queryParameters, options: options);

  /// POST request — pass [data] as Map (JSON) or FormData (multipart).
  Future<Response<T>> post<T>(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) =>
      _dio.post<T>(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );

  /// DELETE request.
  Future<Response<T>> delete<T>(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) =>
      _dio.delete<T>(url,
          data: data, queryParameters: queryParameters, options: options);

  /// Download a file as bytes (replaces responseHandler: response.blob() in RN).
  Future<List<int>> downloadBytes(String url) async {
    final resp = await _dio.get<List<int>>(
      url,
      options: Options(responseType: ResponseType.bytes),
    );
    return resp.data ?? [];
  }

  /// Persist tokens after login — call from AuthCubit.
  Future<void> saveTokens({
    required String accessToken,
    String? refreshToken,
  }) async {
    await _storage.write(key: _Keys.accessToken, value: accessToken);
    if (refreshToken != null) {
      await _storage.write(key: _Keys.refreshToken, value: refreshToken);
    }
  }

  /// Clear tokens on logout.
  Future<void> clearTokens() async => _storage.deleteAll();

  // ── Helpers ───────────────────────────────────────────────────────────────

  /// Build multipart FormData the same way RN does for file uploads.
  ///
  /// [fields]  — flat key/value pairs serialised as JSON under the 'data' key.
  /// [files]   — list of {path, name, mimeType} maps.
  /// [fileKey] — form field name used for the files (default: 'files').
  static FormData buildFormData({
    required Map<String, dynamic> fields,
    List<Map<String, String>> files = const [],
    String fileKey = 'files',
  }) {
    final form = FormData.fromMap({
      'data': _jsonString(fields),
    });
    for (final f in files) {
      form.files.add(
        MapEntry(
          fileKey,
          MultipartFile.fromFileSync(
            f['path']!,
            filename: f['name'],
            contentType:
                _parseMime(f['mimeType'] ?? 'application/octet-stream'),
          ),
        ),
      );
    }
    return form;
  }

  static String _jsonString(Map<String, dynamic> m) {
    // Minimal JSON serialise without importing dart:convert at top level.
    final entries = m.entries.map((e) {
      final v = e.value;
      final encoded = v == null
          ? 'null'
          : v is String
              ? '"$v"'
              : v is bool
                  ? '$v'
                  : v is num
                      ? '$v'
                      : '"$v"';
      return '"${e.key}":$encoded';
    }).join(',');
    return '{$entries}';
  }

  static DioMediaType _parseMime(String mime) {
    final parts = mime.split('/');
    return parts.length == 2
        ? DioMediaType(parts[0], parts[1])
        : DioMediaType('application', 'octet-stream');
  }

  static String? _extractMessage(dynamic data) {
    if (data is Map) return data['message'] as String?;
    return null;
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Convenience typedef so repositories can be typed clearly.
// ─────────────────────────────────────────────────────────────────────────────
typedef ApiResponse = Response<dynamic>;
