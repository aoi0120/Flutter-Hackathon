import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Gacha extends StatefulWidget {
  const Gacha({
    super.key,
    this.onCompleted,
    this.boxSize,
    this.assetPath = 'assets/data/data.json',
    this.repeat = false,
  });

  final VoidCallback? onCompleted;
  final double? boxSize;
  final String assetPath;
  final bool repeat;

  @override
  State<Gacha> createState() => _GachaState();
}

class _GachaState extends State<Gacha> with SingleTickerProviderStateMixin {
  late final AnimationController _c;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(vsync: this)
      ..addStatusListener((s) {
        if (s == AnimationStatus.completed && !widget.repeat) {
          widget.onCompleted?.call();
        }
      });
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lottie = Lottie.asset(
      widget.assetPath,
      controller: _c,
      onLoaded: (comp) {
        if (!mounted) return;
        if (comp.duration == null || comp.duration.inMilliseconds == 0) {
          debugPrint('Lottie composition duration is null/zero: ${widget.assetPath}');
          return;
        }
        _c
          ..duration = comp.duration
          ..forward();
      },
      repeat: widget.repeat,
      fit: BoxFit.contain,
      errorBuilder: (context, err, stack) {
        return Container(
          alignment: Alignment.center,
          color: Colors.black12,
          child: Text(
            'Lottie 読み込み失敗\n${widget.assetPath}\n$err',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white),
          ),
        );
      },
    );

    if (widget.boxSize == null) return lottie;
    return SizedBox(width: widget.boxSize, height: widget.boxSize, child: lottie);
  }
}

