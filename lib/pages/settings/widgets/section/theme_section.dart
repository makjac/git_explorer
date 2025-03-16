import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:git_explorer/core/localization/app_localizations_extension.dart';
import 'package:git_explorer/core/theme/theme_cubit.dart';
import 'package:git_explorer/core/theme/theme_extension.dart';

class ThemeSection extends StatelessWidget {
  const ThemeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, currentTheme) {
        return Card(
          elevation: 0,
          child: Column(
            children: [
              ThemeOption(
                themeMode: ThemeMode.system,
                title: context.l10n.systemDefault,
                icon: Icons.settings_suggest_outlined,
                currentTheme: currentTheme,
              ),
              const Divider(),
              ThemeOption(
                themeMode: ThemeMode.light,
                title: context.l10n.light,
                icon: Icons.light_mode_outlined,
                currentTheme: currentTheme,
              ),
              const Divider(),
              ThemeOption(
                themeMode: ThemeMode.dark,
                title: context.l10n.dark,
                icon: Icons.dark_mode_outlined,
                currentTheme: currentTheme,
              ),
            ],
          ),
        );
      },
    );
  }
}

class ThemeOption extends StatelessWidget {
  const ThemeOption({
    required this.themeMode,
    required this.title,
    required this.icon,
    required this.currentTheme,
    super.key,
  });

  final ThemeMode themeMode;
  final String title;
  final IconData icon;
  final ThemeMode currentTheme;

  @override
  Widget build(BuildContext context) {
    final isSelected = currentTheme == themeMode;

    return InkWell(
      onTap: () {
        context.read<ThemeCubit>().changeTheme(themeMode);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(icon, size: 20, color: context.colorScheme.onSurfaceVariant),
            const SizedBox(width: 16),
            Expanded(child: Text(title, style: context.textTheme.bodyMedium)),
            if (isSelected)
              Icon(Icons.check, color: context.colorScheme.primary, size: 20),
          ],
        ),
      ),
    );
  }
}
