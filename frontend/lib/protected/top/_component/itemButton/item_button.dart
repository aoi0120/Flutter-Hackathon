import 'package:flutter/material.dart';
import 'item_button_style.dart';
import 'round_button.dart';

// ボタンとテキストを組み合わせる
class _ButtonItem extends StatelessWidget {
  const _ButtonItem({required this.text, this.onPressed});

  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        RoundButton(onPressed: onPressed),
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _ButtonItem(text: 'お知らせ', onPressed: () => print('お知らせを押したよ！')),
            const SizedBox(height: 16.0),
            _ButtonItem(text: '所持チケ', onPressed: () => print('所持チケを押したよ！')),
          ],
        ),
      ),
    );
  }
}
