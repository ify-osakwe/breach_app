import 'package:breach/routes/routes.dart';
import 'package:breach/screens/register/notifier/register_notifier.dart';
import 'package:breach/utils/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(registerProvider);
    //
    return AppScaffold(
      isLoading: state.isLoading,
      body: Column(
        children: [
          TextField(controller: state.emailController),
          TextField(controller: state.passwordController),
          ElevatedButton(
            onPressed: () {
              ref.read(registerProvider.notifier).register(context: context);
            },
            child: Text('Register'),
          ),
          TextButton(
            onPressed: () => context.go(Routes.login),
            child: Text('Already have an account? Login'),
          ),
        ],
      ),
    );
  }
}
