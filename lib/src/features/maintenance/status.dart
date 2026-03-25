import 'package:flutter/material.dart';

import '../../core/theme/theme.dart';
import 'sections.dart';

class MaintenanceStatusPage extends StatelessWidget {
  const MaintenanceStatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaintenanceSurface(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: _StatusPanel(
                    title: 'Pressure',
                    headers: <String>['', 'KPa', 'Range'],
                    rows: <List<String>>[
                      <String>['Vacuum', '', ''],
                    ],
                    firstColumnSelected: true,
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: _StatusPanel(
                    title: 'Sensor',
                    headers: <String>['Device components', 'Status'],
                    rows: <List<String>>[
                      <String>['Waste floater sensor', ''],
                      <String>['Sampling probe horizontal...', ''],
                      <String>['Sampling probe vertical ...', ''],
                      <String>['Sample syringe opticalco...', ''],
                      <String>['Aspiration key', ''],
                    ],
                    firstColumnSelected: true,
                    firstColumnFlex: 3,
                    otherColumnFlex: 2,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          SizedBox(
            height: 190,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: _StatusPanel(
                    title: 'AD',
                    headers: <String>['', 'AD', 'Range'],
                    rows: <List<String>>[
                      <String>['HGB', '', ''],
                    ],
                    firstColumnSelected: true,
                  ),
                ),
                SizedBox(width: 8),
                Expanded(child: SizedBox.shrink()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusPanel extends StatelessWidget {
  const _StatusPanel({
    required this.title,
    required this.headers,
    required this.rows,
    this.firstColumnSelected = false,
    this.firstColumnFlex = 2,
    this.otherColumnFlex = 1,
  });

  final String title;
  final List<String> headers;
  final List<List<String>> rows;
  final bool firstColumnSelected;
  final int firstColumnFlex;
  final int otherColumnFlex;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: UiPalette.border)),
      padding: const EdgeInsets.fromLTRB(4, 4, 4, 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: UiTypography.sectionTitle),
          const SizedBox(height: 4),
          _StatusTable(
            headers: headers,
            rows: rows,
            firstColumnSelected: firstColumnSelected,
            firstColumnFlex: firstColumnFlex,
            otherColumnFlex: otherColumnFlex,
          ),
        ],
      ),
    );
  }
}

class _StatusTable extends StatelessWidget {
  const _StatusTable({
    required this.headers,
    required this.rows,
    required this.firstColumnSelected,
    required this.firstColumnFlex,
    required this.otherColumnFlex,
  });

  final List<String> headers;
  final List<List<String>> rows;
  final bool firstColumnSelected;
  final int firstColumnFlex;
  final int otherColumnFlex;

  @override
  Widget build(BuildContext context) {
    final List<int> flexes = List<int>.generate(
      headers.length,
      (int i) => i == 0 ? firstColumnFlex : otherColumnFlex,
    );

    return Expanded(
      child: Column(
        children: <Widget>[
          _StatusTableRow(values: headers, flexes: flexes, header: true),
          ...rows.asMap().entries.map(
            (MapEntry<int, List<String>> entry) => _StatusTableRow(
              values: entry.value,
              flexes: flexes,
              header: false,
              rowIndex: entry.key,
              firstColumnSelected: firstColumnSelected,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusTableRow extends StatelessWidget {
  const _StatusTableRow({
    required this.values,
    required this.flexes,
    required this.header,
    this.rowIndex = 0,
    this.firstColumnSelected = false,
  });

  final List<String> values;
  final List<int> flexes;
  final bool header;
  final int rowIndex;
  final bool firstColumnSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: header ? 28 : 26,
      child: Row(
        children: List<Widget>.generate(values.length, (int i) {
          final bool firstCell = i == 0;
          final Color bg = header
              ? UiPalette.tableHeader
              : firstCell && firstColumnSelected && rowIndex == 0
              ? UiPalette.tableAccent
              : rowIndex.isEven
              ? UiPalette.tableRowA
              : UiPalette.tableRowB;

          return Expanded(
            flex: flexes[i],
            child: Container(
              decoration: BoxDecoration(
                color: bg,
                border: const Border(
                  right: BorderSide(color: Color(0xFFE9F1F7), width: 0.8),
                  bottom: BorderSide(color: Color(0xFFE9F1F7), width: 0.8),
                ),
              ),
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                values[i],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: header
                    ? UiTypography.tableHeader
                    : UiTypography.fieldLabel.copyWith(
                        fontWeight: firstCell
                            ? FontWeight.w600
                            : FontWeight.w400,
                      ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
