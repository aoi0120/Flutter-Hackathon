import 'package:flutter/material.dart';

class NavBarItem extends StatelessWidget {
  const NavBarItem({
    super.key,
    required this.asset,
    required this.active,
    required this.onTap,
    required this.width,
    required this.height,
    required this.offsetY,
    required this.hitSize,
    required this.hitOffsetY,
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
    return Semantics(
      button: true,
      selected: active,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Transform.translate(
            offset: Offset(0, hitOffsetY),
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: onTap,
              child: SizedBox(width: hitSize, height: hitSize),
            ),
          ),

          Transform.translate(
            offset: Offset(0, offsetY),
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: onTap,
              child: SizedBox(
                width: width,
                height: height,
                child: Image.asset(
                  asset,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

