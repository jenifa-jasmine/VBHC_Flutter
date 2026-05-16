// lib/core/colors/app_colors.dart
import 'package:flutter/material.dart';

class AppColors {
  // =====================

  // =====================
  static const Color gold = Color(0xFFC9A155); // backgroundBlue (brand)
  static const Color darkGold = Color(0xFFa38708);
  static const Color green = Color(0xFF71D561);
  static const Color darkGreen = Color(0xFF2e7d32);
  static const Color blue = Color(0xFF2874a6);
  static const Color lightBlue = Color(0xFF21CBE5);
  static const Color buttonBlue = Color(0xFF133E87);
  static const Color red = Color(0xFFFA4032);
  static const Color yellow = Color(0xFFf4d03f);
  static const Color orange = Color(0xFFf5b041);
  static const Color statusRed = Colors.red;
  // =====================
  // LIGHT THEME (isDarkTheme = false)
  // =====================
  static const Color lightStatusBar = Color(0xFFFFFFFF);
  static const Color lightActionBar = Color(0xFFFFFFFF);
  static const Color lightActionBarText = Color(0xFF000000);
  static const Color lightActionBarIcon = Color(0xFF000000);
  static const Color lightBackground = Color(0xFFecf0f1); // appScreenColor
  static const Color lightNavBar = Color(0xFF000000);

  // BottomNav Light
  static const Color lightBottomNav = Color(0xFF171717);
  static const Color lightActiveNavBg = Color(0xFFC9A155);
  static const Color lightActiveNavIcon = Color(0xFF171717);
  static const Color lightInactiveNavIcon = Color(0xFFFFFFFF);

  // Input Light
  static const Color lightInputBg = Color(0xFFecf0f1);
  static const Color lightInputBorder = Color(0xFF000000);
  static const Color lightInputPlaceholder = Color(0xFF979a9a);
  static const Color lightInputText = Color(0xFF000000);

  // Text Light
  static const Color lightTextBlack = Color(0xFF000000);
  static const Color lightTextWhite = Color(0xFFFFFFFF);
  static const Color lightTextGray = Color(0xFF808080);
  static const Color lightTextGray2 = Color(0xFF626567);
  static const Color lightTextGreen = Color(0xFF71D561);
  static const Color lightTextBlue = Color(0xFF2874a6);
  static const Color lightTextBlue2 = Color(0xFF21CBE5);
  static const Color lightDisabledText = Color(0xFF888888);

  // Border Light
  static const Color lightBorder = Color(0xFFbbbbbb);
  static const Color lightDisabledBorder = Color(0xFFcccccc);
  static const Color lightTextLine = Color(0xFFeeeeee);
  static const Color lightLabelTitle = Color(0xFF333333);
  static const Color lightLabelColor = Color(0xFF555555);

  // Background Light
  static const Color lightBgWhite = Color(0xFFFFFFFF);
  static const Color lightBgGray = Color(0xFFd0d3d4);
  static const Color lightBgGray2 = Color(0xFF3e3e3e);
  static const Color lightBgBlue2 = Color(0xFF5dade2);
  static const Color lightBgOrange = Color(0xFFf5b041);
  static const Color lightBgBlack = Color(0xFF000000);
  static const Color lightDisabledBg = Color(0xFFf0f0f0);
  static const Color lightEditBg = Color(0xFFf9f9f9);

  // Status Light
  static const Color lightStatusGreen = Color(0xFF71D561);
  static const Color lightStatusYellow = Color(0xFFf4d03f);
  static const Color lightStatusRed = Color(0xFFFA4032);

  // Empty Data Light
  static const Color lightEmptyTitle = Color(0xFF333333);
  static const Color lightEmptyText = Color(0xFF666666);

  // =====================
  // DARK THEME (isDarkTheme = true)
  // =====================
  static const Color darkStatusBar = Color(0xFF000000);
  static const Color darkActionBar = Color(0xFF1e1e1e);
  static const Color darkActionBarText = Color(0xFFFFFFFF);
  static const Color darkActionBarIcon = Color(0xFFFFFFFF);
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkNavBar = Color(0xFF000000);

  // BottomNav Dark
  static const Color darkBottomNav = Color(0xFF171717);
  static const Color darkActiveNavBg = Color(0xFFa38708);
  static const Color darkActiveNavIcon = Color(0xFF000000);
  static const Color darkInactiveNavIcon = Color(0xFFb0b0b0);

  // Input Dark
  static const Color darkInputBg = Color(0xFF1e1e1e);
  static const Color darkInputBorder = Color(0xFF4b5563);
  static const Color darkInputPlaceholder = Color(0xFF6b7280);
  static const Color darkInputText = Color(0xFFe0e0e0);

  // Text Dark
  static const Color darkTextBlack = Color(0xFFe0e0e0);
  static const Color darkTextWhite = Color(0xFFFFFFFF);
  static const Color darkTextGray = Color(0xFFb0b0b0);
  static const Color darkTextGray2 = Color(0xFF9ca3af);
  static const Color darkTextGreen = Color(0xFF81c784);
  static const Color darkTextBlue = Color(0xFF64b5f6);
  static const Color darkTextBlue2 = Color(0xFF4dd0e1);
  static const Color darkDisabledText = Color(0xFF6b7280);

