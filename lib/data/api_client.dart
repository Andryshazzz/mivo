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
      await _dio.post(
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
      final response = await _dio.post(
        'https://d5dsstfjsletfcftjn3b.apigw.yandexcloud.net/confirm_code',
        data: {'email': email, 'code': int.parse(code)},
      );
      return {
        'jwt': response.data['jwt'] as String,
        'refresh_token': response.data['refresh_token'] as String,
      };
    } catch (e, st) {
      throw DioException(
        requestOptions: RequestOptions(path: '/confirm_code'),
        error: e,
        message: 'Failed to verify code: $e, $st',
      );
    }
  }

  Future<Map<String, String>> refreshToken(String refreshToken) async {
    try {
      final response = await _dio.post(
        'https://d5dsstfjsletfcftjn3b.apigw.yandexcloud.net/refresh_token',
        data: {'token': refreshToken},
      );
      return {
        'jwt': response.data['jwt'] as String,
        'refresh_token': response.data['refresh_token'] as String,
      };
    } catch (e, st) {
      throw DioException(
        requestOptions: RequestOptions(path: '/refresh_token'),
        error: e,
        message: 'Failed to refresh token: $e, $st',
      );
    }
  }

  Future<String> checkAuth(String jwtToken) async {
    try {
      final response = await _dio.get(
        'https://d5dsstfjsletfcftjn3b.apigw.yandexcloud.net/auth',
        options: Options(headers: {'Authorization': 'Bearer $jwtToken'}),
      );
      return response.data['user_id'].toString();
    } catch (e, st) {
      throw DioException(
        requestOptions: RequestOptions(path: '/auth'),
        error: e,
        message: 'Failed to check auth: $e, $st',
      );
    }
  }
}
