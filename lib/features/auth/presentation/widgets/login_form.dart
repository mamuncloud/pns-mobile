import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:pns_mobile/features/auth/presentation/bloc/auth_bloc.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _identifierController = TextEditingController();

  @override
  void dispose() {
    _identifierController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (!_formKey.currentState!.validate()) return;
    context.read<AuthBloc>().add(AuthRequestLogin(_identifierController.text));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;
        final isSent = state is AuthRequestSent;

        if (isSent) {
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
                onPressed: () => context.read<AuthBloc>().add(AuthInitialCheckRequested()),
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
                enabled: !isLoading,
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
              if (state is AuthFailureState) ...[
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
                          state.message,
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
                onPressed: isLoading ? null : _handleSubmit,
                child: isLoading
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
      },
    );
  }
}
