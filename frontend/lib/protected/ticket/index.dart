import 'package:flutter/material.dart';
import 'layout.dart';
import './_component/card.dart';

class TicketPage extends StatelessWidget {
  const TicketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: TicketLayout.bgColor,
      child: SafeArea(
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
              label: '500円引き',
              dateText: '2025/6/12(木) 19:00',
              areaText: 'ミナミアメリカ村  ',
              venueText: 'BIGCAT(大阪府)',
              onTapLocation: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('会場リンク（TODO）')),
                );
              },
              onPressedDetails: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('チケット詳細（TODO）')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

