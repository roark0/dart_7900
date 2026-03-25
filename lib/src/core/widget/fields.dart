import 'package:flutter/material.dart';

import '../theme/theme.dart';

class FieldLabel extends StatelessWidget {
  const FieldLabel(this.label, {super.key, this.width = 90});

  final String label;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Text(label, style: UiTypography.fieldLabel),
    );
  }
}

class InputBox extends StatelessWidget {
  const InputBox({
    super.key,
    this.value = '',
    this.width = 110,
    this.height = UiMetrics.formFieldHeight,
    this.grayText = false,
    this.center = false,
  });

  final String value;
  final double width;
  final double height;
  final bool grayText;
  final bool center;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: UiMetrics.space8),
      alignment: center ? Alignment.center : Alignment.centerLeft,
      decoration: BoxDecoration(
        color: UiPalette.input,
        border: Border.all(color: UiPalette.inputBorder),
      ),
      child: Text(
        value,
        style: UiTypography.inputValue.copyWith(
          color: grayText ? Colors.grey.shade700 : UiPalette.foreground,
        ),
      ),
    );
  }
}
