import 'package:flutter/material.dart';

import '../../../empty_state.dart';

class EmptyStateTableIssueTaiga extends StatelessWidget {
  const EmptyStateTableIssueTaiga({super.key});

  @override
  Widget build(BuildContext context) {
    return const EmptyState(text: 'Issues is empty');
  }
}
