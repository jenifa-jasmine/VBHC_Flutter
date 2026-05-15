// lib/bloc/theme/theme_cubit.dart
import 'dart:ui' show Brightness;
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  static const String _themeKey = "themeMode";

  ThemeCubit() : super(ThemeState.initial());

  // loadTheme() - themeSlice loadTheme thunk
  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final savedMode = prefs.getString(_themeKey) ?? "auto";
    _applyMode(savedMode);
  }

  // saveTheme() - themeSlice saveTheme thunk
  Future<void> saveTheme(String mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, mode);
    _applyMode(mode);
  }

  // toggleTheme()
  Future<void> toggleTheme() async {
    final newMode = state.isDark ? "light" : "dark";
    await saveTheme(newMode);
  }

  // setTheme()
  Future<void> setTheme(String mode) async {
    await saveTheme(mode);
  }

  // updateSystemTheme() - system theme change
  void updateSystemTheme(String colorScheme) {
    if (state.mode == "auto") {
      emit(state.copyWith(isDark: colorScheme == "dark"));
    }
  }

  void _applyMode(String mode) {
    bool isDark;
    if (mode == "auto") {
      final brightness =
          SchedulerBinding.instance.platformDispatcher.platformBrightness;
      isDark = brightness == Brightness.dark;
    } else {
      isDark = mode == "dark";
    }
    emit(ThemeState(isDark: isDark, mode: mode));
  }
}
