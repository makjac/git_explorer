import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:git_explorer/core/localization/app_localizations_extension.dart';
import 'package:git_explorer/core/theme/theme_extension.dart';
import 'package:git_explorer/pages/settings/widgets/settings_widgets.dart';

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
