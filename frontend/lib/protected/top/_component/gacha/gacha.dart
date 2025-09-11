import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Gacha extends StatelessWidget {
  const Gacha({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        'assets/data/data.json',
        repeat: false,
        animate: true,
        reverse: false,           
        fit: BoxFit.contain,
      ),
    );
  }
}

