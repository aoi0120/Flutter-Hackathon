
import 'package:flutter/material.dart';

class CardStyle {

  static const EdgeInsets margin = EdgeInsets.symmetric(horizontal: 8);
  static const BorderRadius borderRadius = BorderRadius.all(Radius.circular(14));
  static const EdgeInsets innerPadding = EdgeInsets.fromLTRB(16, 16, 16, 14);

  static const BoxShadow boxShadow = BoxShadow(
    color: Color(0x14000000),
    blurRadius: 18,
    offset: Offset(0, 8),
  );

  static final BoxDecoration containerDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: borderRadius,
    boxShadow: const [boxShadow],
  );

  static const EdgeInsets labelPadding = EdgeInsets.symmetric(horizontal: 2, vertical: 2);
  static const TextStyle labelTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w800,
    color: Colors.black,
  );

  static const double iconSize = 18;
  static const Color iconColor = Colors.black87;
  static const double spacingAfterLabel = 14;
  static const double spacingBetweenInfo = 10;
  static const double buttonHeight = 44;
  static final RoundedRectangleBorder buttonShape =
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(10));
  static BorderSide buttonBorderSide(BuildContext _) =>
      BorderSide(color: Colors.black.withOpacity(0.35), width: 1.2);
}
