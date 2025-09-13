import 'package:flutter/material.dart';
import '../layout.dart';
import 'card_styles.dart';

class CouponCard extends StatelessWidget {
  const CouponCard({
    super.key,
    required this.label,
    required this.dateText,
    required this.areaText,
    required this.venueText,
    this.onTapLocation,
    this.onPressedDetails,
  });

  final String label;
  final String dateText;
  final String areaText;
  final String venueText;
  final VoidCallback? onTapLocation;
  final VoidCallback? onPressedDetails;

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
                const Icon(Icons.calendar_today_outlined,
                    size: CardStyle.iconSize, color: CardStyle.iconColor),
                const SizedBox(width: 8),
                Text(dateText, style: TicketLayout.infoTextStyle),
              ],
            ),
            const SizedBox(height: CardStyle.spacingBetweenInfo),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.place_outlined,
                    size: CardStyle.iconSize, color: CardStyle.iconColor),
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
                onPressed: onPressedDetails,
                child: const Text(
                  'チケット詳細を見る',
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

