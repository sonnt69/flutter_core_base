import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_client.dart';
import '../../profile/domain/user_profile.dart';
import '../domain/auth_session.dart';

class AuthRemoteDataSource {
  AuthRemoteDataSource(this._apiClient);

  final ApiClient _apiClient;

  Future<AuthSession> login({
    required String email,
    required String password,
  }) async {
    _apiClient;
    await Future<void>.delayed(const Duration(milliseconds: 500));
    return _sessionFor(email: email);
  }

  Future<AuthSession> register({
    required String name,
    required String email,
    required String password,
  }) async {
    _apiClient;
    await Future<void>.delayed(const Duration(milliseconds: 650));
    return _sessionFor(email: email, name: name);
  }

  Future<void> forgotPassword(String email) async {
    _apiClient;
    await Future<void>.delayed(const Duration(milliseconds: 450));
  }

  Future<void> verifyOtp({required String email, required String code}) async {
    _apiClient;
    await Future<void>.delayed(const Duration(milliseconds: 450));
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    _apiClient;
    await Future<void>.delayed(const Duration(milliseconds: 450));
  }

  Future<void> deleteAccount() async {
    _apiClient;
    await Future<void>.delayed(const Duration(milliseconds: 450));
  }

  AuthSession _sessionFor({required String email, String? name}) {
    final normalizedEmail = email.trim().toLowerCase();
    final displayName = name?.trim().isNotEmpty == true
        ? name!.trim()
        : normalizedEmail.split('@').first;

    return AuthSession(
      accessToken: 'dev-access-token-${DateTime.now().millisecondsSinceEpoch}',
      refreshToken:
          'dev-refresh-token-${DateTime.now().millisecondsSinceEpoch}',
      user: UserProfile(
        id: normalizedEmail,
        name: displayName,
        email: normalizedEmail,
        phone: '+1 555 0100',
      ),
    );
  }
}

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSource(ref.watch(apiClientProvider));
});
