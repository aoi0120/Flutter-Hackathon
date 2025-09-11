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

  //   @override
  //   Widget build(BuildContext context) {
  //     return Container(
  //       width: EllipsesStyles.side,
  //       height: EllipsesStyles.side,
  //       decoration: BoxDecoration(
  //         shape: BoxShape.circle,
  //         color: Colors.green
  //       ),
  //       child: CustomPaint(
  //         painter: _EllipsesShapePainter(
  //           color: EllipsesStyles.color,
  //           shadow: EllipsesStyles.shadowColor,
  //           cornerRadius: EllipsesStyles.cornerRadius,
  //           bumpRadius: EllipsesStyles.bumpRadius,
  //           bumpHeight: EllipsesStyles.bumpHeight,
  //         ),
  //         child: const SizedBox.expand(),
  //       ),
  //     );
  //   }
}

// class _EllipsesShapePainter extends CustomPainter {}
