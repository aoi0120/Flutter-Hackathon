import 'package:flutter/material.dart';
import './_component/gacha/gacha.dart';
import './_component/gachabox/gachabox.dart';
import './_component/gachabar/gachabar.dart';
import './_component/gachabar/gachabar_styles.dart';
import 'layout.dart';

class TopPage extends StatefulWidget {
  const TopPage({super.key});

  @override
  State<TopPage> createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  bool _animationDone = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: TopLayout.bgColor,
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Center(child: GachaBox()),
          if (!_animationDone)
            Center(
              child: Gacha(
                onCompleted: () {
                  setState(() => _animationDone = true);
                },
              ),
            ),
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

