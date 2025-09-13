import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'config/env.dart';

/// Googleサインイン用
final GoogleSignIn _googleSignIn = GoogleSignIn();
final FirebaseAuth _auth = FirebaseAuth.instance;

/// アプリ全体で使える「認証状態の監視用フラグ」
final ValueNotifier<bool> auth = ValueNotifier<bool>(_auth.currentUser != null);

/// Firebase 初期化 & 認証状態の監視
Future<void> initAuth() async {
  await Firebase.initializeApp();
  _auth.authStateChanges().listen((user) {
    auth.value = user != null;
  });
}

/// Firebase IDトークンをバックエンドに送信して独自JWT取得
Future<bool> sendIdTokenToBackend() async {
  try {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return false;

    final idToken = await user.getIdToken();

    final response = await http.post(
      Uri.parse('${Env.apiBaseUrl}/user/jwtToken'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'token': idToken}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final jwt = data['UserToken'];

      // 端末に保存して後でAPIリクエストに利用
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwt', jwt);

      print('バックエンドJWT取得成功: $jwt');
      return true;
    } else {
      print('バックエンド認証失敗: ${response.body}');
      return false;
    }
  } catch (e) {
    print('JWT送信中にエラー: $e');
    return false;
  }
}

/// Googleサインイン実行
Future<bool> signInWithGoogle() async {
  try {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) return false;

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await _auth.signInWithCredential(credential);
    auth.value = true;

    final jwtResult = await sendIdTokenToBackend();
    return jwtResult;
  } catch (e) {
    print('Googleサインインでエラー: $e');
    return false;
  }
}

/// サインアウト処理
Future<void> signOut() async {
  await _auth.signOut();
  await _googleSignIn.signOut();

  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('jwt'); // ← ローカルのJWTも削除しておくと安全
  auth.value = false;
}
