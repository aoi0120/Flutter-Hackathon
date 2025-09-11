import 'dart:math';

import 'package:flutter/material.dart';
import 'ellipses_styles.dart';

class EllipsesButton extends StatelessWidget {
  const EllipsesButton({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: EllipsesStyles.side,
      height: EllipsesStyles.side,
      decoration: const BoxDecoration(shape: BoxShape.circle),

      child: Column(children: []),
    );
  }

  
  final drawCircle = (
    
  )
  final Paint _paint = Paint(),
  

  @override
  void _drawRound(Canvas canvas) {
    _paint.color = Colors.green;
    canvas.save();
    canvas.translate(0, 0);
    canvas.drawCircle(const Offset(0, 0), 25, _paint);
    canvas.restore();

    final path = Path()
      ..moveTo(0, 0)
      ..close();
    canvas.drawShadow(path, const Color(0xFF000000), 4.0, true);
  }
}
