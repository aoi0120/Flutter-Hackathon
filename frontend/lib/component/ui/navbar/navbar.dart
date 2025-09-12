import 'package:flutter/material.dart';
import 'navbar_styles.dart';
import 'navbar_item.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key, required this.currentIndex, required this.onTap});

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final double topPad = (NavBarStyles.bumpHeight - 12)
        .clamp(0, 30)
        .toDouble();

    return SizedBox(
      height: NavBarStyles.height,
      width: double.infinity,
      child: RepaintBoundary(
        child: Stack(
          alignment: Alignment.center,
          children: [
            _NavBarShape(
              color: NavBarStyles.color,
              shadowColor: NavBarStyles.shadowColor,
              cornerRadius: NavBarStyles.cornerRadius,
              bumpRadius: NavBarStyles.bumpRadius,
              bumpHeight: NavBarStyles.bumpHeight,
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
                        hitSize: 70,
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
                        hitSize: 90,
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
                        hitSize: 70,
                        hitOffsetY: -25,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavBarShape extends StatelessWidget {
  const _NavBarShape({
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
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, c) {
        final size = Size(c.maxWidth, c.maxHeight);
        final path = _buildPath(size);
        return CustomPaint(
          size: size,
          painter: _NavBarPainter(
            path: path,
            color: color,
            shadowColor: shadowColor,
          ),
        );
      },
    );
  }

  Path _buildPath(Size size) {
    final w = size.width;
    final h = size.height;
    final r = cornerRadius;
    final cx = w / 2;

    return Path()
      ..moveTo(r, 0)
      ..arcToPoint(Offset(0, r), radius: Radius.circular(r), clockwise: false)
      ..lineTo(0, h - r)
      ..arcToPoint(Offset(r, h), radius: Radius.circular(r), clockwise: false)
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
  }
}

class _NavBarPainter extends CustomPainter {
  _NavBarPainter({
    required this.path,
    required this.color,
    required this.shadowColor,
  });

  final Path path;
  final Color color;
  final Color shadowColor;

  @override
  void paint(Canvas canvas, Size size) {
    // 上方向にだけ影を描画
    canvas.drawShadow(
      path.shift(const Offset(0, -3)), // yをマイナス方向にずらして影を上へ
      shadowColor,
      12.0, // ぼかし半径を強める
      false,
    );

    // 本体の塗り
    final paint = Paint()..color = color;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _NavBarPainter old) => false;
}
