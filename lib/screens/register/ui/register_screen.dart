import 'package:breach/screens/register/notifier/register_notifier.dart';
import 'package:breach/screens/register/ui_widget/register_button.dart';
import 'package:breach/screens/register/ui_widget/register_screen_widgets.dart';
import 'package:breach/screens/register/ui_widget/register_textfields.dart';
import 'package:breach/utils/theme/app_colors.dart';
import 'package:breach/utils/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterScreen extends ConsumerWidget {
  const RegisterScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppScaffold(
      isLoading: ref.watch(registerProvider).isLoading,
      padding: EdgeInsets.all(12),
      backgroundColor: AppColors.backgroundColor,
      body: ListView(
        children: const [
          SizedBox(height: 24),
          RegisterHeader(),
          SizedBox(height: 12),
          RegisterSubHeader(),
          SizedBox(height: 40),
          RegisterEmail(),
          SizedBox(height: 22),
          RegisterPassword(),
          SizedBox(height: 28),
          RegisterButton(),
          SizedBox(height: 18),
          RegisterLoginText(),
          SizedBox(height: 60),
          RegisterTermsText(),
          SizedBox(height: 24),
        ],
      ),
    );
  }
}
