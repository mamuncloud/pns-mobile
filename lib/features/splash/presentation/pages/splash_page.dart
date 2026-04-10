import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pns_mobile/features/auth/presentation/pages/login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  void _navigateToNext() async {
    // Wait for 3 seconds to show the premium splash
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC62828),
      body: Stack(
        children: [
          // Background star patterns
          Positioned.fill(
            child: CustomPaint(
              painter: StarPainter(),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 3),
                // Premium Logo in White Squircle
                Container(
                  width: 320,
                  height: 320,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(72),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 30,
                        offset: const Offset(0, 15),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(32),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.asset(
                      'assets/launcher_icon.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 48),
                // Stylized Text
                Text(
                  'PLANET NYEMIL\nSNACK',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.outfit(
                    fontSize: 36,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: 2.5,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 16),
                // Yellow Underline
                Container(
                  width: 64,
                  height: 5,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFB300),
                    borderRadius: BorderRadius.circular(2.5),
                  ),
                ),
                const Spacer(flex: 2),
                // Pagination Dots
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildDot(active: true),
                    const SizedBox(width: 8),
                    _buildDot(active: false),
                    const SizedBox(width: 8),
                    _buildDot(active: false),
                  ],
                ),
                const SizedBox(height: 24),
                // Premium Footer
                Text(
                  'Planet Nyemil Snack',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Colors.white.withOpacity(0.7),
                    letterSpacing: 4.0,
                  ),
                ),
                const SizedBox(height: 64),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot({required bool active}) {
    return Container(
      width: active ? 16 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: active ? Colors.white : Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

class StarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(0.15);
    final random = java_math_Random(42); // Fixed seed for stable stars

    // Draw small stars
    for (int i = 0; i < 60; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final radius = random.nextDouble() * 1.5;
      canvas.drawCircle(Offset(x, y), radius, paint);
    }

    // Draw a couple of larger faint icons or stars (optional)
    final largeStarPaint = Paint()..color = Colors.white.withOpacity(0.05);
    canvas.drawCircle(
        Offset(size.width * 0.1, size.height * 0.1), 100, largeStarPaint);
    canvas.drawCircle(
        Offset(size.width * 0.9, size.height * 0.8), 150, largeStarPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Simple random generator for CustomPainter since we don't want external dependencies
class java_math_Random {
  int seed;
  java_math_Random(this.seed);
  double nextDouble() {
    seed = (seed * 1103515245 + 12345) & 0x7fffffff;
    return seed / 0x7fffffff;
  }
}
