import '../client.dart';

class AnnounceService {
  AnnounceService(this.api);
  final ApiClient api;

  Future<List<Map<String, dynamic>>> fetchAnnounces() async {
    print('お知らせ取得開始');
    final json = await api.getJson('/api/announce');
    print('お知らせAPIレスポンス: $json');

    final data = json['result'];
    if (data is List) {
      return List<Map<String, dynamic>>.from(data);
    }

    return [];
  }
}
