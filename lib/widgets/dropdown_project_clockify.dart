import 'package:flutter/material.dart';

import '../constants/images.dart';
import '../model/clockify/project_clockify.dart';

class DropdownProjectClockify extends StatelessWidget {
  const DropdownProjectClockify({
    Key? key,
    required this.selectedProject,
    required this.onProjectSelected,
    required this.items,
    this.fontSize = 20,
  }) : super(key: key);

  final ProjectClockify? selectedProject;
  final ValueChanged<ProjectClockify?> onProjectSelected;
  final List<ProjectClockify> items;
  final double fontSize;

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
              DropdownMenuItem<ProjectClockify>(
                value: null,
                child: Text(
                  'Not a Project',
                  style: TextStyle(fontSize: fontSize),
                ),
              ),
              ...items.map(
                (e) => DropdownMenuItem<ProjectClockify>(
                  value: e,
                  child: Text(
                    e.name,
                    style: TextStyle(fontSize: fontSize, color: e.color),
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
