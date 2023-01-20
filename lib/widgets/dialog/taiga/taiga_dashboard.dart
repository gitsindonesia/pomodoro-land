import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro_land/cubit/taiga/taiga_cubit.dart';
import 'package:pomodoro_land/widgets/dialog/taiga/content_section.dart';
import 'package:pomodoro_land/widgets/dialog/taiga/sidebar_section.dart';

import '../../../constants/images.dart';
import '../../dropdown_project_clockify.dart';
import '../../ink_well_pressed.dart';

class TaigaDashboard extends StatefulWidget {
  const TaigaDashboard({super.key});

  @override
  State<TaigaDashboard> createState() => _TaigaDashboardState();
}

class _TaigaDashboardState extends State<TaigaDashboard> {
  final cubit = TaigaCubit();

  @override
  void initState() {
    super.initState();
    cubit.initState(context);
    WidgetsBinding.instance.endOfFrame.then((value) {
      if (mounted) {
        cubit.initAfterLayout(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: ScaffoldMessenger(
        child: Builder(
          builder: (context) {
            final loadingGlobal =
                context.select((TaigaCubit bloc) => bloc.state.loadingGlobal);
            final projectsClockify = context
                .select((TaigaCubit bloc) => bloc.state.projectsClockify);
            final selectedProjectClockify = context.select(
                (TaigaCubit bloc) => bloc.state.selectedProjectClockify);

            return Scaffold(
              backgroundColor: Colors.transparent,
              body: Dialog(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Text('Taiga Dashboard',
                                  style: TextStyle(fontSize: 40)),
                              const Spacer(),
                              InkWellPressed(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Image.asset(Images.close, width: 60),
                              ),
                            ],
                          ),
                          if (projectsClockify.isNotEmpty) ...[
                            const SizedBox(height: 16),
                            DropdownProjectClockify(
                              items: projectsClockify,
                              selectedProject: selectedProjectClockify,
                              onProjectSelected: context
                                  .read<TaigaCubit>()
                                  .onProjectClockifySelected,
                            ),
                          ],
                        ],
                      ),
                    ),
                    const Divider(height: 32),
                    loadingGlobal
                        ? const Expanded(
                            child: Center(
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.black),
                              ),
                            ),
                          )
                        : Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                SizedBox(
                                  width: 250,
                                  child: SidebarSection(),
                                ),
                                VerticalDivider(width: 1, thickness: 1),
                                Expanded(child: ContentSection()),
                              ],
                            ),
                          ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
