import 'package:flutter/material.dart';
import 'general_login_style.dart';
import '../auth.dart';

class GeneralLogin extends StatelessWidget {
  const GeneralLogin({
    super.key,
    // required this.text,
    // this.onPressed,
  });

  // final String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // 上部コンテナー
          Expanded(
            flex: 1,
            child: Container(
              child: const Center(child: GeneralScreenPicture()),
            ),
          ),
          // 下部コンテナー
          Expanded(
            flex: 1,
            child: Container(
              child: Column(
                children: [
                  // Google認証ボタン
                  InkWell(
                    onTap: () => {print('Google認証ボタンを押したよ'), auth.value = true},
                    child: Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Image.asset('assets/images/glogin.png'),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  // 商店街の方専用ログイン画面
                  InkWell(
                    onTap: () => print('商店街の方専用ログイン画面へ'),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        '商店街の方はこちら',
                        style: GeneralScreenPicture.textStyle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
