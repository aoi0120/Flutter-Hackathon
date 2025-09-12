import 'package:flutter/material.dart';

// ishibashi.pngとgatya.pngを組み合わせたもの
class GeneralScreenPicture extends StatelessWidget {
  const GeneralScreenPicture({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Image.asset('assets/images/ishibashi.png'),
        Positioned(
          top: 0,
          right: 0,
          child: Image.asset('assets/images/gatya.png'),
        ),
      ],
    );
  }

  static const TextStyle textStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.grey,
  );
}
