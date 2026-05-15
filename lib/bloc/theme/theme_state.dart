// lib/bloc/theme/theme_state.dart

class ThemeState {
  final bool isDark;
  final String mode; // "auto" | "light" | "dark"

  const ThemeState({required this.isDark, required this.mode});

  factory ThemeState.initial() => const ThemeState(isDark: false, mode: "auto");

  ThemeState copyWith({bool? isDark, String? mode}) {
    return ThemeState(
      isDark: isDark ?? this.isDark,
      mode: mode ?? this.mode,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ThemeState && other.isDark == isDark && other.mode == mode;
  }

  @override
  int get hashCode => Object.hash(isDark, mode);
}