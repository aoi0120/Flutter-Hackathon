import 'package:flutter/material.dart';
import '../../auth.dart';
import 'layout.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  Future<void> _handleLogout(BuildContext context) async {
    try {
      await signOut();
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('ログアウトに失敗しました')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('その他')),
      body: ListView(
        children: <Widget>[
          InkWell(
            onTap: () {},
            child: const ListTile(
              title: Text('ニックネーム変更', style: SettingLayout.textStyle),
            ),
          ),
          InkWell(
            onTap: () => _handleLogout(context),
            child: const ListTile(
              title: Text('ログアウト', style: SettingLayout.logout),
            ),
          ),
        ],
      ),
    );
  }
}
