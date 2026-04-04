import 'dart:io';
import 'package:flutter/foundation.dart';

class AppConstants {
  /// Resolves the API Base URL.
  /// 
  /// Priority:
  /// 1. Values provided via --dart-define=APP_ENV=... (Full URL)
  /// 2. Local Fallback (localhost:3001 or 10.0.2.2:3001 for Android)
  static String get baseUrl {
    const String envUrl = String.fromEnvironment('APP_ENV');
    
    // If a full URL was injected from the terminal, use it as is.
    if (envUrl.isNotEmpty) {
      return envUrl;
    }

    // Default for local development without flags
    if (!kIsWeb && Platform.isAndroid) {
      return 'http://10.0.2.2:3001';
    }
    return 'http://localhost:3001';
  }
}
