import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:git_explorer/core/utils/logger.dart';
import 'package:git_explorer/injection_container.dart';
import 'package:git_explorer/src/generated/i18n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationCubit extends Cubit<Locale> {
  LocalizationCubit() : super(_defaultLocale) {
    _init();
  }

  static const String _localeKey = 'selectedLocale';
  static const Locale _defaultLocale = Locale('en');

  void changeLocale(Locale locale) {
    if (!AppLocalizations.supportedLocales.contains(locale)) {
      Logger.showLog('Unsupported locale: $locale', 'LocalizationCubit');
      return;
    }

    locator<SharedPreferences>().setString(_localeKey, locale.languageCode);

    Intl.defaultLocale = locale.languageCode;

    Logger.showLog('Locale changed to: $locale', 'LocalizationCubit');
    emit(locale);
  }

  Future<void> _init() async {
    final savedLocaleCode = locator<SharedPreferences>().getString(_localeKey);

    if (savedLocaleCode != null) {
      final savedLocale = Locale(savedLocaleCode);

      if (AppLocalizations.supportedLocales.contains(savedLocale)) {
        Intl.defaultLocale = savedLocale.languageCode;
        emit(savedLocale);
        return;
      }
    }

    final systemLocale = WidgetsBinding.instance.platformDispatcher.locale;
    final systemLanguageCode = systemLocale.languageCode;
    final systemLocaleToUse = Locale(systemLanguageCode);

    if (AppLocalizations.supportedLocales.contains(systemLocaleToUse)) {
      Logger.showLog(
        'Using system locale: $systemLocaleToUse',
        'LocalizationCubit',
      );
      changeLocale(systemLocaleToUse);
    } else {
      Logger.showLog(
        'System locale not supported, using default: $_defaultLocale',
        'LocalizationCubit',
      );
      changeLocale(_defaultLocale);
    }
  }
}
