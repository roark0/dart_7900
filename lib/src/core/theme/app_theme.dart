import 'package:flutter/material.dart';

import 'palette.dart';
import 'typography.dart';

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
    ).copyWith(outline: UiPalette.border);

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
