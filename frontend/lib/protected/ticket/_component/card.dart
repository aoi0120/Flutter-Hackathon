import 'package:flutter/material.dart';
import '../layout.dart';
import 'card_styles.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CouponCard extends StatelessWidget {
  const CouponCard({
    super.key,
    required this.label,
    required this.dateText,
    required this.areaText,
    required this.venueText,
    required this.ticketId,
    this.onTapLocation,
    this.onPressedDetails,
  });

  final String label;
  final String dateText;
  final String areaText;
  final String venueText;
  final String ticketId;
  final VoidCallback? onTapLocation;
  final VoidCallback? onPressedDetails;

  String _formatDateText(String dateText) {
    try {
      final regex = RegExp(r'(\d+)月(\d+)日');
      final match = regex.firstMatch(dateText);
      if (match != null) {
        final month = int.parse(match.group(1)!);
        final day = int.parse(match.group(2)!);
        final now = DateTime.now();
        final year = now.year;
        final date = DateTime(year, month, day);
        return DateFormat('yyyy/MM/dd').format(date);
      }
    } catch (e) {
      print('日付フォーマットエラー: $e');
    }
    return dateText;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: CardStyle.margin,
      decoration: CardStyle.containerDecoration,
      child: Padding(
        padding: CardStyle.innerPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: CardStyle.labelPadding,
              child: Text(label, style: CardStyle.labelTextStyle),
            ),
            const SizedBox(height: CardStyle.spacingAfterLabel),

            Row(
              children: [
                const Icon(
                  Icons.calendar_today_outlined,
                  size: CardStyle.iconSize,
                  color: CardStyle.iconColor,
                ),
                const SizedBox(width: 8),
                Text(
                  _formatDateText(dateText),
                  style: TicketLayout.infoTextStyle,
                ),
              ],
            ),
            const SizedBox(height: CardStyle.spacingBetweenInfo),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.place_outlined,
                  size: CardStyle.iconSize,
                  color: CardStyle.iconColor,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: InkWell(
                    onTap: onTapLocation,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: areaText),
                          TextSpan(text: venueText),
                        ],
                      ),
                      style: TicketLayout.linkTextStyle,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: CardStyle.buttonHeight,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: CardStyle.buttonBorderSide(context),
                  shape: CardStyle.buttonShape,
                ),
                onPressed: () async {
                  try {
                    // JWT 取り出し
                    final prefs = await SharedPreferences.getInstance();
                    final token = prefs.getString('jwt');

                    if (token == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('ログイン情報がありません')),
                      );
                      return;
                    }

                    // API 叩く (PATCH /tickets/:ticketId)
                    
                    final url = Uri.parse('https://your-api.com/tickets/$ticketId');

                    final response = await http.patch(
                      url,
                      headers: {
                        'Content-Type': 'application/json',
                        'Authorization': 'Bearer $token',
                      },
                    );

                    if (response.statusCode == 200) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('チケットを使用しました')),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('使用失敗: ${response.statusCode}')),
                      );
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('エラーが発生しました')),
                    );
                  }
                },
                child: const Text(
                  'チケットを使う',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                    letterSpacing: .2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
