import '../client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GachaService {
  GachaService(this.api);
  final ApiClient api;

  Future<Map<String, dynamic>> playGacha() async {
    final prefs = await SharedPreferences.getInstance();
    final jwt = prefs.getString('jwt');

    print('ガチャ実行 - JWT取得状況: ${jwt != null ? "あり" : "なし"}');

    final headers = <String, String>{};
    if (jwt != null) {
      headers['Authorization'] = 'Bearer $jwt';
    }

    print('ガチャAPI送信ヘッダー: $headers');
    final json = await api.postJson('', headers: headers);
    return json;
  }
}
