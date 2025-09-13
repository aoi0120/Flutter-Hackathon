import 'package:flutter/material.dart';
import 'owner_login_style.dart';

class ButtonTemp extends StatelessWidget {
  const ButtonTemp({super.key, required this.text, required this.onTap});

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: OwnerButtonStyle.buttonWidth,
        height: OwnerButtonStyle.buttonHeight,
        alignment: Alignment.center,
        decoration: OwnerTextStyle.getLoginBox(),
        child: Text(
          text,
          style: OwnerTextStyle.style.merge(
            OwnerTextStyle.getTextType(type: TextType.login),
          ),
        ),
      ),
    );
  }
}
