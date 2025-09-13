import 'package:flutter/material.dart';
import 'general_login_style.dart';
import '../auth.dart';

class GeneralLogin extends StatelessWidget {
  const GeneralLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 上部コンテナー
            Expanded(
              flex: 1,
              child: Stack(
                children: [
                  Center(
                    child: Image.asset(
                      'assets/images/ishibashi.png',
                      width: 300,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Positioned(
                    top: -10,
                    right: -5,
                    child: Image.asset(
                      'assets/images/gatya.png',
                      width: 200,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),

            // 下部コンテナー（
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                 InkWell(
                      onTap: () {
                        print('Google認証ボタンを押したよ');
                        auth.value = true;
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Image(
                          image: AssetImage('assets/images/glogin.png'),
                          width: 300,
                          // height: 60,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  const SizedBox(height: 20.0),
                  InkWell(
                    onTap: () => print('商店街の方専用ログイン画面へ'),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        '商店街の方はこちら',
                        style: GeneralLoginStyle.linkText,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

