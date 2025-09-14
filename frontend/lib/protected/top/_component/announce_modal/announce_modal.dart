import 'package:flutter/material.dart';
import '../../../../api/service/announce_service.dart';
import '../../../../app_scope.dart';

class AnnounceModal extends StatefulWidget {
  const AnnounceModal({super.key});

  @override
  State<AnnounceModal> createState() => _AnnounceModalState();
}

class _AnnounceModalState extends State<AnnounceModal> {
  late Future<List<Map<String, dynamic>>> _announcesFuture;
  late AnnounceService _announceService;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _announceService = AnnounceService(AppScope.of(context).api);
    _announcesFuture = _announceService.fetchAnnounces();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.7,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'お知らせ',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 16),
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: _announcesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.error, size: 48, color: Colors.red),
                          const SizedBox(height: 16),
                          Text('エラーが発生しました: ${snapshot.error}'),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _announcesFuture = _announceService
                                    .fetchAnnounces();
                              });
                            },
                            child: const Text('再試行'),
                          ),
                        ],
                      ),
                    );
                  }

                  final announces = snapshot.data ?? [];

                  if (announces.isEmpty) {
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.info, size: 48, color: Colors.grey),
                          SizedBox(height: 16),
                          Text('お知らせはありません'),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: announces.length,
                    itemBuilder: (context, index) {
                      final announce = announces[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                announce['title'] ?? 'タイトルなし',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                announce['summary']?.toString() ?? '内容なし',
                                style: const TextStyle(fontSize: 14),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '日時: ${_formatDate(announce['event_at'])}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(dynamic date) {
    if (date == null) return '日時不明';

    try {
      if (date is String) {
        final parsed = DateTime.parse(date);
        return '${parsed.year}/${parsed.month}/${parsed.day}';
      } else if (date is Map && date['_seconds'] != null) {
        final timestamp = DateTime.fromMillisecondsSinceEpoch(
          (date['_seconds'] as int) * 1000,
        );
        return '${timestamp.year}/${timestamp.month}/${timestamp.day}';
      }
    } catch (e) {
      print('日付フォーマットエラー: $e');
    }

    return '日時不明';
  }
}
