import 'package:flutter/material.dart';

import '../design_system/palette.dart';

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

class SectionBox extends StatelessWidget {
  const SectionBox({
    super.key,
    required this.title,
    required this.child,
    this.padding = const EdgeInsets.all(8),
  });

  final String title;
  final Widget child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: UiPalette.panelBackground,
        border: Border.all(color: UiPalette.panelBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: UiTypography.sectionTitle),
          const SizedBox(height: UiMetrics.space6),
          child,
        ],
      ),
    );
  }
}

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

class TableHeaderCell extends StatelessWidget {
  const TableHeaderCell(this.text, {super.key, this.flex = 1});

  final String text;
  final int flex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(
        height: UiMetrics.tableHeaderHeight,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: UiPalette.tableHeader,
          border: Border(right: BorderSide(color: Color(0xFFD5E2EB))),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: UiTypography.tableHeader,
        ),
      ),
    );
  }
}

class ZebraRow extends StatelessWidget {
  const ZebraRow({
    super.key,
    required this.values,
    this.rowIndex = 0,
    this.accentFirst = false,
  });

  final List<String> values;
  final int rowIndex;
  final bool accentFirst;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: rowIndex.isEven ? UiPalette.tableRowA : UiPalette.tableRowB,
      child: Row(
        children: values
            .asMap()
            .entries
            .map(
              (MapEntry<int, String> entry) => Expanded(
                child: Container(
                  height: UiMetrics.tableRowHeight,
                  alignment: Alignment.center,
                  child: Text(
                    entry.value,
                    style: UiTypography.dataValue.copyWith(
                      color: accentFirst && entry.key == 0
                          ? Colors.white
                          : UiPalette.foreground,
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
