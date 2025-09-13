import 'package:flutter/material.dart';
import '../../../top/layout.dart';
import '../arrow/arrow.dart';
import 'gachabox_styles.dart';
import 'rotatable_handle.dart';

class GachaBox extends StatelessWidget {
  const GachaBox({super.key, this.onHandleSpinCompleted});

  final VoidCallback? onHandleSpinCompleted;

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
          clipBehavior: Clip.none,
          children: [
            Image.asset(TopLayout.gachaAsset, width: boxWidth, fit: BoxFit.contain),
            Arrow(boxWidth: boxWidth),
            Positioned(
              right: GachaBoxStyles.handleRight,
              bottom: GachaBoxStyles.handleBottom,
              child: RotatableHandle(
                boxWidth: boxWidth,
                onSpinCompleted: onHandleSpinCompleted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

