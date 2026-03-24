import 'package:flutter/material.dart';

/// Extracted from `v0-project/app/globals.css` and `v0-project/app/page.tsx`.
/// Keeps the current Flutter implementation on a reusable token-based API.
class UiPalette {
  UiPalette._();

  // Core medical analyzer palette from v0-project.
  static const Color navPrimary = Color(0xFF1A4F7A);
  static const Color navActive = Color(0xFF3A9BD5);
  static const Color tableHeader = Color(0xFF3A8FBF);
  static const Color tableRowLight = Color(0xFFD0E8F5);
  static const Color sidebarButton = Color(0xFF2D6FA0);
  static const Color statusBar = Color(0xFF0D3A5C);

  // Neutral/supporting tokens derived from the existing analyzer shell.
  static const Color background = Color(0xFFE8F2F8);
  static const Color foreground = Color(0xFF1E293B);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceMuted = Color(0xFFF0F4F7);
  static const Color border = Color(0xFFC0D8E8);
  static const Color input = Color(0xFFD8D8D8);
  static const Color inputBorder = Color(0xFF8EA1B1);
  static const Color disabledForeground = Color(0xFF888888);
  static const Color success = Color(0xFF49BB3E);

  // Compatibility aliases for the current Flutter codebase.
  static const Color chromeTop = navPrimary;
  static const Color chromeTopLight = Color(0xFF5F9BC3);
  static const Color frameBackground = background;
  static const Color panelBackground = Color(0xFFC4D0DB);
  static const Color panelBorder = Color(0xFFD4DDE6);

  static const Color tabHeader = navPrimary;
  static const Color tabHeaderLight = navActive;
  static const Color selectedTab = Color(0xFFC0D3E3);

  static const Color sideNav = sidebarButton;
  static const Color sideNavSelected = tableRowLight;

  static const Color tableHeaderLight = Color(0xFF6E93B9);
  static const Color tableRowA = surface;
  static const Color tableRowB = tableRowLight;
  static const Color tableAccent = navActive;

  static const Color footer = statusBar;
}

class UiTypography {
  UiTypography._();

  static const String fontFamily = 'Arial';

  // Explicit type scale extracted from the v0 design system showcase.
  static const double navLabelSize = 13;
  static const double tableHeaderSize = 12;
  static const double dataValueSize = 11;
  static const double statusSize = 11;
  static const double sectionTitleSize = 14;
  static const double buttonLabelSize = 13;
  static const double fieldLabelSize = 13;
  static const double inputValueSize = 12;

  static const FontWeight navLabelWeight = FontWeight.w700;
  static const FontWeight tableHeaderWeight = FontWeight.w600;
  static const FontWeight sectionTitleWeight = FontWeight.w600;
  static const FontWeight buttonLabelWeight = FontWeight.w500;

  static const TextStyle navLabel = TextStyle(
    fontFamily: fontFamily,
    fontSize: navLabelSize,
    fontWeight: navLabelWeight,
    color: Colors.white,
  );

  static const TextStyle topMenuLabel = TextStyle(
    fontFamily: fontFamily,
    fontSize: 15.5,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static const TextStyle sectionTitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: sectionTitleSize,
    fontWeight: sectionTitleWeight,
    color: UiPalette.foreground,
  );

  static const TextStyle fieldLabel = TextStyle(
    fontFamily: fontFamily,
    fontSize: fieldLabelSize,
    color: UiPalette.foreground,
  );

  static const TextStyle inputValue = TextStyle(
    fontFamily: fontFamily,
    fontSize: inputValueSize,
    color: UiPalette.foreground,
  );

  static const TextStyle dataValue = TextStyle(
    fontFamily: fontFamily,
    fontSize: dataValueSize,
    color: UiPalette.foreground,
  );

  static const TextStyle tableHeader = TextStyle(
    fontFamily: fontFamily,
    fontSize: tableHeaderSize,
    fontWeight: tableHeaderWeight,
    color: Colors.white,
  );

  static const TextStyle buttonLabel = TextStyle(
    fontFamily: fontFamily,
    fontSize: buttonLabelSize,
    fontWeight: buttonLabelWeight,
    color: UiPalette.foreground,
  );

  static const TextStyle buttonLabelOnPrimary = TextStyle(
    fontFamily: fontFamily,
    fontSize: buttonLabelSize,
    fontWeight: buttonLabelWeight,
    color: Colors.white,
  );

  static const TextStyle status = TextStyle(
    fontFamily: fontFamily,
    fontSize: statusSize,
    color: Colors.white,
  );

  static TextTheme textTheme = const TextTheme(
    titleSmall: sectionTitle,
    bodyLarge: inputValue,
    bodyMedium: dataValue,
    bodySmall: TextStyle(
      fontFamily: fontFamily,
      fontSize: statusSize,
      color: UiPalette.foreground,
    ),
    labelLarge: buttonLabel,
    labelMedium: fieldLabel,
  );
}

class UiMetrics {
  UiMetrics._();

  static const double radius = 4;
  static const double buttonRadius = 10;
  static const double inputRadius = 4;

  static const double space2 = 2;
  static const double space4 = 4;
  static const double space6 = 6;
  static const double space8 = 8;
  static const double space12 = 12;

  static const double topBarHeight = 74;
  static const double bottomBarHeight = 34;
  static const double sideButtonHeight = 48;
  static const double formFieldHeight = 32;
  static const double tableHeaderHeight = 40;
}

class UiTheme {
  UiTheme._();

  static ThemeData materialTheme() {
    final ColorScheme colorScheme = const ColorScheme.light(
      primary: UiPalette.navPrimary,
      onPrimary: Colors.white,
      secondary: UiPalette.navActive,
      onSecondary: Colors.white,
      surface: UiPalette.surface,
      onSurface: UiPalette.foreground,
      error: Colors.red,
      onError: Colors.white,
    ).copyWith(
      outline: UiPalette.border,
    );

    return ThemeData(
      useMaterial3: false,
      scaffoldBackgroundColor: UiPalette.navPrimary,
      fontFamily: UiTypography.fontFamily,
      colorScheme: colorScheme,
      dividerColor: UiPalette.border,
      textTheme: UiTypography.textTheme,
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
    );
  }
}
