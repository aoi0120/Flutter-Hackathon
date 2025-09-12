import 'package:flutter/material.dart';
import 'item_button_style.dart';

class RoundButton extends StatelessWidget {
  const RoundButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ItemButtonStyle.buttonSize,
      height: ItemButtonStyle.buttonSize,
      child: Material(
        color: ItemButtonStyle.buttonColor,
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        child: InkWell(onTap: onPressed),
      ),
    );
  }
}
