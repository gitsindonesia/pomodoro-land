import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pomodoro_land/cubit/main/main_cubit.dart';
import 'package:pomodoro_land/pages/main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) usePathUrlStrategy();

  if (!kIsWeb) {
    Hive.init((await getApplicationDocumentsDirectory()).path);
  }

  runApp(
    BlocProvider(
      create: (context) => MainCubit(),
      child: const MainPage(),
    ),
  );
}
