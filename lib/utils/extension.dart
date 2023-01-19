import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension NumExtension on num {
  String toStringWithDigit([int digit = 2]) => toString().padLeft(digit, '0');
}

extension DurationExtension on Duration {
  String toMMss() =>
      '${(inSeconds ~/ 60).toStringWithDigit()}:${(inSeconds % 60).toStringWithDigit()}';
}

extension DateTimeExtension on DateTime {
  String toMap() => DateFormat('yyyy-MM-dd').format(this);
  String toFormatDate() => DateFormat('dd MMMM yyyy').format(this);
  String toFormatTime() => DateFormat('HH:mm').format(this);
}

extension SnackBarExtension on BuildContext {
  void showSnackBar(SnackBar snackBar) {
    ScaffoldMessenger.maybeOf(this)?.removeCurrentSnackBar();
    ScaffoldMessenger.maybeOf(this)?.showSnackBar(snackBar);
  }
}

extension StringExtension on String {
  Color toColor() {
    final buffer = StringBuffer();
    if (length == 6 || length == 7) buffer.write('ff');
    buffer.write(replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

extension ColorExtension on Color {
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
