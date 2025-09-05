import 'package:flutter/material.dart';

extension AppSnackBarExtension on BuildContext {
  void showAppSnackBar(String message, {bool long = false}) {
    final messenger = ScaffoldMessenger.of(this);
    messenger.hideCurrentSnackBar();

    messenger.showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(color: Colors.black)),
        duration: Duration(seconds: long ? 5 : 2),
        backgroundColor: Colors.white,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: Colors.black, width: 1.5),
        ),
        elevation: 0,
      ),
    );
  }
}
