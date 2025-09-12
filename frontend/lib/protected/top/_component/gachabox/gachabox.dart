import 'package:flutter/material.dart';
import '../../../top/layout.dart';
import 'gachabox_styles.dart';

class GachaBox extends StatelessWidget {
  const GachaBox({super.key});

  @override
  Widget build(BuildContext context) {
    final boxWidth =
        MediaQuery.of(context).size.width * GachaBoxStyles.widthFactor;

    return Align(
      alignment: Alignment(0, GachaBoxStyles.alignmentY),
      child: SizedBox(
        width: boxWidth,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              TopLayout.gachaAsset,
              width: boxWidth,
              fit: BoxFit.contain,
            ),

            Positioned(
              right: GachaBoxStyles.handleRight,
              bottom: GachaBoxStyles.handleBottom,
              child: Image.asset(
                TopLayout.handleAsset,
                width: boxWidth * GachaBoxStyles.handleWidthFactor,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

