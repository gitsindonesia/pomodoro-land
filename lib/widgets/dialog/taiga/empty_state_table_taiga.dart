import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/taiga/taiga_cubit.dart';
import '../../empty_state.dart';

class EmptyStateTableTaiga extends StatelessWidget {
  const EmptyStateTableTaiga({super.key});

  @override
  Widget build(BuildContext context) {
    final filterProgress =
        context.select((TaigaCubit bloc) => bloc.state.filterProgress);
    final filterAssign =
        context.select((TaigaCubit bloc) => bloc.state.filterAssign);

    return Expanded(
      child: EmptyState(
        text:
            'Task is empty for ${filterProgress?.name ?? ''}${filterProgress != null ? ' and ' : ''}${filterAssign?.fullName ?? ''}',
      ),
    );
  }
}
