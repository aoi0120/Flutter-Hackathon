import 'package:flutter/material.dart';
import './_component/gacha/gacha.dart';
import 'layout.dart';

class TopPage extends StatelessWidget {
  const TopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: TopLayout.bgColor,
      child: const Gacha(),
    );
  }
}

