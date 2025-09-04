import 'package:breach/screens/auth/notifier/auth_notifier.dart';
import 'package:breach/utils/theme/app_ui_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterEmail extends ConsumerStatefulWidget {
  const RegisterEmail({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterEmailState();
}

class _RegisterEmailState extends ConsumerState<RegisterEmail> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authProvider);
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text('Email', style: AppUiStyles.labelStyle(context)),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: state.emailController,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          decoration: AppUiStyles.inputDecoration.copyWith(
            hintText: 'Enter email',
          ),
          onChanged: (_) => ref.read(authProvider.notifier).validateInputs(),
          validator: (v) {
            final value = v?.trim() ?? '';
            if (value.isEmpty) return 'Email is required';
            if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value)) {
              return 'Enter a valid email';
            }
            return null;
          },
        ),
      ],
    );
  }
}

class RegisterPassword extends ConsumerStatefulWidget {
  const RegisterPassword({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RegisterPasswordState();
}

class _RegisterPasswordState extends ConsumerState<RegisterPassword> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authProvider);
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text('Password', style: AppUiStyles.labelStyle(context)),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: state.passwordController,
          obscureText: _obscure,
          decoration: AppUiStyles.inputDecoration.copyWith(
            hintText: 'Enter password',
            suffixIcon: IconButton(
              onPressed: () {
                setState(() => _obscure = !_obscure);
              },
              icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
            ),
          ),
          onChanged: (_) => ref.read(authProvider.notifier).validateInputs(),
          validator: (v) =>
              (v == null || v.isEmpty) ? 'Password is required' : null,
        ),
      ],
    );
  }
}
