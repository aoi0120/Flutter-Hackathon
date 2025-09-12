import 'package:flutter/material.dart';
import './_component/gacha/gacha.dart';
import './_component/gacha/item_button.dart';
import 'layout.dart';

class TopPage extends StatelessWidget {
  const TopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TopLayout.bgColor,
      body: SafeArea(
        child: Column(
          children: [
            const ItemButton(),
            Expanded(child: const Gacha()),
          ],
        ),
      ),
    );
  }
}
