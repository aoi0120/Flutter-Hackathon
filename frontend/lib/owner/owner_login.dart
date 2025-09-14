import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'button_temp.dart';
import 'owner_login_style.dart';

class OwnerLogin extends StatefulWidget {
  const OwnerLogin({super.key});

  @override
  State<OwnerLogin> createState() => _OwnerLoginState();
}

class _OwnerLoginState extends State<OwnerLogin> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  Future<void> login() async {
    final email = emailController.text;
    final pass = passController.text;

    if (email.isEmpty || pass.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('メールアドレスとパスワードを入力してください')),
      );
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('https://flutter-hackathon-production.up.railway.app/api/store/'), 
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'pass': pass}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['token'];
        print('ログイン成功: ${data['token']}');
        // ここでトークンを保存したり、画面遷移したりする
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('jwt', token);
      } else {
        final data = jsonDecode(response.body);
        print('ログイン失敗: ${data['message']}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message'] ?? 'ログイン失敗')),
        );
      }
    } catch (e) {
      print('エラー: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('通信エラーが発生しました')),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                onTap: () {
                  context.go('/login');
                  print('一般ログインに戻るよ');
                },
                child: Text('＜戻る', style: OwnerTextStyle.style),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text('商店街の方', style: OwnerTextStyle.style),
            ),
          ],
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 説明文
              Text(
                'ログインIDとパスワードを入力してください',
                style: OwnerTextStyle.style.merge(
                  OwnerTextStyle.getTextType(type: TextType.text),
                ),
              ),
              const SizedBox(height: 30),

              // ログインID
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'メールアドレス',
                  labelStyle: OwnerTextStyle.style.merge(
                    OwnerTextStyle.getTextType(type: TextType.area),
                  ),
                  border: OutlineInputBorder(),
                ),
              ),

              // パスワード
              TextField(
                controller: passController, 
                obscureText: true, // パスワード非表示
                decoration: InputDecoration(
                  labelText: 'パスワード',
                  labelStyle: OwnerTextStyle.style.merge(
                    OwnerTextStyle.getTextType(type: TextType.area),
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 40),

              // ログインボタン
              ButtonTemp(
                text: 'ログイン',
                onTap: login,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
