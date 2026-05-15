import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ============================================================
// VBHC APP THEME
// React Native Colors.js → Flutter ThemeData
// Light & Dark both included
// ============================================================

class AppTheme {
  AppTheme._(); // instantiate பண்ண வேண்டாம்

  // =====================
  // VBHC BRAND COLORS
  // உங்க Colors.js-ல இருந்து exact-ஆ எடுத்தவை
  // =====================

  // Brand Gold (backgroundBlue in RN = #C9A155)
  static const Color _gold = Color(0xFFC9A155);
  static const Color _darkGold = Color(0xFFa38708);

  // Status Colors (both themes-லயும் use ஆகுது)
  static const Color statusGreen = Color(0xFF71D561);
  static const Color statusYellow = Color(0xFFf4d03f);
  static const Color statusRed = Color(0xFFFA4032);
  static const Color darkStatusGreen = Color(0xFF66bb6a);
  static const Color darkStatusYellow = Color(0xFFffd54f);
  static const Color darkStatusRed = Color(0xFFef5350);

  // Button Blue
  static const Color buttonBlue = Color(0xFF133E87);
  static const Color darkButtonBlue = Color(0xFF1565c0);

  // =====================
  // LIGHT THEME
  // getColors(isDarkTheme = false) values
  // =====================
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,

    // ── Scaffold ──
    scaffoldBackgroundColor: const Color(0xFFecf0f1), // appScreenColor

    // ── Primary (VBHC Gold) ──
    primaryColor: _gold,

    // ── ColorScheme ──
    colorScheme: const ColorScheme.light(
      primary: Color(0xFFC9A155), // gold
      onPrimary: Color(0xFF171717), // activeIconColor
      secondary: Color(0xFF71D561), // green
      onSecondary: Color(0xFFFFFFFF),
      surface: Color(0xFFFFFFFF), // backgroundWhite
      onSurface: Color(0xFF000000), // textBlack
      error: Color(0xFFFA4032), // statusRed
      onError: Color(0xFFFFFFFF),
    ),

