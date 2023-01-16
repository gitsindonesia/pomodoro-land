import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pomodoro_land/constants/images.dart';
import 'package:pomodoro_land/cubit/main/main_cubit.dart';
import 'package:pomodoro_land/utils/extension.dart';
import 'package:pomodoro_land/widgets/countdown_section.dart';
import 'package:pomodoro_land/widgets/todo_section.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.endOfFrame.then((value) async {
      if (mounted) {
        context.read<MainCubit>().initAfterLayout(context);
      }
    });
    context.read<MainCubit>().initState(context);
  }

  @override
  Widget build(BuildContext context) {
    final isStart = context.select((MainCubit bloc) => bloc.state.isStart);
    final duration = context.select((MainCubit bloc) => bloc.state.duration);

    return MaterialApp(
      title: '${isStart ? '${duration.toMMss()} - ' : ''}Pomodoro Land',
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.black,
        textTheme: GoogleFonts.mansalvaTextTheme(),
      ),
      home: Builder(builder: (context) {
        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const SizedBox(width: 32),
                  const Text('Pomodoro Land', style: TextStyle(fontSize: 40)),
                  const Spacer(),
                  InkWell(
                    hoverColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () =>
                        context.read<MainCubit>().onSettingPressed(context),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Image.asset(Images.setting, width: 60),
                    ),
                  ),
                  const SizedBox(width: 32),
                ],
              ),
              Image.asset(
                Images.lineLong,
                width: double.infinity,
                fit: BoxFit.fitWidth,
              ),
              Expanded(
                child: Row(
                  children: const [
                    Spacer(),
                    CountdownSection(),
                    Spacer(),
                    Expanded(flex: 7, child: TodoSection()),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
