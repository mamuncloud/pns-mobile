class AppConstants {
  static const String baseUrl = String.fromEnvironment(
    'API_URL',
    defaultValue: 'https://api.planetnyemilsnack.store',
  );
  // Note: For local development, you can override this with:
  // flutter run --dart-define=API_URL=http://localhost:3001

  static const String requestLoginEndpoint = '/auth/request-login';
  static const String verifyLoginEndpoint = '/auth/verify';

  static const String tokenKey = 'accessToken';
}
