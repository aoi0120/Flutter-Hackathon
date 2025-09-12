import 'package:flutter/material.dart';

import 'layout.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: SettingLayout.bgColor,
      child: const Text('設定', style: SettingLayout.titleStyle),
    );
  }
}
