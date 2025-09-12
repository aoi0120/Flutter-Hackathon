import 'package:flutter/material.dart';
import 'other_style.dart';

class OtherPage extends StatelessWidget {
  const OtherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('その他')),
      body: (ListView(
        children: const <Widget>[
          InkWell(
            onTap: null,
            child: ListTile(
              title: Text('ニックネーム変更', style: OtherTextStyle.textStyle),
            ),
          ),
          InkWell(
            onTap: null,
            child: ListTile(title: Text('ログアウト', style: OtherTextStyle.logout)),
          ),
        ],
      )),
    );
  }
}
