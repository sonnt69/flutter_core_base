import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/storage/secure_token_storage.dart';
import '../../profile/data/profile_local_data_source.dart';
import '../../profile/domain/user_profile.dart';
import 'auth_remote_data_source.dart';

class AuthRepository {
  AuthRepository(
    this._remoteDataSource,
    this._tokenStorage,
    this._profileLocalDataSource,
  );

  final AuthRemoteDataSource _remoteDataSource;
  final SecureTokenStorage _tokenStorage;
  final ProfileLocalDataSource _profileLocalDataSource;

  Future<bool> hasCompletedOnboarding() {
    return _tokenStorage.hasCompletedOnboarding();
  }

  Future<UserProfile?> restoreUser() async {
    final accessToken = await _tokenStorage.readAccessToken();
    if (accessToken == null || accessToken.isEmpty) return null;
    return _profileLocalDataSource.readCurrentUser();
  }

  Future<void> completeOnboarding() {
    return _tokenStorage.markOnboardingCompleted();
  }

  Future<UserProfile> login({
    required String email,
    required String password,
  }) async {
    final session = await _remoteDataSource.login(
      email: email,
      password: password,
    );
    await _tokenStorage.saveTokens(
      accessToken: session.accessToken,
      refreshToken: session.refreshToken,
    );
    await _profileLocalDataSource.saveCurrentUser(session.user);
    return session.user;
  }

  Future<UserProfile> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final session = await _remoteDataSource.register(
      name: name,
      email: email,
      password: password,
    );
    await _tokenStorage.saveTokens(
      accessToken: session.accessToken,
      refreshToken: session.refreshToken,
    );
    await _profileLocalDataSource.saveCurrentUser(session.user);
    return session.user;
  }

  Future<void> forgotPassword(String email) {
    return _remoteDataSource.forgotPassword(email);
  }

  Future<void> verifyOtp({required String email, required String code}) {
    return _remoteDataSource.verifyOtp(email: email, code: code);
  }

  Future<UserProfile> updateProfile(UserProfile profile) async {
    await _profileLocalDataSource.saveCurrentUser(profile);
    return profile;
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) {
    return _remoteDataSource.changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
  }

  Future<void> logout() async {
    await _tokenStorage.clearTokens();
    await _profileLocalDataSource.clear();
  }

  Future<void> deleteAccount() async {
    await _remoteDataSource.deleteAccount();
    await _tokenStorage.clearAll();
    await _profileLocalDataSource.clear();
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(
    ref.watch(authRemoteDataSourceProvider),
    ref.watch(secureTokenStorageProvider),
    ref.watch(profileLocalDataSourceProvider),
  );
});
