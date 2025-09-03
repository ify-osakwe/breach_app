import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PersonaliseTitle extends ConsumerWidget {
  const PersonaliseTitle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        const SizedBox(height: 16),
        const CircleAvatar(
          radius: 36,
          backgroundColor: Color(0xFFF3F4F6),
          child: Text('🦫', style: TextStyle(fontSize: 36)),
        ),
        const SizedBox(height: 16),
        const Text(
          "What are your interests?",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Text(
            "Select your interests and I'll recommend some series I'm certain you'll enjoy!",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.black54),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
