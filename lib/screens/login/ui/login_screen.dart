import 'package:breach/screens/login/notifier/login_notifier.dart';
import 'package:breach/utils/widgets/app_scaffold.dart';
import 'package:breach/utils/widgets/overlays.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(loginProvider);
    return AppScaffold(
      appBar: AppBar(title: Text('Login')),
      body: Column(
        children: [
          LinearLoadingIndicator(loading: state.isLoading),
          TextField(controller: state.emailController),
          TextField(controller: state.passwordController),
          ElevatedButton(
            onPressed: () {
              ref.read(loginProvider.notifier).login(context: context);
            },
            child: Text('Login'),
          ),
        ],
      ),
    );
  }
}
