import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:git_explorer/core/localization/localization_cubit.dart';
import 'package:git_explorer/core/router/app_router.dart';
import 'package:git_explorer/core/theme/app_theme.dart';
import 'package:git_explorer/core/theme/theme_cubit.dart';
import 'package:git_explorer/src/generated/i18n/app_localizations.dart';

final _appRouter = AppRouter();

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.watch<ThemeCubit>();
    final localizationCubit = context.watch<LocalizationCubit>();

    return MaterialApp.router(
      title: 'Git Explorer',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: themeCubit.state,
      locale: localizationCubit.state,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: _appRouter.config(),
    );
  }
}
