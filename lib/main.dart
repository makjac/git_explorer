import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:git_explorer/app/app.dart';
import 'package:git_explorer/core/Localization/localization_cubit.dart';
import 'package:git_explorer/core/theme/theme_cubit.dart';
import 'package:git_explorer/core/utils/logger.dart';
import 'package:git_explorer/injection_container.dart' as di;
import 'package:git_explorer/pages/home/cubit/search_repo_cubit.dart';

Future<void> main() async {
  Logger.showLog('Initializing app', 'main');
  WidgetsFlutterBinding.ensureInitialized();

  Logger.showLog('Initializing dependency injection', 'main');
  await di.init();

  Logger.showLog('Running app', 'main');
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.locator<ThemeCubit>()),
        BlocProvider(create: (context) => di.locator<LocalizationCubit>()),
        BlocProvider(create: (context) => di.locator<SearchRepoCubit>()),
      ],
      child: const App(),
    ),
  );
}
