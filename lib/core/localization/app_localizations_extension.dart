import 'package:flutter/widgets.dart';
import 'package:git_explorer/src/generated/i18n/app_localizations.dart';

extension AppLocalizationsExtension on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
  Locale get locale => Localizations.localeOf(this);
}
