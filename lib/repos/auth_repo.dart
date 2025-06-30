import 'package:injectable/injectable.dart';

import '../data/api_client.dart';

@singleton
class AuthRepository {
  final ApiClient apiClient;

  AuthRepository({required this.apiClient});

  Future<void> sendCode(String email) async {
    apiClient.sendCode(email);
  }

  Future<Map<String, String>> verifyCode(String email, String code) async {
    return await apiClient.verifyCode(email, code);
  }

  Future<Map<String, String>> refreshToken(String refreshToken) async {
    return await apiClient.refreshToken(refreshToken);
  }

  Future<String> checkAuth(String jwtToken) async {
    return await apiClient.checkAuth(jwtToken);
  }
}