  // Border Dark
  static const Color darkBorder = Color(0xFF374151);
  static const Color darkDisabledBorder = Color(0xFF4b5563);
  static const Color darkTextLine = Color(0xFF2a2a2a);
  static const Color darkLabelTitle = Color(0xFFe5e7eb);
  static const Color darkLabelColor = Color(0xFF9ca3af);

  // Background Dark
  static const Color darkBgWhite = Color(0xFF121212);
  static const Color darkBgGray = Color(0xFF2d2d2d);
  static const Color darkBgGray2 = Color(0xFF1a1a1a);
  static const Color darkBgBlue2 = Color(0xFF0288d1);
  static const Color darkBgOrange = Color(0xFFff8f00);
  static const Color darkBgBlack = Color(0xFFe0e0e0);
  static const Color darkDisabledBg = Color(0xFF2a2a2a);
  static const Color darkEditBg = Color(0xFF1e1e1e);

  // Status Dark
  static const Color darkStatusGreen = Color(0xFF66bb6a);
  static const Color darkStatusYellow = Color(0xFFffd54f);
  static const Color darkStatusRed = Color(0xFFef5350);

  // Empty Data Dark
  static const Color darkEmptyTitle = Color(0xFFe5e7eb);
  static const Color darkEmptyText = Color(0xFF9ca3af);
}

// =====================

// =====================
class VBHCColors {
  final bool isDark;

  VBHCColors(this.isDark);

  Color get statusBarColor =>
      isDark ? AppColors.darkStatusBar : AppColors.lightStatusBar;
  Color get actionBarColor =>
      isDark ? AppColors.darkActionBar : AppColors.lightActionBar;
  Color get actionBarTextColor =>
      isDark ? AppColors.darkActionBarText : AppColors.lightActionBarText;
  Color get actionBarIconColor =>
      isDark ? AppColors.darkActionBarIcon : AppColors.lightActionBarIcon;
  Color get appScreenColor =>
      isDark ? AppColors.darkBackground : AppColors.lightBackground;
  Color get bottomNavBarColor =>
      isDark ? AppColors.darkBottomNav : AppColors.lightBottomNav;
  Color get activeBackgroundColor =>
      isDark ? AppColors.darkActiveNavBg : AppColors.lightActiveNavBg;
  Color get activeIconColor =>
      isDark ? AppColors.darkActiveNavIcon : AppColors.lightActiveNavIcon;
  Color get inActiveIconColor =>
      isDark ? AppColors.darkInactiveNavIcon : AppColors.lightInactiveNavIcon;
  Color get textInputBackground =>
      isDark ? AppColors.darkInputBg : AppColors.lightInputBg;
  Color get textInputBorderColor =>
      isDark ? AppColors.darkInputBorder : AppColors.lightInputBorder;
  Color get textInputPlaceholder =>
      isDark ? AppColors.darkInputPlaceholder : AppColors.lightInputPlaceholder;
  Color get textInputTextColor =>
      isDark ? AppColors.darkInputText : AppColors.lightInputText;
  Color get textBlack =>
      isDark ? AppColors.darkTextBlack : AppColors.lightTextBlack;
  Color get textWhite => AppColors.lightTextWhite;
  Color get textGray =>
      isDark ? AppColors.darkTextGray : AppColors.lightTextGray;
  Color get textGreen =>
      isDark ? AppColors.darkTextGreen : AppColors.lightTextGreen;
  Color get textBlue =>
      isDark ? AppColors.darkTextBlue : AppColors.lightTextBlue;
  Color get borderColor =>
      isDark ? AppColors.darkBorder : AppColors.lightBorder;
  Color get textLine =>
      isDark ? AppColors.darkTextLine : AppColors.lightTextLine;
  Color get textLabelTitle =>
      isDark ? AppColors.darkLabelTitle : AppColors.lightLabelTitle;
  Color get textLabelColor =>
      isDark ? AppColors.darkLabelColor : AppColors.lightLabelColor;
  Color get primaryButtonColor =>
      isDark ? AppColors.darkStatusGreen : AppColors.lightStatusGreen;
  Color get backgroundWhite =>
      isDark ? AppColors.darkBgWhite : AppColors.lightBgWhite;
  Color get backgroundBlue =>
      isDark ? AppColors.darkActiveNavBg : AppColors.lightActiveNavBg;
  Color get backgroundGray =>
      isDark ? AppColors.darkBgGray : AppColors.lightBgGray;
  Color get editBackgroundColor =>
      isDark ? AppColors.darkEditBg : AppColors.lightEditBg;
  Color get disabledBackground =>
      isDark ? AppColors.darkDisabledBg : AppColors.lightDisabledBg;
  Color get statusGreen =>
      isDark ? AppColors.darkStatusGreen : AppColors.lightStatusGreen;
  Color get statusYellow =>
      isDark ? AppColors.darkStatusYellow : AppColors.lightStatusYellow;
  Color get statusRed =>
      isDark ? AppColors.darkStatusRed : AppColors.lightStatusRed;
  Color get emptyDataTitle =>
      isDark ? AppColors.darkEmptyTitle : AppColors.lightEmptyTitle;
  Color get emptyDataText =>
      isDark ? AppColors.darkEmptyText : AppColors.lightEmptyText;
}
