import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@singleton
class ApiClient {
  ApiClient() {
    _initDio();
  }

  final _dio = Dio();

  Future<void> _initDio() async {
    const apiUrl = 'https://min-api.cryptocompare.com';

    _dio.options
      ..baseUrl = apiUrl
      ..connectTimeout = const Duration(seconds: 30)
      ..receiveTimeout = const Duration(seconds: 60)
      ..sendTimeout = const Duration(seconds: 30);
  }

  Future<void> sendCode(String email) async {
    try {
      await _dio.post<void>(
        'https://d5dsstfjsletfcftjn3b.apigw.yandexcloud.net/login',
        data: {'email': email},
      );
    } catch (e, st) {
      throw DioException(
        requestOptions: RequestOptions(path: '/login'),
        error: e,
        message: 'Failed to send code: $e, $st',
      );
    }
  }

  Future<Map<String, String>> verifyCode(String email, String code) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        'https://d5dsstfjsletfcftjn3b.apigw.yandexcloud.net/confirm_code',
        data: {'email': email, 'code': code},
      );

      if (response.data == null) {
        throw DioException(
          requestOptions: response.requestOptions,
          error: 'Response data is null',
          message: 'Server returned no data',
        );
      }

      final jwt = response.data!['jwt'] as String?;
      final refreshToken = response.data!['refresh_token'] as String?;

      if (jwt == null || refreshToken == null) {
        throw DioException(
          requestOptions: response.requestOptions,
          error: 'Missing tokens in response',
          message: 'Expected "jwt" and "refresh_token" in response',
        );
      }

      return {'jwt': jwt, 'refresh_token': refreshToken};
    } on DioException catch (_) {
      rethrow;
    } on FormatException catch (e) {
      throw DioException(
        requestOptions: RequestOptions(path: '/confirm_code'),
        error: e,
        message: 'Invalid code format: $code',
      );
    } catch (e, st) {
      throw DioException(
        requestOptions: RequestOptions(path: '/confirm_code'),
        error: e,
        message: 'Unexpected error: $e',
        stackTrace: st,
      );
    }
  }

  Future<Map<String, String>> refreshToken(String refreshToken) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        'https://d5dsstfjsletfcftjn3b.apigw.yandexcloud.net/refresh_token',
        data: {'token': refreshToken},
      );

      if (response.data == null) {
        throw DioException(
          requestOptions: response.requestOptions,
          error: 'Empty response',
          message: 'Server returned no data',
        );
      }

      final jwt = response.data!['jwt'] as String?;
      final newRefreshToken = response.data!['refresh_token'] as String?;

      if (jwt == null || newRefreshToken == null) {
        throw DioException(
          requestOptions: response.requestOptions,
          error: 'Invalid token format',
          message: 'Response must contain both jwt and refresh_token',
        );
      }

      return {'jwt': jwt, 'refresh_token': newRefreshToken};
    } on DioException catch (e) {
      Error.throwWithStackTrace(
        DioException(
          requestOptions: e.requestOptions,
          error: e.error,
          message: 'Token refresh failed: ${e.message}',
          response: e.response,
          stackTrace: e.stackTrace,
        ),
        e.stackTrace,
      );
    } catch (e, st) {
      throw DioException(
        requestOptions: RequestOptions(path: '/refresh_token'),
        error: e,
        message: 'Unexpected error during token refresh: $e',
        stackTrace: st,
      );
    }
  }

  Future<String> checkAuth(String jwtToken) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        'https://d5dsstfjsletfcftjn3b.apigw.yandexcloud.net/auth',
        options: Options(headers: {'Authorization': 'Bearer $jwtToken'}),
      );

      if (response.data == null) {
        throw DioException(
          requestOptions: response.requestOptions,
          error: 'Empty response',
          message: 'Authentication check returned no data',
          response: response,
        );
      }

      final userId = response.data!['user_id']?.toString();
      if (userId == null || userId.isEmpty) {
        throw DioException(
          requestOptions: response.requestOptions,
          error: 'Invalid user_id',
          message: 'Response does not contain valid user_id',
          response: response,
        );
      }

      return userId;
    } on DioException catch (e) {
      Error.throwWithStackTrace(
        DioException(
          requestOptions: e.requestOptions,
          error: e.error,
          message: 'Authentication check failed: ${e.message}',
          response: e.response,
          stackTrace: e.stackTrace,
        ),
        e.stackTrace,
      );
    } catch (e, st) {
      throw DioException(
        requestOptions: RequestOptions(path: '/auth'),
        error: e,
        message: 'Unexpected error during authentication check: $e',
        stackTrace: st,
      );
    }
  }
}
