class ApiEndpoints {
  ApiEndpoints._();

  static const login = '/auth/login';
  static const register = '/auth/register';
  static const forgotPassword = '/auth/forgot-password';
  static const verifyOtp = '/auth/verify-otp';
  static const refreshToken = '/auth/refresh';
  static const profile = '/me';
  static const changePassword = '/me/password';
  static const deleteAccount = '/me';
}
