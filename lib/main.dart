import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:git_explorer/app/app.dart';
import 'package:git_explorer/core/theme/theme_cubit.dart';
import 'package:git_explorer/injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();

  runApp(
    MultiBlocProvider(
      providers: [BlocProvider(create: (context) => di.locator<ThemeCubit>())],
      child: const App(),
    ),
  );
}
