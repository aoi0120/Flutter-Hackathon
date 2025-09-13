import 'package:flutter/material.dart';
import 'button_temp.dart';
import 'owner_login_style.dart';

class OwnerLogin extends StatelessWidget {
  const OwnerLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                onTap: () => print('一般ログインに戻るよ'),
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
              ButtonTemp(text: 'ログイン', onTap: () => print('ログインするよ！')),
            ],
          ),
        ),
      ),
    );
  }
}
