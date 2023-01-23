import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:pomodoro_land/model/taiga/response/project_detail_taiga_response.dart';
import 'package:pomodoro_land/utils/extension.dart';

import '../constants/images.dart';

class DropdownTaskTaigaStatus extends StatelessWidget {
  const DropdownTaskTaigaStatus({
    Key? key,
    required this.selectedTaigaStatusId,
    required this.onTaigaStatus,
    required this.items,
    this.fontSize = 20,
  }) : super(key: key);

  final int? selectedTaigaStatusId;
  final ValueChanged<TaskStatusesProjectDetailTaiga?> onTaigaStatus;
  final List<TaskStatusesProjectDetailTaiga> items;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(Images.taiga, width: 34),
        const SizedBox(width: 24),
        Expanded(
          child: DropdownButton<int>(
            isExpanded: true,
            borderRadius: BorderRadius.circular(8),
            icon: Image.asset(Images.dropdown),
            underline: const SizedBox.shrink(),
            value: selectedTaigaStatusId,
            items: [
              ...items.map(
                (e) => DropdownMenuItem<int>(
                  value: e.id,
                  child: Text(
                    e.name ?? '',
                    style: TextStyle(
                        fontSize: fontSize, color: e.color?.toColor()),
                  ),
                ),
              ),
            ],
            onChanged: (value) => onTaigaStatus
                .call(items.firstWhereOrNull((element) => element.id == value)),
          ),
        ),
        const SizedBox(width: 24),
      ],
    );
  }
}
