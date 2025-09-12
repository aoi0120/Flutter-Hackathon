import 'package:flutter/material.dart';
import './_component/gacha/gacha.dart';
import './_component/gachabar/gachabar.dart';
import './_component/gachabar/gachabar_styles.dart';
import 'layout.dart';

class TopPage extends StatelessWidget {
  const TopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: TopLayout.bgColor,
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Center(child: Gacha()),
          Positioned(
            bottom: BarStyles.bottomOffset,
            left: 0,
            right: 0,
            child: const GachaBar(),
          ),
        ],
      ),
    );
  }
}

