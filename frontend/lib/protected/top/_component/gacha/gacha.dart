import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Gacha extends StatefulWidget {
  const Gacha({
    super.key,
    this.onCompleted,
  });

  final VoidCallback? onCompleted;

  @override
  State<Gacha> createState() => _GachaState();
}

class _GachaState extends State<Gacha> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onCompleted?.call();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      'assets/data/data.json',
      controller: _controller,
      onLoaded: (comp) {
        _controller
          ..duration = comp.duration
          ..forward();
      },
      repeat: false,
      fit: BoxFit.contain,
    );
  }
}

