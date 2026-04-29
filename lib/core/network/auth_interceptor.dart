import 'package:dio/dio.dart';

import '../storage/secure_token_storage.dart';
import 'api_endpoints.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._dio, this._tokenStorage);

  final Dio _dio;
  final SecureTokenStorage _tokenStorage;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final skipAuth = options.extra['skipAuth'] == true;
    final accessToken = await _tokenStorage.readAccessToken();

    if (!skipAuth && accessToken != null && accessToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final isUnauthorized = err.response?.statusCode == 401;
    final isRefreshCall = err.requestOptions.path == ApiEndpoints.refreshToken;

    if (!isUnauthorized || isRefreshCall) {
      return handler.next(err);
    }

    final refreshToken = await _tokenStorage.readRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) {
      await _tokenStorage.clearTokens();
      return handler.next(err);
    }

    try {
      final response = await _dio.post<Map<String, dynamic>>(
        ApiEndpoints.refreshToken,
        data: {'refreshToken': refreshToken},
        options: Options(extra: {'skipAuth': true}),
      );

      final data = response.data ?? <String, dynamic>{};
      final nextAccessToken = data['accessToken'] as String?;
      final nextRefreshToken = data['refreshToken'] as String? ?? refreshToken;

      if (nextAccessToken == null || nextAccessToken.isEmpty) {
        await _tokenStorage.clearTokens();
        return handler.next(err);
      }

      await _tokenStorage.saveTokens(
        accessToken: nextAccessToken,
        refreshToken: nextRefreshToken,
      );

      final request = err.requestOptions;
      request.headers['Authorization'] = 'Bearer $nextAccessToken';

      final retryResponse = await _dio.fetch<dynamic>(request);
      return handler.resolve(retryResponse);
    } on Object {
      await _tokenStorage.clearTokens();
      return handler.next(err);
    }
  }
}
