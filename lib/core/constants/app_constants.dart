class AppConstants {
  static const String baseUrl = 'http://10.0.2.2:3001'; // Default for Android Emulator
  // For physical devices or iOS, use your local machine's IP address:
  // static const String baseUrl = 'http://192.168.1.XX:3001';
  
  static const String requestLoginEndpoint = '/auth/request-login';
  static const String verifyLoginEndpoint = '/auth/verify';
  
  static const String tokenKey = 'accessToken';
}
