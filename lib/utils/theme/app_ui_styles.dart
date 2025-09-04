import 'package:flutter/material.dart';

abstract class AppUiStyles {
  static final inputDecoration = InputDecoration(
    hintStyle: const TextStyle(color: Color(0xFF9E9E9E)),
    filled: true,
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
    enabledBorder: _border(const Color(0xFFE0E0E0)),
    focusedBorder: _border(Colors.black87),
    errorBorder: _border(Colors.red.shade300),
    focusedErrorBorder: _border(Colors.red.shade400),
  );

  static InputBorder _border(Color c) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: c, width: 1),
  );

  static labelStyle(BuildContext context) => Theme.of(context)
      .textTheme
      .labelLarge
      ?.copyWith(color: Colors.grey.shade700, fontWeight: FontWeight.w500);
}