    // ── AppBar ──
    // actionBarColor: #ffffff, actionBarTextColor: #000000
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFFFFFFF),
      foregroundColor: Color(0xFF000000),
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: Color(0xFF000000)),
      actionsIconTheme: IconThemeData(color: Color(0xFF000000)),
      titleTextStyle: TextStyle(
        color: Color(0xFF000000),
        fontSize: 18,
        fontWeight: FontWeight.w600,
        fontFamily: 'OpenSans',
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Color(0xFFFFFFFF), // statusBarColor
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Color(0xFF000000), // navigationBarColor
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    ),

    // ── Bottom Navigation Bar ──
    // bottomNavBarColor: #171717, activeBackgroundColor: #C9A155
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF171717),
      selectedItemColor: Color(0xFFC9A155), // activeBackgroundColor
      unselectedItemColor: Color(0xFFFFFFFF), // inActiveIconColor
      elevation: 8,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        fontFamily: 'OpenSans',
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 11,
        fontFamily: 'OpenSans',
      ),
    ),

    // ── Card ──
    // cardTheme: CardTheme(
    //   color: const Color(0xFFFFFFFF), // backgroundWhite
    //   elevation: 2,
    //   shadowColor: Colors.black.withOpacity(0.1),
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(10),
    //   ),
    // ),

    // ── TextField / Input ──
    // textInputBackgroundColor: #ecf0f1
    // textInputBorderColor: #000000
    // textInputPlaceholderColor: #979a9a
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFFecf0f1),
      hintStyle: const TextStyle(
        color: Color(0xFF979a9a),
        fontFamily: 'OpenSans',
      ),
      labelStyle: const TextStyle(
        color: Color(0xFF333333), // textLabelTitle
        fontFamily: 'OpenSans',
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF000000)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFbbbbbb)), // borderColor
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide:
            const BorderSide(color: Color(0xFFC9A155), width: 2), // gold focus
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFFA4032)), // statusRed
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFFA4032), width: 2),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide:
            const BorderSide(color: Color(0xFFcccccc)), // disabledBorderColor
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
    ),

    // ── ElevatedButton ──
    // primaryButtonColor: #71D561
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF71D561), // primaryButtonColor
        foregroundColor: const Color(0xFFFFFFFF),
        elevation: 2,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          fontFamily: 'OpenSans',
        ),
      ),
    ),

    // ── TextButton ──
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: const Color(0xFF2874a6), // textBlue
        textStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontFamily: 'OpenSans',
        ),
      ),
    ),

    // ── OutlinedButton ──
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFFC9A155), // gold
        side: const BorderSide(color: Color(0xFFC9A155)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontFamily: 'OpenSans',
        ),
      ),
    ),

    // ── Text ──
    // textBlack: #000000, textGray: gray, textGray2: #626567
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: Color(0xFF000000),
        fontSize: 32,
        fontWeight: FontWeight.w800,
        fontFamily: 'OpenSans',
      ),
      displayMedium: TextStyle(
        color: Color(0xFF000000),
        fontSize: 28,
        fontWeight: FontWeight.w700,
        fontFamily: 'OpenSans',
      ),
      headlineLarge: TextStyle(
        color: Color(0xFF000000),
        fontSize: 24,
        fontWeight: FontWeight.w700,
        fontFamily: 'OpenSans',
      ),
      headlineMedium: TextStyle(
        color: Color(0xFF000000),
        fontSize: 20,
        fontWeight: FontWeight.w600,
        fontFamily: 'OpenSans',
      ),
      titleLarge: TextStyle(
        color: Color(0xFF000000),
        fontSize: 18,
        fontWeight: FontWeight.w600,
        fontFamily: 'OpenSans',
      ),
      titleMedium: TextStyle(
        color: Color(0xFF333333), fontSize: 16, // textLabelTitle
        fontWeight: FontWeight.w500, fontFamily: 'OpenSans',
      ),
      titleSmall: TextStyle(
        color: Color(0xFF555555), fontSize: 14, // textLabelColor
        fontWeight: FontWeight.w500, fontFamily: 'OpenSans',
      ),
      bodyLarge: TextStyle(
        color: Color(0xFF000000),
        fontSize: 16,
        fontFamily: 'OpenSans',
      ),
      bodyMedium: TextStyle(
        color: Color(0xFF626567), fontSize: 14, // textGray2
        fontFamily: 'OpenSans',
      ),
      bodySmall: TextStyle(
        color: Color(0xFF888888), fontSize: 12, // diabledTextColor
        fontFamily: 'OpenSans',
      ),
      labelLarge: TextStyle(
        color: Color(0xFF000000),
        fontSize: 14,
        fontWeight: FontWeight.w600,
        fontFamily: 'OpenSans',
      ),
    ),

    // ── Icon ──
    // commonIconColor: #000000, iconGray: #626567
    iconTheme: const IconThemeData(
      color: Color(0xFF000000), // commonIconColor
      size: 24,
    ),

    // ── Divider ──
    // textLine: #eee
    dividerTheme: const DividerThemeData(
      color: Color(0xFFeeeeee),
      thickness: 1,
      space: 1,
    ),

    // ── Switch ──
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const Color(0xFFC9A155);
        }
        return const Color(0xFFd0d3d4); // backgroundGray
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const Color(0xFFC9A155).withOpacity(0.4);
        }
        return const Color(0xFFd0d3d4).withOpacity(0.4);
      }),
    ),

    // ── Checkbox ──
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const Color(0xFFC9A155);
        }
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.all(const Color(0xFF171717)),
      side: const BorderSide(color: Color(0xFFbbbbbb)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    ),

    // ── ListTile ──
    listTileTheme: const ListTileThemeData(
      tileColor: Colors.transparent,
      iconColor: Color(0xFF000000),
      textColor: Color(0xFF000000),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    ),

    // ── Chip ──
    chipTheme: ChipThemeData(
      backgroundColor: const Color(0xFFf0f0f0), // disabledbackgroundColor
      labelStyle: const TextStyle(
        color: Color(0xFF333333),
        fontFamily: 'OpenSans',
      ),
      side: const BorderSide(color: Color(0xFFbbbbbb)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),

    // ── Drawer ──
    drawerTheme: const DrawerThemeData(
      backgroundColor: Color(0xFFFFFFFF),
      elevation: 8,
    ),

    // ── Dialog ──
    // dialogTheme: DialogTheme(
    //   backgroundColor: const Color(0xFFFFFFFF),
    //   elevation: 8,
    //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    //   titleTextStyle: const TextStyle(
    //     color: Color(0xFF000000),
    //     fontSize: 18,
    //     fontWeight: FontWeight.w700,
    //     fontFamily: 'OpenSans',
    //   ),
    //   contentTextStyle: const TextStyle(
    //     color: Color(0xFF626567),
    //     fontSize: 14,
    //     fontFamily: 'OpenSans',
    //   ),
    // ),

    // ── SnackBar ──
    snackBarTheme: SnackBarThemeData(
      backgroundColor: const Color(0xFF171717),
      contentTextStyle: const TextStyle(
        color: Color(0xFFFFFFFF),
        fontFamily: 'OpenSans',
      ),
      actionTextColor: const Color(0xFFC9A155), // gold
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      behavior: SnackBarBehavior.floating,
    ),

    // ── FloatingActionButton ──
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFFC9A155), // gold
      foregroundColor: Color(0xFF171717),
      elevation: 4,
    ),

    // ── Tab Bar ──
    // tabBarTheme: const TabBarTheme(
    //   labelColor: Color(0xFFC9A155), // gold - active
    //   unselectedLabelColor: Color(0xFF626567), // textGray2 - inactive
    //   indicatorColor: Color(0xFFC9A155),
    //   labelStyle: TextStyle(
    //     fontWeight: FontWeight.w600,
    //     fontFamily: 'OpenSans',
    //   ),
    //   unselectedLabelStyle: TextStyle(
    //     fontFamily: 'OpenSans',
    //   ),
    // ),

    fontFamily: 'OpenSans',
  );

  // =====================
  // DARK THEME
  // getColors(isDarkTheme = true) values
  // =====================
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,

    // ── Scaffold ──
    scaffoldBackgroundColor: const Color(0xFF121212), // appScreenColor dark

    // ── Primary ──
    primaryColor: _darkGold,

    // ── ColorScheme ──
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFFa38708), // darkGold
      onPrimary: Color(0xFF000000),
      secondary: Color(0xFF66bb6a), // darkStatusGreen
      onSecondary: Color(0xFF000000),
      surface: Color(0xFF1e1e1e), // actionBarColor dark
      onSurface: Color(0xFFe0e0e0), // textBlack dark
      error: Color(0xFFef5350), // statusRed dark
      onError: Color(0xFFFFFFFF),
    ),

    // ── AppBar ──
    // actionBarColor dark: #1e1e1e, actionBarTextColor: #ffffff
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1e1e1e),
      foregroundColor: Color(0xFFFFFFFF),
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: Color(0xFFFFFFFF)),
      actionsIconTheme: IconThemeData(color: Color(0xFFFFFFFF)),
      titleTextStyle: TextStyle(
        color: Color(0xFFFFFFFF),
        fontSize: 18,
        fontWeight: FontWeight.w600,
        fontFamily: 'OpenSans',
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Color(0xFF000000), // statusBarColor dark
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Color(0xFF000000),
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    ),

    // ── Bottom Navigation Bar ──
    // bottomNavBarColor dark: #171717, activeBackgroundColor: #a38708
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF171717),
      selectedItemColor: Color(0xFFa38708), // darkGold
      unselectedItemColor: Color(0xFFb0b0b0), // inActiveIconColor dark
      elevation: 8,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        fontFamily: 'OpenSans',
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 11,
        fontFamily: 'OpenSans',
      ),
    ),

    // ── Card ──

    // ── TextField / Input ──
    // textInputBackgroundColor dark: #1e1e1e
    // textInputBorderColor dark: #4b5563
    // textInputPlaceholderColor dark: #6b7280
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF1e1e1e),
      hintStyle: const TextStyle(
        color: Color(0xFF6b7280),
        fontFamily: 'OpenSans',
      ),
      labelStyle: const TextStyle(
        color: Color(0xFFe5e7eb), // textLabelTitle dark
        fontFamily: 'OpenSans',
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF4b5563)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide:
            const BorderSide(color: Color(0xFF374151)), // borderColor dark
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide:
            const BorderSide(color: Color(0xFFa38708), width: 2), // darkGold
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFef5350)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFef5350), width: 2),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF4b5563)),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
    ),

    // ── ElevatedButton ──
    // primaryButtonColor dark: #66bb6a
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF66bb6a), // darkStatusGreen
        foregroundColor: const Color(0xFF000000),
        elevation: 2,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          fontFamily: 'OpenSans',
        ),
      ),
    ),

    // ── TextButton ──
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: const Color(0xFF64b5f6), // textBlue dark
        textStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontFamily: 'OpenSans',
        ),
      ),
    ),

    // ── OutlinedButton ──
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFFa38708), // darkGold
        side: const BorderSide(color: Color(0xFFa38708)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontFamily: 'OpenSans',
        ),
      ),
    ),

    // ── Text ──
    // textBlack dark: #e0e0e0
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: Color(0xFFe0e0e0),
        fontSize: 32,
        fontWeight: FontWeight.w800,
        fontFamily: 'OpenSans',
      ),
      displayMedium: TextStyle(
        color: Color(0xFFe0e0e0),
        fontSize: 28,
        fontWeight: FontWeight.w700,
        fontFamily: 'OpenSans',
      ),
      headlineLarge: TextStyle(
        color: Color(0xFFe0e0e0),
        fontSize: 24,
        fontWeight: FontWeight.w700,
        fontFamily: 'OpenSans',
      ),
      headlineMedium: TextStyle(
        color: Color(0xFFe0e0e0),
        fontSize: 20,
        fontWeight: FontWeight.w600,
        fontFamily: 'OpenSans',
      ),
      titleLarge: TextStyle(
        color: Color(0xFFe0e0e0),
        fontSize: 18,
        fontWeight: FontWeight.w600,
        fontFamily: 'OpenSans',
      ),
      titleMedium: TextStyle(
        color: Color(0xFFe5e7eb), fontSize: 16, // textLabelTitle dark
        fontWeight: FontWeight.w500, fontFamily: 'OpenSans',
      ),
      titleSmall: TextStyle(
        color: Color(0xFF9ca3af), fontSize: 14, // textLabelColor dark
        fontWeight: FontWeight.w500, fontFamily: 'OpenSans',
      ),
      bodyLarge: TextStyle(
        color: Color(0xFFe0e0e0),
        fontSize: 16,
        fontFamily: 'OpenSans',
      ),
      bodyMedium: TextStyle(
        color: Color(0xFF9ca3af), fontSize: 14, // textGray2 dark
        fontFamily: 'OpenSans',
      ),
      bodySmall: TextStyle(
        color: Color(0xFF6b7280), fontSize: 12, // diabledTextColor dark
        fontFamily: 'OpenSans',
      ),
      labelLarge: TextStyle(
        color: Color(0xFFe0e0e0),
        fontSize: 14,
        fontWeight: FontWeight.w600,
        fontFamily: 'OpenSans',
      ),
    ),

    // ── Icon ──
    // commonIconColor dark: #e0e0e0, iconGray dark: #9e9e9e
    iconTheme: const IconThemeData(
      color: Color(0xFFe0e0e0),
      size: 24,
    ),

    // ── Divider ──
    // textLine dark: #2a2a2a
    dividerTheme: const DividerThemeData(
      color: Color(0xFF2a2a2a),
      thickness: 1,
      space: 1,
    ),

    // ── Switch ──
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const Color(0xFFa38708);
        }
        return const Color(0xFF2d2d2d); // backgroundGray dark
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const Color(0xFFa38708).withOpacity(0.4);
        }
        return const Color(0xFF2d2d2d).withOpacity(0.4);
      }),
    ),

    // ── Checkbox ──
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const Color(0xFFa38708);
        }
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.all(const Color(0xFF000000)),
      side: const BorderSide(color: Color(0xFF374151)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    ),

    // ── ListTile ──
    listTileTheme: const ListTileThemeData(
      tileColor: Colors.transparent,
      iconColor: Color(0xFFe0e0e0),
      textColor: Color(0xFFe0e0e0),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    ),

    // ── Chip ──
    chipTheme: ChipThemeData(
      backgroundColor: const Color(0xFF2a2a2a), // disabledbackgroundColor dark
      labelStyle: const TextStyle(
        color: Color(0xFFe5e7eb),
        fontFamily: 'OpenSans',
      ),
      side: const BorderSide(color: Color(0xFF374151)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),

    // ── Drawer ──
    drawerTheme: const DrawerThemeData(
      backgroundColor: Color(0xFF1e1e1e),
      elevation: 8,
    ),

    // ── Dialog ──

    // ── SnackBar ──
    snackBarTheme: SnackBarThemeData(
      backgroundColor: const Color(0xFF2a2a2a),
      contentTextStyle: const TextStyle(
        color: Color(0xFFe0e0e0),
        fontFamily: 'OpenSans',
      ),
      actionTextColor: const Color(0xFFa38708), // darkGold
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      behavior: SnackBarBehavior.floating,
    ),

    // ── FloatingActionButton ──
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFFa38708), // darkGold
      foregroundColor: Color(0xFF000000),
      elevation: 4,
    ),

    // ── Tab Bar ──

    fontFamily: 'OpenSans',
  );
}
