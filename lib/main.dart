import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:git_explorer/app/app.dart';
import 'package:git_explorer/core/theme/theme_cubit.dart';
import 'package:git_explorer/injection_container.dart' as di;
import 'package:git_explorer/pages/home/cubit/search_repo_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.locator<ThemeCubit>()),
        BlocProvider(create: (context) => di.locator<SearchRepoCubit>()),
      ],
      child: const App(),
    ),
  );
}
