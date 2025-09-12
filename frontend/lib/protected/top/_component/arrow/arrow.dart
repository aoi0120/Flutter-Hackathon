import 'package:flutter/material.dart';
import '../../../top/layout.dart';
import 'arrow_styles.dart';

class Arrow extends StatelessWidget {
  const Arrow({super.key, required this.boxWidth});

  final double boxWidth;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: ArrowStyles.rightOffset,
      bottom: ArrowStyles.aboveHandle,
      child: Image.asset(
        TopLayout.arrowAsset,
        width: boxWidth * ArrowStyles.widthFactor,
        fit: BoxFit.contain,
      ),
    );
  }
}

