// ignore_for_file: use_build_context_synchronously

import 'package:breach/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    goToNextPage();
  }

  void goToNextPage() async {
    await Future.delayed(Duration(milliseconds: 1500));
    context.go(Routes.register);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircleAvatar(
          child: CircleAvatar(
            radius: 100,
            child: Image.asset(scale: 1.5, "assets/images/beaver.png"),
          ),
        ),
      ),
    );
  }
}
