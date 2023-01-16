import 'package:flutter/material.dart';

import '../constants/images.dart';

class Button extends StatelessWidget {
  const Button({
    Key? key,
    this.onPressed,
    required this.text,
    this.disable = false,
  }) : super(key: key);

  final GestureTapCallback? onPressed;
  final String text;
  final bool disable;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      onTap: disable ? null : onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 60,
          vertical: 32,
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(disable ? Images.buttonInactive : Images.button),
            fit: BoxFit.contain,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 20, color: disable ? Colors.grey : null),
        ),
      ),
    );
  }
}
