import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:pomodoro_land/model/taiga/response/project_detail_taiga_response.dart';
import 'package:pomodoro_land/utils/extension.dart';

class DropdownTaigaStatus extends StatefulWidget {
  const DropdownTaigaStatus({
    Key? key,
    required this.initialSelectedTaigaStatusId,
    required this.onTaigaStatus,
    required this.items,
  }) : super(key: key);

  final int? initialSelectedTaigaStatusId;
  final ValueChanged<TaskStatusesProjectDetailTaiga?> onTaigaStatus;
  final List<TaskStatusesProjectDetailTaiga> items;

  @override
  State<DropdownTaigaStatus> createState() => _DropdownTaigaStatusState();
}

class _DropdownTaigaStatusState extends State<DropdownTaigaStatus> {
  int? selectedTaigaStatusId;

  @override
  void initState() {
    super.initState();
    selectedTaigaStatusId = widget.initialSelectedTaigaStatusId;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
      isExpanded: true,
      borderRadius: BorderRadius.circular(8),
      underline: const SizedBox.shrink(),
      value: selectedTaigaStatusId,
      items: [
        ...widget.items.map(
          (e) => DropdownMenuItem<int>(
            value: e.id,
            child: Text(
              e.name ?? '',
              style: TextStyle(fontSize: 14, color: e.color?.toColor()),
            ),
          ),
        ),
      ],
      onChanged: (value) {
        setState(() {
          selectedTaigaStatusId = value;
        });
        widget.onTaigaStatus.call(
            widget.items.firstWhereOrNull((element) => element.id == value));
      },
    );
  }
}
