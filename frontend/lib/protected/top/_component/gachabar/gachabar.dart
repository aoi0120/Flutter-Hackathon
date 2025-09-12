import 'package:flutter/material.dart';
import 'gachabar_styles.dart';

class GachaBar extends StatelessWidget {
  const GachaBar({
    super.key,
    this.asset = BarStyles.asset,
    this.widthFactor = BarStyles.widthFactor,
    this.bottomPadding = BarStyles.bottomPadding,
  });

  final String asset;
  final double widthFactor;
  final double bottomPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding),
      child: Image.asset(
        asset,
        width: MediaQuery.of(context).size.width * widthFactor,
        fit: BoxFit.contain,
        filterQuality: FilterQuality.low, 
      ),
    );
  }
}

