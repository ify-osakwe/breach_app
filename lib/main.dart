import 'package:breach/routes/routes_top.dart';
import 'package:breach/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:overlay_support/overlay_support.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: MaterialApp.router(
        title: 'Breach',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Inter',
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.purple600),
        ),
        routerConfig: goRouter,
      ),
    );
  }
}
