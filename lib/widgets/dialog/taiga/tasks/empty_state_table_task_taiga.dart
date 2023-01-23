import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cubit/taiga/taiga_cubit.dart';
import '../../../empty_state.dart';

class EmptyStateTableTaskTaiga extends StatelessWidget {
  const EmptyStateTableTaskTaiga({super.key});

  @override
  Widget build(BuildContext context) {
    final filterProgress =
        context.select((TaigaCubit bloc) => bloc.state.filterProgress);
    final filterAssign =
        context.select((TaigaCubit bloc) => bloc.state.filterAssign);

    String message = 'Tasks is empty';
    if (filterProgress != null || filterAssign != null) {
      message += ' for ';
    }
    if (filterProgress != null) {
      message += filterProgress.name ?? '';
    }
    if (filterProgress != null && filterAssign != null) {
      message += ' and ';
    }
    if (filterAssign != null) {
      message += filterAssign.fullName ?? '';
    }

    return EmptyState(text: message);
  }
}
