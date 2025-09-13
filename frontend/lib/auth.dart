import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn();
final FirebaseAuth _auth = FirebaseAuth.instance;

// Google認証を実行し、成功/失敗を真偽値で返す関数
Future<bool> signInWithGoogle() async {
  try {
    // Googleサインインのフローを開始
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    // ユーザーがサインインをキャンセルした場合、falseを返す
    if (googleUser == null) {
      return false;
    }

    // Googleユーザーの認証情報を取得
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Firebaseに認証情報を渡してサインイン
    await _auth.signInWithCredential(credential);

    // 認証が成功したらtrueを返す
    return true;
  } catch (e) {
    // 認証中にエラーが発生したらfalseを返す
    print('Googleサインインでエラーが発生しました: $e');
    return false;
  }
}

// ユーザーのサインアウト関数（必要に応じて）
Future<void> signOut() async {
  await _auth.signOut();
  await _googleSignIn.signOut();
}