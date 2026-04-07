import 'package:flutter_test/flutter_test.dart';
import 'package:pns_mobile/init_dependencies.dart';
import 'package:pns_mobile/main.dart';

void main() {
  setUpAll(() async {
    // Initialize dependencies for the test.
    await initDependencies();
  });

  testWidgets('App starts with Login page smoke test', (
    WidgetTester tester,
  ) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // Verify that the login form is present.
    expect(find.text('OTENTIKASI AKSES STAF'), findsOneWidget);
    expect(find.text('AKSES VIA LINK EMAIL & WHATSAPP'), findsOneWidget);
  });
}
