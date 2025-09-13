import 'package:flutter/material.dart';
import 'layout.dart';
import './_component/card.dart';
import 'package:frontend/api/api.dart';
import 'package:frontend/app_scope.dart';
import 'package:frontend/util/maps_launcher.dart';

class TicketPage extends StatefulWidget {
  const TicketPage({super.key});
  @override
  State<TicketPage> createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  late final TicketsService _service;
  late Future<TicketDto> _future;

  Future<TicketDto> _load() => _service.fetchNextTicket();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _service = TicketsService(AppScope.of(context).ticketsApi);
    _future = _load();
  }

  Future<void> _refresh() async {
    setState(() => _future = _load());
    await _future;
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: TicketLayout.bgColor,
      child: SafeArea(
        child: FutureBuilder<TicketDto>(
          future: _future,
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snap.hasError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('読み込み失敗: ${snap.error}',
                          textAlign: TextAlign.center,
                          style: TicketLayout.infoTextStyle),
                      const SizedBox(height: 12),
                      FilledButton(onPressed: _refresh, child: const Text('再試行')),
                    ],
                  ),
                ),
              );
            }
            if (!snap.hasData) {
              return const Center(child: Text('クーポンはありません'));
            }
            final t = snap.data!;
            return RefreshIndicator(
              onRefresh: _refresh,
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('持ってるクーポン', style: TicketLayout.headerTextStyle),
                      const SizedBox(height: 6),
                      Container(height: 2, color: Colors.black87),
                    ],
                  ),
                  const SizedBox(height: 16),
                  CouponCard(
                    label: t.prize,
                    dateText: t.expirationAt,
                    areaText: '${t.storeName}  ',
                    venueText: '',
                    onTapLocation: () => openMap(
                      lat: t.latitude,
                      lng: t.longitude,
                      label: t.storeName,
                    ),
                    onPressedDetails: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('チケット詳細（TODO）')),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

