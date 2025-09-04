import 'package:breach/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterLoginText extends StatelessWidget {
  const RegisterLoginText({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => context.go(Routes.login),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Already have an account? ',
            style: theme.textTheme.bodyMedium?.copyWith(color: Colors.black87),
          ),
          RichText(
            text: TextSpan(
              text: 'Log in',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: const Color(0xFF7C3AED), // purple like screenshot
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RegisterTermsText extends StatelessWidget {
  const RegisterTermsText({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: theme.textTheme.bodySmall?.copyWith(
          color: Colors.black54,
          height: 1.4,
        ),
        children: [
          const TextSpan(text: "By signing up, you agree to Breach's "),
          TextSpan(
            text: 'Terms',
            style: const TextStyle(
              color: Color(0xFF7C3AED),
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.underline,
            ),
          ),
          const TextSpan(text: ' & '),
          TextSpan(
            text: 'Privacy Policy',
            style: const TextStyle(
              color: Color(0xFF7C3AED),
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.underline,
            ),
          ),
        ],
      ),
    );
  }
}

class RegisterHeader extends StatelessWidget {
  const RegisterHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      'Join Breach',
      textAlign: TextAlign.center,
      style: theme.textTheme.displaySmall?.copyWith(
        fontWeight: FontWeight.w800,
        color: Colors.black,
        letterSpacing: -0.5,
      ),
    );
  }
}

class RegisterSubHeader extends StatelessWidget {
  const RegisterSubHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      'Break through the noise and discover content that matters to you in under 3 minutes.',
      textAlign: TextAlign.center,
      style: theme.textTheme.titleMedium?.copyWith(
        color: Colors.black.withValues(alpha: 0.7),
        height: 1.35,
      ),
    );
  }
}
