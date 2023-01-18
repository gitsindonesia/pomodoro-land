import 'package:flutter/material.dart';

class InkWellPressed extends StatelessWidget {
  const InkWellPressed({
    Key? key,
    required this.onPressed,
    required this.child,
  }) : super(key: key);

  final GestureTapCallback? onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onPressed,
      child: child,
    );
  }
}
