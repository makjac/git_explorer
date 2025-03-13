import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:git_explorer/core/router/app_router.dart';
import 'package:git_explorer/core/theme/app_theme.dart';
import 'package:git_explorer/core/theme/theme_cubit.dart';

final _appRouter = AppRouter();

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.watch<ThemeCubit>();

    return MaterialApp.router(
      title: 'Git Explorer',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: themeCubit.state,
      routerConfig: _appRouter.config(),
    );
  }
}
