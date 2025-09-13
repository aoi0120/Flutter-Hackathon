import 'package:flutter/material.dart';

enum TextType { text, area, login }

class OwnerTextStyle {
  // 共通のテキストスタイル
  static const TextStyle style = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  // テキストカラー
  static TextStyle getTextType({required TextType type}) {
    switch (type) {
      case TextType.text:
        return TextStyle(color: Colors.black);
      case TextType.area:
        return TextStyle(color: Colors.grey);
      case TextType.login:
        return TextStyle(color: Colors.white);
    }
  }

  // ログインボタンのスタイル
  static BoxDecoration getLoginBox() {
    return BoxDecoration(
      color: Colors.red,
      borderRadius: BorderRadius.circular(8.0),
    );
  }
}

// ログインボタンの形状
class OwnerButtonStyle {
  static const double buttonWidth = 200.0;
  static const double buttonHeight = 50.0;
  static const double buttonShape = 20.0;
}
