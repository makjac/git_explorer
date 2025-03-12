import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:git_explorer/core/utils/logger.dart';
import 'package:git_explorer/injection_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system) {
    _init();
  }

  void changeTheme(ThemeMode themeMode) {
    locator<SharedPreferences>().setString('themeMode', themeMode.toString());
    Logger.showLog('Theme mode changed: $themeMode', 'ThemeCubit');
    emit(themeMode);
  }

  Future<void> _init() async {
    final themeMode = locator<SharedPreferences>().getString('themeMode');
    if (themeMode != null) {
      final selectedTheme = ThemeMode.values.firstWhere(
        (e) => e.toString() == themeMode,
        orElse: () => ThemeMode.system,
      );
      emit(selectedTheme);
    }
  }
}
