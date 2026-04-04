import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _identifierController = TextEditingController();
  bool _isLoading = false;
  bool _isSent = false;
  String? _error;

  @override
  void dispose() {
    _identifierController.dispose();
    super.dispose();
  }

  void _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _error = null;
    });

    // Simulate API call matching pns-web logic
    try {
      await Future.delayed(const Duration(seconds: 2));
      setState(() {
        _isSent = true;
      });
    } catch (e) {
      setState(() {
        _error = "Gagal mengirim tautan. Silakan coba lagi.";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (_isSent) {
      return Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              LucideIcons.circleCheck,
              size: 48,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'PERIKSA EMAIL & WHATSAPP',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 18,
              letterSpacing: -0.5,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 8),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: theme.textTheme.bodyMedium,
              children: [
                const TextSpan(text: 'Kami telah mengirimkan tautan akses ke '),
                TextSpan(
                  text: _identifierController.text,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: theme.primaryColor,
                    decoration: TextDecoration.underline,
                  ),
                ),
                const TextSpan(
                  text: ' dan saluran komunikasi Anda lainnya yang terdaftar.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'TAUTAN BERLAKU SELAMA 10 MENIT',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.5,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 32),
          OutlinedButton(
            onPressed: () => setState(() => _isSent = false),
            child: const Text('GUNAKAN IDENTITAS LAIN'),
          ),
        ],
      );
    }

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _identifierController,
            decoration: const InputDecoration(
              hintText: '0812XXXXXXXX / email@pns.com',
              prefixIcon: Icon(LucideIcons.phone, size: 18),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Harap masukkan nomor atau email';
              }
              return null;
            },
            enabled: !_isLoading,
          ),
          const SizedBox(height: 12),
          const Text(
            'LINK AKAN DIKIRIM KE WHATSAPP & EMAIL',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              letterSpacing: 1.2,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          if (_error != null) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.colorScheme.error.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    LucideIcons.circleAlert,
                    size: 16,
                    color: theme.colorScheme.error,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _error!,
                      style: TextStyle(
                        color: theme.colorScheme.error,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: _isLoading ? null : _handleSubmit,
            child: _isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      color: Colors.black,
                    ),
                  )
                : const Text('DAPATKAN TAUTAN AKSES'),
          ),
        ],
      ),
    );
  }
}
