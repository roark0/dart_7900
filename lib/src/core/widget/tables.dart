import 'package:flutter/material.dart';

import '../theme/theme.dart';

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
