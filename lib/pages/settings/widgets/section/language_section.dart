import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:git_explorer/core/Localization/localization_cubit.dart';
import 'package:git_explorer/core/theme/theme_extension.dart';
import 'package:git_explorer/src/generated/i18n/app_localizations.dart';

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
