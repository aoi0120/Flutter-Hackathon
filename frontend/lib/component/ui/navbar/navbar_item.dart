import 'package:flutter/material.dart';

class NavBarItem extends StatelessWidget {
  const NavBarItem({
    super.key,
    required this.asset,
    required this.active,
    required this.onTap,
    this.width = 40,
    this.height = 40,
    this.offsetY = 0,
    this.hitSize = 72,
    this.hitOffsetY = 0,
  });

  final String asset;
  final bool active;
  final VoidCallback onTap;
  final double width;
  final double height;
  final double offsetY;
  final double hitSize;
  final double hitOffsetY;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: hitSize,
        height: hitSize,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Transform.translate(
              offset: Offset(0, offsetY),
              child: Image.asset(
                asset,
                width: width,
                height: height,
                fit: BoxFit.contain,
                filterQuality: FilterQuality.high,
                errorBuilder: (_, __, ___) =>
                    SizedBox(width: width, height: height),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

