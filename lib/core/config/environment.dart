enum AppEnvironment {
  dev(
    name: 'dev',
    apiBaseUrl: 'https://dev-api.example.com',
    connectTimeoutMs: 15000,
    receiveTimeoutMs: 15000,
  ),
  staging(
    name: 'staging',
    apiBaseUrl: 'https://staging-api.example.com',
    connectTimeoutMs: 15000,
    receiveTimeoutMs: 15000,
  ),
  prod(
    name: 'prod',
    apiBaseUrl: 'https://api.example.com',
    connectTimeoutMs: 20000,
    receiveTimeoutMs: 20000,
  );

  const AppEnvironment({
    required this.name,
    required this.apiBaseUrl,
    required this.connectTimeoutMs,
    required this.receiveTimeoutMs,
  });

  final String name;
  final String apiBaseUrl;
  final int connectTimeoutMs;
  final int receiveTimeoutMs;
}

class EnvironmentConfig {
  EnvironmentConfig._();

  static AppEnvironment current = AppEnvironment.dev;

  static void setEnvironment(AppEnvironment environment) {
    current = environment;
  }
}
