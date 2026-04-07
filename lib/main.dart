import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pns_mobile/core/constants/app_constants.dart';
import 'package:pns_mobile/core/theme/app_theme.dart';
import 'package:pns_mobile/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pns_mobile/features/auth/presentation/pages/login_page.dart';
import 'package:pns_mobile/features/auth/presentation/pages/verify_page.dart';
import 'package:pns_mobile/features/counter/presentation/bloc/counter_bloc.dart';
import 'package:pns_mobile/init_dependencies.dart';

// Global key for navigation from outside the widget tree
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();

  // Verification Log
  debugPrint('🚀 [PNS] Active API Base URL: ${AppConstants.baseUrl}');

  final app = MyApp();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => serviceLocator<AuthBloc>()),
        BlocProvider(create: (_) => CounterBloc()),
      ],
      child: app,
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSubscription;

  @override
  void initState() {
    super.initState();
    _initDeepLinking();
  }

  void _initDeepLinking() async {
    _appLinks = AppLinks();

    // 1. Handle the initial link (cold start)
    final initialLink = await _appLinks.getInitialLink();
    if (initialLink != null) {
      _handleDeepLink(initialLink);
    }

    // 2. Listen for incoming links (bg/fg)
    _linkSubscription = _appLinks.uriLinkStream.listen((uri) {
      _handleDeepLink(uri);
    });
  }

  String? _lastToken;
  DateTime? _lastHandleTime;

  void _handleDeepLink(Uri uri) {
    if (uri.path == '/staff/verify') {
      final token = uri.queryParameters['token'];
      if (token == null) return;

      // Deduplicate: ignore if same token handled within last 2 seconds
      if (token == _lastToken &&
          _lastHandleTime != null &&
          DateTime.now().difference(_lastHandleTime!).inSeconds < 2) {
        debugPrint('⏭️ [PNS] Skipping duplicate deep link: $token');
        return;
      }

      _lastToken = token;
      _lastHandleTime = DateTime.now();

      debugPrint('🔗 [PNS] Handling deep link: $token');

      // Navigate to VerifyPage if navigatorKey is ready
      navigatorKey.currentState?.push(
        MaterialPageRoute(builder: (context) => VerifyPage(token: token)),
      );
    }
  }

  @override
  void dispose() {
    _linkSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'PNS Mobile',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const LoginPage(),
    );
  }
}
