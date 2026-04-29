import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../profile/domain/user_profile.dart';
import '../data/auth_repository.dart';

class AuthState {
  const AuthState({
    required this.isLoading,
    required this.hasCompletedOnboarding,
    this.user,
    this.errorMessage,
  });

  const AuthState.initial()
    : isLoading = true,
      hasCompletedOnboarding = false,
      user = null,
      errorMessage = null;

  final bool isLoading;
  final bool hasCompletedOnboarding;
  final UserProfile? user;
  final String? errorMessage;

  bool get isAuthenticated => user != null;

  AuthState copyWith({
    bool? isLoading,
    bool? hasCompletedOnboarding,
    UserProfile? user,
    String? errorMessage,
    bool clearUser = false,
    bool clearError = false,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      hasCompletedOnboarding:
          hasCompletedOnboarding ?? this.hasCompletedOnboarding,
      user: clearUser ? null : user ?? this.user,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }
}

class AuthController extends StateNotifier<AuthState> {
  AuthController(this._repository) : super(const AuthState.initial());

  final AuthRepository _repository;

  Future<void> initialize() async {
    state = state.copyWith(isLoading: true, clearError: true);
    final hasCompletedOnboarding = await _repository.hasCompletedOnboarding();
    final user = await _repository.restoreUser();
    state = AuthState(
      isLoading: false,
      hasCompletedOnboarding: hasCompletedOnboarding,
      user: user,
    );
  }

  Future<void> completeOnboarding() async {
    await _repository.completeOnboarding();
    state = state.copyWith(hasCompletedOnboarding: true);
  }

  Future<void> login({required String email, required String password}) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final user = await _repository.login(email: email, password: password);
      state = state.copyWith(isLoading: false, user: user);
    } on Object {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Unable to sign in. Check your details and try again.',
      );
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final user = await _repository.register(
        name: name,
        email: email,
        password: password,
      );
      state = state.copyWith(isLoading: false, user: user);
    } on Object {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Unable to create account. Please try again.',
      );
    }
  }

  Future<void> updateProfile(UserProfile profile) async {
    final user = await _repository.updateProfile(profile);
    state = state.copyWith(user: user);
  }

  Future<void> logout() async {
    await _repository.logout();
    state = state.copyWith(clearUser: true);
  }

  Future<void> deleteAccount() async {
    await _repository.deleteAccount();
    state = state.copyWith(hasCompletedOnboarding: false, clearUser: true);
  }
}

final authControllerProvider = StateNotifierProvider<AuthController, AuthState>(
  (ref) {
    return AuthController(ref.watch(authRepositoryProvider));
  },
);
