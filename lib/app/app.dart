import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:git_explorer/core/theme/app_theme.dart';
import 'package:git_explorer/core/theme/theme_cubit.dart';
import 'package:git_explorer/core/theme/theme_extension.dart';
import 'package:git_explorer/core/widgets/icons/app_icon.dart';
import 'package:git_explorer/core/widgets/icons/app_icons.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.watch<ThemeCubit>();

    return MaterialApp(
      title: 'GitHub Theme Demo',
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: themeCubit.state,
      debugShowCheckedModeBanner: false,
      home: const Temp(),
    );
  }
}

class Temp extends StatelessWidget {
  const Temp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('temp')),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                context.read<ThemeCubit>().changeTheme(
                  context.theme.brightness == Brightness.dark
                      ? ThemeMode.light
                      : ThemeMode.dark,
                );
              },
              child: const Text('Change Theme'),
            ),
            const AppIcon(icon: AppIcons.branch),
            const AppIcon(icon: AppIcons.code),
            const AppIcon(icon: AppIcons.frok),
            const AppIcon(icon: AppIcons.pullRequest),
            const AppIcon(icon: AppIcons.readme),
            const AppIcon(icon: AppIcons.search),
            const AppIcon(icon: AppIcons.star),
            const AppIcon(icon: AppIcons.settings),
            const AppIcon(icon: AppIcons.tag),
            const AppIcon(icon: AppIcons.watch),
          ],
        ),
      ),
    );
  }
}
