import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'item_button_style.dart';
import 'round_button.dart';

class _ButtonItem extends StatelessWidget {
  const _ButtonItem({
    required this.text,
    required this.iconAsset,
    this.onPressed,
  });

  final String text;
  final String iconAsset;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        RoundButton(iconAsset: iconAsset, onPressed: onPressed),
        const SizedBox(height: ItemButtonStyle.spacing),
        Text(text, style: ItemButtonStyle.textStyle),
      ],
    );
  }
}

class ItemButton extends StatelessWidget {
  const ItemButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.only(right: 7.0, bottom: 450),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _ButtonItem(
              text: 'お知らせ',
              iconAsset: ItemButtonStyle.ellipsesIcon,
              onPressed: () => print('お知らせを押したよ！'),
            ),
            const SizedBox(height: 16.0),
            _ButtonItem(
              text: '所持チケ',
              iconAsset: ItemButtonStyle.ellipsesIcon,
              onPressed: () => context.go('/ticket'), 
            ),
          ],
        ),
      ),
    );
  }
}

