import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../top/layout.dart';
import 'gachabox_styles.dart';

class RotatableHandle extends StatefulWidget {
  const RotatableHandle({
    super.key,
    required this.boxWidth,
    this.onSpinCompleted,
  });

  final double boxWidth;
  final VoidCallback? onSpinCompleted;

  @override
  State<RotatableHandle> createState() => _RotatableHandleState();
}

class _RotatableHandleState extends State<RotatableHandle>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c;
  late final Animation<double> _rot;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..addStatusListener((s) {
        if (s == AnimationStatus.completed) {
          widget.onSpinCompleted?.call();
        }
      });

    _rot = Tween<double>(begin: 0, end: 2 * math.pi).animate(
      CurvedAnimation(parent: _c, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() { _c.dispose(); super.dispose(); }

  void _onTap() {
    _c..reset()..forward();
  }

  @override
  Widget build(BuildContext context) {
    final w = widget.boxWidth * GachaBoxStyles.handleWidthFactor;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _onTap,
      child: AnimatedBuilder(
        animation: _rot,
        builder: (_, child) => Transform.rotate(angle: _rot.value, child: child),
        child: Image.asset(TopLayout.handleAsset, width: w, fit: BoxFit.contain),
      ),
    );
  }
}

