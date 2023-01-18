import 'package:flutter/material.dart';

import '../constants/images.dart';
import '../model/clockify/project_clockify.dart';

class DropdownProjectClockify extends StatelessWidget {
  const DropdownProjectClockify({
    Key? key,
    required this.selectedProject,
    required this.onProjectSelected,
    required this.items,
  }) : super(key: key);

  final ProjectClockify? selectedProject;
  final ValueChanged<ProjectClockify?> onProjectSelected;
  final List<ProjectClockify> items;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(Images.clockify, width: 34),
        const SizedBox(width: 24),
        Expanded(
          child: DropdownButton<ProjectClockify>(
            isExpanded: true,
            borderRadius: BorderRadius.circular(8),
            icon: Image.asset(Images.dropdown),
            underline: const SizedBox.shrink(),
            value: selectedProject,
            items: [
              const DropdownMenuItem<ProjectClockify>(
                value: null,
                child: Text(
                  'Not a Project',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              ...items.map(
                (e) => DropdownMenuItem<ProjectClockify>(
                  value: e,
                  child: Text(
                    e.name,
                    style: TextStyle(fontSize: 20, color: e.color),
                  ),
                ),
              ),
            ],
            onChanged: onProjectSelected,
          ),
        ),
        const SizedBox(width: 24),
      ],
    );
  }
}
