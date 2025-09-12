import 'package:flutter/material.dart';
import 'general_login_style.dart';

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
                  // ボタン化はまだ
                  Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Image.asset('assets/images/glogin.png'),
                  ),
                  SizedBox(height: 20.0),
                  // ボタン化はまだ
                  Text('商店街の方はこちら'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
