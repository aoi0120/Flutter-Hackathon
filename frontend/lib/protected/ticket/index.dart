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
  late TicketsService _service;
  late Future<List<TicketDto>> _future;
  bool _inited = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_inited) return;
    _service = TicketsService(AppScope.of(context).ticketsApi);
    _future = _service.fetchTickets();
    _inited = true;
  }

  Future<void> _refresh() async {
    final newFuture = _service.fetchTickets();
    if (!mounted) return;
    setState(() {
      _future = newFuture;
    });
    await newFuture;
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: TicketLayout.bgColor,
      child: SafeArea(
        child: FutureBuilder<List<TicketDto>>(
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
                      Text(
                        '読み込み失敗: ${snap.error}',
                        textAlign: TextAlign.center,
                        style: TicketLayout.infoTextStyle,
                      ),
                      const SizedBox(height: 12),
                      FilledButton(
                        onPressed: _refresh,
                        child: const Text('再試行'),
                      ),
                    ],
                  ),
                ),
              );
            }
            if (!snap.hasData || snap.data!.isEmpty) {
              return const Center(child: Text('クーポンはありません'));
            }
            final tickets = snap.data!;
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
                  ...tickets.map(
                    (ticket) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: CouponCard(
                        label: ticket.prize,
                        dateText:
                            '${ticket.expirationAt.month}月${ticket.expirationAt.day}日',
                        areaText: '${ticket.storeName}  ',
                        venueText: '',
                        ticketId: '',
                        onTapLocation: () => openMap(
                          lat: ticket.latitude,
                          lng: ticket.longitude,
                          label: ticket.storeName,
                        ),
                        onPressedDetails: () {
                          // チケット詳細（メッセージ無効化）
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   const SnackBar(content: Text('チケット詳細（TODO）')),
                          // );
                        },
                      ),
                    ),
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
