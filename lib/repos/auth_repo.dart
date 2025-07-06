import 'package:injectable/injectable.dart';

import '../data/api_client.dart';

@singleton
class AuthRepository {
  final ApiClient apiClient;

  AuthRepository({required this.apiClient});

  Future<void> sendCode(String email) async {
    await apiClient.sendCode(email);
  }

  Future<Map<String, String>> verifyCode(String email, String code) async {
    return apiClient.verifyCode(email, code);
  }

  Future<Map<String, String>> refreshToken(String refreshToken) async {
    return apiClient.refreshToken(refreshToken);
  }

  Future<String> checkAuth(String jwtToken) async {
    return apiClient.checkAuth(jwtToken);
  }
}
