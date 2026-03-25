import 'package:flutter/material.dart';

import '../theme/theme.dart';

class SoftButton extends StatelessWidget {
  const SoftButton({
    super.key,
    required this.label,
    this.width,
    this.height = 54,
    this.selected = false,
  });

  final String label;
  final double? width;
  final double height;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final BoxDecoration decoration = BoxDecoration(
      color: selected
          ? UiPalette.sideNavSelected
          : UiPalette.softButtonBackground,
      borderRadius: BorderRadius.circular(11),
      border: Border.all(color: UiPalette.softButtonBorder),
    );

    return Container(
      width: width,
      height: height,
      decoration: decoration,
      alignment: Alignment.center,
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: UiTypography.bottomActionLabel.copyWith(height: 1.0),
      ),
    );
  }
}
