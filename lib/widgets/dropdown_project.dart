import 'package:flutter/material.dart';

import '../constants/images.dart';
import '../model/project.dart';

class DropdownProject extends StatelessWidget {
  const DropdownProject({
    Key? key,
    required this.selectedProject,
    required this.onProjectSelected,
    required this.items,
  }) : super(key: key);

  final Project? selectedProject;
  final ValueChanged<Project?> onProjectSelected;
  final List<Project> items;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(Images.project, width: 34),
        const SizedBox(width: 24),
        Expanded(
          child: DropdownButton<Project>(
            isExpanded: true,
            borderRadius: BorderRadius.circular(8),
            icon: Image.asset(Images.dropdown),
            underline: const SizedBox.shrink(),
            value: selectedProject,
            items: [
              const DropdownMenuItem<Project>(
                value: null,
                child: Text(
                  'Not a Project',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              ...items.map(
                (e) => DropdownMenuItem<Project>(
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
