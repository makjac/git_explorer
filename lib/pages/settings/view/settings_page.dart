import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:git_explorer/core/Localization/localization_cubit.dart';
import 'package:git_explorer/core/localization/app_localizations_extension.dart';
import 'package:git_explorer/core/theme/theme_cubit.dart';
import 'package:git_explorer/core/theme/theme_extension.dart';
import 'package:git_explorer/src/generated/i18n/app_localizations.dart';

@RoutePage()
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.settings),
        elevation: 0,
        backgroundColor: context.colorScheme.surface,
        foregroundColor: context.colorScheme.onSurface,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionHeader(title: context.l10n.appearance),
              const ThemeSection(),
              const SizedBox(height: 16),
              SectionHeader(title: context.l10n.languages),
              const LanguageSection(),
              const SizedBox(height: 16),
              SectionHeader(title: context.l10n.about),
              const AboutSection(),
              const SizedBox(height: 24),
              const VersionInfo(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  const SectionHeader({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            title,
            style: context.textTheme.titleLarge?.copyWith(letterSpacing: .5),
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

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

class LanguageSection extends StatelessWidget {
  const LanguageSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationCubit, Locale>(
      builder: (context, currentLocale) {
        return Card(
          elevation: 0,
          child: Column(
            children:
                AppLocalizations.supportedLocales.map((locale) {
                  final isSelected =
                      currentLocale.languageCode == locale.languageCode;
                  final localeName = _getLanguageName(locale.languageCode);

                  return Column(
                    children: [
                      if (AppLocalizations.supportedLocales.indexOf(locale) > 0)
                        const Divider(),
                      InkWell(
                        onTap: () {
                          context.read<LocalizationCubit>().changeLocale(
                            locale,
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          child: Row(
                            children: [
                              Text(
                                locale.languageCode.toUpperCase(),
                                style: context.textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: context.colorScheme.onSurfaceVariant,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  localeName,
                                  style: context.textTheme.bodyMedium,
                                ),
                              ),
                              if (isSelected)
                                Icon(
                                  Icons.check,
                                  color: context.colorScheme.primary,
                                  size: 20,
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
          ),
        );
      },
    );
  }

  String _getLanguageName(String languageCode) {
    switch (languageCode) {
      case 'en':
        return 'English';
      case 'pl':
        return 'Polski';
      default:
        return languageCode;
    }
  }
}

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Column(
        children: [
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Icon(
                    Icons.description_outlined,
                    size: 20,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      context.l10n.termsOfUse,
                      style: context.textTheme.bodyMedium,
                    ),
                  ),
                  Icon(
                    Icons.arrow_outward,
                    size: 16,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ],
              ),
            ),
          ),
          const Divider(),
          InkWell(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(context.l10n.feedbackSent)),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Icon(
                    Icons.feedback_outlined,
                    size: 20,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      context.l10n.sendFeedback,
                      style: context.textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class VersionInfo extends StatelessWidget {
  const VersionInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '${context.l10n.version}: 1.0.0 (1)',
        style: context.textTheme.bodySmall?.copyWith(
          color: context.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
