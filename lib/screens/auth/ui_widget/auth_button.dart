import 'package:breach/screens/auth/notifier/auth_notifier.dart';
import 'package:breach/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthButton extends ConsumerWidget {
  const AuthButton({super.key, required this.text, required this.isRegister});

  final String text;
  final bool isRegister;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authProvider);
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: state.enableButton
              ? AppColors.black
              : AppColors.grey3,
          foregroundColor: state.enableButton
              ? AppColors.white
              : AppColors.grey2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        onPressed: state.enableButton
            ? () {
                if (isRegister) {
                  ref.read(authProvider.notifier).register(context: context);
                } else {
                  ref.read(authProvider.notifier).login(context: context);
                }
              }
            : null,
        child: Text(
          text,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
