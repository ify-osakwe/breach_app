import 'package:flutter/material.dart';

class StreamScreenAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  const StreamScreenAppbar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(120);

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Streams',
              style: t.headlineMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            Flexible(
              child: Text(
                'Discover trending content from topics you care about in real time',
                style: t.bodyMedium?.copyWith(
                  color: Colors.black.withValues(alpha: 0.7),
                  height: 1.2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
