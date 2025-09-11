import 'package:flutter/material.dart';
import 'navbar_styles.dart';
import 'navbar_item.dart';

class NavBar extends StatelessWidget {
  const NavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final double topPad = (NavBarStyles.bumpHeight - 12).clamp(0, 30).toDouble();

    return SizedBox(
      height: NavBarStyles.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size.infinite,
            painter: _NavBarShapePainter(
              color: NavBarStyles.color,
              shadowColor: NavBarStyles.shadowColor,
              cornerRadius: NavBarStyles.cornerRadius,
              bumpRadius: NavBarStyles.bumpRadius,
              bumpHeight: NavBarStyles.bumpHeight,
            ),
          ),

          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: topPad),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: NavBarItem(
                      asset: 'assets/images/map.png',
                      active: currentIndex == 0,
                      onTap: () => onTap(0),
                      width: 40,
                      height: 40,
                      offsetY: -25,
                      hitSize: 50,
                      hitOffsetY: -25,
                    ),
                  ),
                  Expanded(
                    child: NavBarItem(
                      asset: 'assets/images/gacha.png',
                      active: currentIndex == 1,
                      onTap: () => onTap(1),
                      width: 80,
                      height: 80,
                      offsetY: -45,
                      hitSize: 70,
                      hitOffsetY: -40,
                    ),
                  ),
                  Expanded(
                    child: NavBarItem(
                      asset: 'assets/images/others.png',
                      active: currentIndex == 2,
                      onTap: () => onTap(2),
                      width: 35,
                      height: 35,
                      offsetY: -20,
                      hitSize: 50,
                      hitOffsetY: -25,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
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
      ..arcToPoint(
        Offset(0, r),
        radius: Radius.circular(r),
        clockwise: false,
      )
      ..lineTo(0, h - r)
      ..arcToPoint(
        Offset(r, h),
        radius: Radius.circular(r),
        clockwise: false,
      )
      ..lineTo(w - r, h)
      ..arcToPoint(
        Offset(w, h - r),
        radius: Radius.circular(r),
        clockwise: false,
      )
      ..lineTo(w, r)
      ..arcToPoint(
        Offset(w - r, 0),
        radius: Radius.circular(r),
        clockwise: false,
      )
      ..lineTo(cx - bumpRadius, 0)
      ..quadraticBezierTo(cx, -bumpHeight, cx + bumpRadius, 0)
      ..lineTo(r, 0)
      ..close();

    canvas.drawShadow(path, shadowColor, 10, true);
    canvas.drawPath(path, Paint()..color = color);
  }

  @override
  bool shouldRepaint(covariant _NavBarShapePainter old) =>
      color != old.color ||
      shadowColor != old.shadowColor ||
      cornerRadius != old.cornerRadius ||
      bumpRadius != old.bumpRadius ||
      bumpHeight != old.bumpHeight;
}

