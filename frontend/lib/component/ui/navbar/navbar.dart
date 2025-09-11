import 'package:flutter/material.dart';
import 'navbar_styles.dart';

class AppNavBar extends StatelessWidget {
  const AppNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppNavBarStyles.height,
      width: double.infinity,
      child: CustomPaint(
        painter: _NavBarShapePainter(
          color: AppNavBarStyles.color,
          shadowColor: AppNavBarStyles.shadowColor,
          cornerRadius: AppNavBarStyles.cornerRadius,
          bumpRadius: AppNavBarStyles.bumpRadius,
          bumpHeight: AppNavBarStyles.bumpHeight,
        ),
        child: const SizedBox.expand(),
      ),
    );
  }
}

class _NavBarShapePainter extends CustomPainter {
  _NavBarShapePainter({
    required this.color,
    required this.shadowColor,
    required this.cornerRadius,
    required this.bumpRadius,
    required this.bumpHeight,
  });

  final Color color;
  final Color shadowColor;
  final double cornerRadius;
  final double bumpRadius;
  final double bumpHeight;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final r = cornerRadius;
    final cx = w / 2;

    final path = Path()
      ..moveTo(r, 0)
      ..arcToPoint(Offset(0, r), radius: Radius.circular(r), clockwise: false)
      ..lineTo(0, h - r)
      ..arcToPoint(Offset(r, h), radius: Radius.circular(r), clockwise: false)
      ..lineTo(w - r, h)
      ..arcToPoint(Offset(w, h - r), radius: Radius.circular(r), clockwise: false)
      ..lineTo(w, r)
      ..arcToPoint(Offset(w - r, 0), radius: Radius.circular(r), clockwise: false)
      ..lineTo(cx - bumpRadius, 0)
      ..quadraticBezierTo(cx, -bumpHeight, cx + bumpRadius, 0)
      ..lineTo(r, 0)
      ..close();

    canvas.drawShadow(path, shadowColor, 10, true);

    final paint = Paint()..color = color;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _NavBarShapePainter old) =>
      color != old.color ||
      shadowColor != old.shadowColor ||
      cornerRadius != old.cornerRadius ||
      bumpRadius != old.bumpRadius ||
      bumpHeight != old.bumpHeight;
}

