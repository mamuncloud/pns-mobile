import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pns_mobile/core/presentation/widgets/glass_card.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:pns_mobile/features/auth/presentation/bloc/auth_bloc.dart';

class VerifyPage extends StatefulWidget {
  final String? token;
  const VerifyPage({super.key, this.token});

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  @override
  void initState() {
    super.initState();
    if (widget.token != null) {
      context.read<AuthBloc>().add(AuthVerifyToken(widget.token!));
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
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthSuccess) {
                  // Auto-redirect after 1.5s as in web
                  Future.delayed(const Duration(milliseconds: 1500), () {
                    if (context.mounted) {
                      // Navigate to Dashboard/Products (Mocked for now)
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Mengalihkan ke Dashboard...')),
                      );
                    }
                  });
                }
              },
              builder: (context, state) {
                final isLoading = state is AuthLoading;
                final isSuccess = state is AuthSuccess;
                final isError = state is AuthFailureState || widget.token == null;
                final errorMessage = (state is AuthFailureState) 
                    ? state.message 
                    : (widget.token == null ? 'Token tidak ditemukan. Tautan mungkin tidak valid.' : null);

                return ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: GlassCard(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          isLoading
                              ? 'MEMVERIFIKASI TAUTAN...'
                              : isSuccess
                                  ? 'LOGIN BERHASIL!'
                                  : 'VERIFIKASI GAGAL',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 32),
                        if (isLoading)
                          const SizedBox(
                            height: 48,
                            width: 48,
                            child: CircularProgressIndicator(strokeWidth: 3),
                          ),
                        if (isSuccess) ...[
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
                        if (isError) ...[
                          Icon(
                            LucideIcons.circleAlert,
                            size: 64,
                            color: theme.colorScheme.error,
                          ),
                          const SizedBox(height: 24),
                          Text(
                            errorMessage ?? 'Terjadi kesalahan sistem.',
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
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
