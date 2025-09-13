import 'package:flutter/material.dart';
import './_component/gacha/gacha.dart';
import './_component/gachabox/gachabox.dart';
import './_component/gachabar/gachabar.dart';
import './_component/gachabar/gachabar_styles.dart';
import './_component/itemButton/item_button.dart';
import 'layout.dart';

class TopPage extends StatefulWidget {
  const TopPage({super.key});

  @override
  State<TopPage> createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  bool _initialPlayed = false;
  bool _showCapsule = false;

  void _onHandleSpinDone() {
    setState(() => _showCapsule = true);
  }

  void _onCapsuleCompleted() {
    setState(() => _showCapsule = false);
    // TODO: 結果表示に遷移
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: TopLayout.bgColor,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Center(
            child: GachaBox(
              onHandleSpinCompleted: _onHandleSpinDone,
            ),
          ),
          if (!_initialPlayed)
            Center(
              child: Gacha(
                assetPath: 'assets/data/data.json',
                onCompleted: () => setState(() => _initialPlayed = true),
              ),
            ),
          if (_showCapsule)
            Center(
              child: Gacha(
                assetPath: 'assets/data/gacha.json',
                onCompleted: _onCapsuleCompleted,
              ),
            ),
          Positioned(
            bottom: BarStyles.bottomOffset,
            left: 0,
            right: 0,
            child: const GachaBar(),
          ),

          const ItemButton(),
        ],
      ),
    );
  }
}

