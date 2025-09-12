import 'package:flutter/material.dart';

class ItemButtonStyle {
  // テキストスタイル
  static const TextStyle textStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  // ボタンスタイル
  static const double buttonSize = 60.0; // 直径
  static const double iconSize = 30.0; // アイコンのサイズ
  static const double spacing = 8.0; // ボタンとテキストの間隔
  static const Color buttonColor = Colors.grey; // ボタンカラー

  // アイコン画像(３点リーダー)
  static const String ellipsesIcon = 'assets/images/ellipses.png';
}
