import 'package:flutter/material.dart';

class ItemButton extends StatelessWidget {
  const ItemButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(children: [Text('お知らせ'), Text('所持チケ')]);
  }
}
