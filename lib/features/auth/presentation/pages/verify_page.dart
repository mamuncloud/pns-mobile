import 'package:flutter/material.dart';
import 'package:pns_mobile/core/presentation/widgets/glass_card.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class VerifyPage extends StatefulWidget {
  final String? token;
  const VerifyPage({super.key, this.token});

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  late String _status; // 'loading', 'success', 'error'
  String? _error;

  @override
  void initState() {
    super.initState();
    _status = widget.token != null ? 'loading' : 'error';
    if (widget.token == null) {
      _error = "Token tidak ditemukan. Tautan mungkin tidak valid.";
    } else {
      _verifyToken();
    }
  }

  Future<void> _verifyToken() async {
    // Simulate verification delay matching web's 1.5s
    try {
      await Future.delayed(const Duration(seconds: 2));

      // Mocking successful verification
      if (mounted) {
        setState(() {
          _status = 'success';
        });

        // Auto-redirect after 1.5s as in web
        Future.delayed(const Duration(milliseconds: 1500), () {
          if (mounted) {
            // Navigate to Dashboard/Products (Mocked)
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Mengalihkan ke Dashboard...')),
            );
          }
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _status = 'error';
          _error = "Gagal memverifikasi tautan. Mungkin sudah kedaluwarsa.";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF121212) : const Color(0xFFF9FAFB),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: GlassCard(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _status == 'loading'
                          ? 'MEMVERIFIKASI TAUTAN...'
                          : _status == 'success'
                          ? 'LOGIN BERHASIL!'
                          : 'VERIFIKASI GAGAL',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 32),
                    if (_status == 'loading')
                      const SizedBox(
                        height: 48,
                        width: 48,
                        child: CircularProgressIndicator(strokeWidth: 3),
                      ),
                    if (_status == 'success') ...[
                      const Icon(
                        LucideIcons.circleCheck,
                        size: 64,
                        color: Colors.green,
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Mengautentikasi... Anda akan segera dialihkan.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                    if (_status == 'error') ...[
                      Icon(
                        LucideIcons.circleAlert,
                        size: 64,
                        color: theme.colorScheme.error,
                      ),
                      const SizedBox(height: 24),
                      Text(
                        _error ?? 'Terjadi kesalahan sistem.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: theme.colorScheme.error),
                      ),
                      const SizedBox(height: 32),
                      TextButton(
                        onPressed: () {
                          // Go back to login screen
                          Navigator.of(context).pop();
                        },
                        child: const Text('KEMBALI KE LOGIN'),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
