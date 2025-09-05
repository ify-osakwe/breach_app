import 'package:breach/screens/auth/notifier/auth_notifier.dart';
import 'package:breach/screens/auth/ui_widget/auth_screen_widgets.dart';
import 'package:breach/screens/auth/ui_widget/auth_textfields.dart';
import 'package:breach/screens/auth/ui_widget/auth_button.dart';
import 'package:breach/utils/theme/app_colors.dart';
import 'package:breach/utils/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppScaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: AppColors.backgroundColor,
      ),
      isLoading: ref.watch(authProvider).isLoading,
      padding: EdgeInsets.all(12),
      backgroundColor: AppColors.backgroundColor,
      body: ListView(
        children: const [
          SizedBox(height: 24),
          LoginHeader(),
          SizedBox(height: 24),
          AuthEmail(),
          SizedBox(height: 16),
          AuthPassword(),
          SizedBox(height: 32),
          AuthButton(text: 'Login', isRegister: false),
          SizedBox(height: 16),
          SignupText(),
        ],
      ),
    );
  }
}
