import 'package:flutter/material.dart';
import 'package:pomodoro_land/widgets/dialog/taiga/filter_issue_sidebar.dart';

class IssuesTableTaiga extends StatelessWidget {
  const IssuesTableTaiga({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FilterIssueSidebar(),
        const VerticalDivider(width: 1),
        Expanded(child: Container()),
      ],
    );
  }
}
