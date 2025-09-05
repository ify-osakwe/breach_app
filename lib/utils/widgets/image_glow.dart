import 'package:flutter/material.dart';

class AvatarWithCornerGlow extends StatelessWidget {
  const AvatarWithCornerGlow({
    super.key,
    required this.radius,
    required this.backgroundColor,
    required this.imageAsset,
  });

  final double radius;
  final Color backgroundColor;
  final String imageAsset;

  @override
  Widget build(BuildContext context) {
    final size = radius * 2;
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: _CornerGlowPainter(
                glowColor: Colors.black.withValues(alpha: 0.25),
                radius: radius * 1.2,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: backgroundColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.20),
                  blurRadius: 20,
                  spreadRadius: 2,
                  offset: const Offset(0, 8),
                ),
                BoxShadow(
                  color: Colors.white.withValues(alpha: 0.10),
                  blurRadius: 14,
                  spreadRadius: -4,
                  offset: const Offset(-6, -6),
                ),
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 14,
                  spreadRadius: -4,
                  offset: const Offset(6, 6),
                ),
              ],
            ),
            child: CircleAvatar(
              backgroundColor: backgroundColor,
              radius: radius,
              child: Image.asset(imageAsset),
            ),
          ),
        ],
      ),
    );
  }
}

class _CornerGlowPainter extends CustomPainter {
  _CornerGlowPainter({required this.glowColor, required this.radius});

  final Color glowColor;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final topLeft = Offset(0, 0);
    final topRight = Offset(size.width, 0);
    final bottomLeft = Offset(0, size.height);
    final bottomRight = Offset(size.width, size.height);

    final cornerOffsets = [topLeft, topRight, bottomLeft, bottomRight];

    for (final c in cornerOffsets) {
      final gradient = RadialGradient(
        colors: [glowColor, glowColor.withValues(alpha: 0.0)],
        stops: const [0.0, 1.0],
      );
      final paint = Paint()
        ..shader = gradient.createShader(
          Rect.fromCircle(center: c, radius: radius),
        );
      canvas.drawRect(rect, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _CornerGlowPainter oldDelegate) {
    return oldDelegate.glowColor != glowColor || oldDelegate.radius != radius;
  }
}
