import 'package:flutter/material.dart';

import '../constants/images.dart';

class ItemTab extends StatelessWidget {
  const ItemTab({
    Key? key,
    required this.text,
    required this.selected,
    required this.onPressed,
    required this.fontSize,
  }) : super(key: key);

  final String text;
  final bool selected;
  final GestureTapCallback onPressed;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(selected ? Images.button : Images.buttonInactive),
            fit: BoxFit.contain,
          ),
        ),
        child: Text(text,
            style: TextStyle(
                fontSize: fontSize, color: selected ? null : Colors.grey)),
      ),
    );
  }
}
