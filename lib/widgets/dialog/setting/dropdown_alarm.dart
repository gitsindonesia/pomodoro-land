import 'package:flutter/material.dart';

import '../../../constants/images.dart';
import '../../../constants/sounds.dart';

class DropdownAlarm extends StatelessWidget {
  const DropdownAlarm({
    Key? key,
    required this.selected,
    required this.onAlarmSelected,
  }) : super(key: key);

  final String selected;
  final ValueChanged<String?> onAlarmSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('Alarm', style: TextStyle(fontSize: 24)),
        const Spacer(),
        DropdownButton<String>(
          borderRadius: BorderRadius.circular(8),
          icon: Image.asset(Images.dropdown),
          underline: const SizedBox.shrink(),
          value: selected,
          items: [
            ...Sounds.alarms.keys.map(
              (e) => DropdownMenuItem<String>(
                value: Sounds.alarms[e],
                child: Text(e, style: const TextStyle(fontSize: 24)),
              ),
            ),
          ],
          onChanged: onAlarmSelected,
        ),
      ],
    );
  }
}
