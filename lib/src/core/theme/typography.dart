import 'package:flutter/material.dart';

import 'palette.dart';

class UiTypography {
  UiTypography._();

  static const String fontFamily = 'Arial';

  static const double navLabelSize = 13;
  static const double tableHeaderSize = 12;
  static const double dataValueSize = 11;
  static const double statusSize = 13;
  static const double sectionTitleSize = 14;
  static const double buttonLabelSize = 14;
  static const double bottomActionLabelSize = 16;
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

  static const TextStyle bottomActionLabel = TextStyle(
    fontFamily: fontFamily,
    fontSize: bottomActionLabelSize,
    fontWeight: buttonLabelWeight,
    color: UiPalette.foreground,
  );

  static const TextStyle status = TextStyle(
    fontFamily: fontFamily,
    fontSize: statusSize,
    color: Colors.white,
  );

  static const TextStyle chartScale = TextStyle(
    fontFamily: fontFamily,
    fontSize: 9.5,
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
