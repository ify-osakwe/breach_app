import 'package:breach/screens/auth/notifier/auth_notifier.dart';
import 'package:breach/screens/auth/ui_widget/auth_button.dart';
import 'package:breach/screens/auth/ui_widget/auth_screen_widgets.dart';
import 'package:breach/screens/auth/ui_widget/auth_textfields.dart';
import 'package:breach/utils/theme/app_colors.dart';
import 'package:breach/utils/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterScreen extends ConsumerWidget {
  const RegisterScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppScaffold(
      isLoading: ref.watch(authProvider).isLoading,
      padding: EdgeInsets.all(12),
      backgroundColor: AppColors.backgroundColor,
      body: ListView(
        children: [
          SizedBox(height: 24),
          RegisterHeader(),
          SizedBox(height: 12),
          RegisterSubHeader(),
          SizedBox(height: 40),
          AuthEmail(),
          SizedBox(height: 22),
          AuthPassword(),
          SizedBox(height: 28),
          AuthButton(text: 'Continue', isRegister: true),
          SizedBox(height: 18),
          LoginText(),
          SizedBox(height: 60),
          RegisterTermsText(),
          SizedBox(height: 24),
        ],
      ),
    );
  }
}
