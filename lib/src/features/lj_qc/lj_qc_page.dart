import 'package:flutter/material.dart';

import '../../core/widget/widget.dart';
import '../../core/theme/theme.dart';

class LjQcPage extends StatelessWidget {
  const LjQcPage({super.key, required this.selectedSideIndex});

  final int selectedSideIndex;

  @override
  Widget build(BuildContext context) {
    final _LjQcState state = _LjQcState
        .values[selectedSideIndex.clamp(0, _LjQcState.values.length - 1)];
    return Padding(
      padding: const EdgeInsets.fromLTRB(6, 6, 6, 2),
      child: _LjQcPanel(state: state),
    );
  }
}

enum _LjQcState { settings, analyse, graph, list }

class _LjQcPanel extends StatelessWidget {
  const _LjQcPanel({required this.state});

  final _LjQcState state;

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case _LjQcState.settings:
        return const _SettingsStateView();
      case _LjQcState.analyse:
        return const _AnalyseStateView();
      case _LjQcState.graph:
        return const _GraphStateView();
      case _LjQcState.list:
        return const _ListStateView();
    }
  }
}

class _SettingsStateView extends StatelessWidget {
  const _SettingsStateView();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const <Widget>[
        _HeaderGrid(
          rows: <List<_FieldSpec>>[
            <_FieldSpec>[
              _FieldSpec('FileNo.', value: '1', control: _FieldControl.select),
              _FieldSpec('LotNo.'),
              _FieldSpec(
                'Exp.Date',
                value: '2026-03-18',
                control: _FieldControl.select,
              ),
            ],
            <_FieldSpec>[
              _FieldSpec('FileName'),
              _FieldSpec('QC Level', value: 'M', control: _FieldControl.select),
              _FieldSpec(
                'Mode',
                value: 'Whole blood',
                control: _FieldControl.select,
              ),
            ],
            <_FieldSpec>[
              _FieldSpec(
                'Set By',
                value: 'Engineer',
                control: _FieldControl.readonly,
              ),
              _FieldSpec(
                'Date Created',
                value: '2026-03-18',
                control: _FieldControl.readonly,
                labelWidth: 92,
              ),
              _FieldSpec('QCNo.', control: _FieldControl.readonly),
            ],
          ],
        ),
        SizedBox(height: 8),
        Expanded(
          child: _TripletTable(
            headers: <String>['Item', 'Target', 'Limit'],
            rows: _settingsRows,
            accentColumns: <int>{0, 3, 6},
            fillTrailingSpace: true,
          ),
        ),
        SizedBox(height: 10),
        _ActionBar(
          alignment: MainAxisAlignment.spaceEvenly,
          items: <_ActionSpec>[
            _ActionSpec('Save', width: 108),
            _ActionSpec('Delete', width: 108),
          ],
        ),
        SizedBox(height: 6),
      ],
    );
  }
}

class _AnalyseStateView extends StatelessWidget {
  const _AnalyseStateView();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const <Widget>[
        _HeaderGrid(
          rows: <List<_FieldSpec>>[
            <_FieldSpec>[
              _FieldSpec('FileNo.', value: '1', control: _FieldControl.select),
              _FieldSpec('LotNo.', control: _FieldControl.readonly),
              _FieldSpec('QC Level', control: _FieldControl.readonly),
            ],
            <_FieldSpec>[
              _FieldSpec('Exp.Date', control: _FieldControl.readonly),
              _FieldSpec('FileName', control: _FieldControl.readonly),
              _FieldSpec('Mode', control: _FieldControl.readonly),
            ],
            <_FieldSpec>[
              _FieldSpec('QCNo.', control: _FieldControl.readonly),
              _FieldSpec(''),
              _FieldSpec(''),
            ],
          ],
        ),
        SizedBox(height: 6),
        _TripletTable(
          headers: <String>['Item', 'Result', 'Unit'],
          rows: _analyseRows,
          accentColumns: <int>{},
        ),
        SizedBox(height: 4),
        Expanded(
          child: Row(
            children: <Widget>[
              Expanded(
                child: _HistogramCard(
                  title: 'WBC',
                  scaleLabels: <String>['0', '100', '200', '300', '400'],
                ),
              ),
              SizedBox(width: 6),
              Expanded(
                child: _HistogramCard(
                  title: 'RBC',
                  scaleLabels: <String>['0', '50', '100', '150', '200', '250'],
                ),
              ),
              SizedBox(width: 6),
              Expanded(
                child: _HistogramCard(
                  title: 'PLT',
                  scaleLabels: <String>['0', '10', '20', '30'],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 4),
        Align(
          alignment: Alignment.centerLeft,
          child: SoftButton(label: 'Start test', width: 92, height: 36),
        ),
        SizedBox(height: 2),
      ],
    );
  }
}

class _GraphStateView extends StatelessWidget {
  const _GraphStateView();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const <Widget>[
        _HeaderGrid(
          rows: <List<_FieldSpec>>[
            <_FieldSpec>[
              _FieldSpec('FileNo.', value: '1', control: _FieldControl.select),
              _FieldSpec('LotNo.', control: _FieldControl.readonly, width: 162),
              _FieldSpec(
                'Exp.date',
                control: _FieldControl.readonly,
                width: 96,
              ),
            ],
            <_FieldSpec>[
              _FieldSpec('Mode', control: _FieldControl.readonly),
              _FieldSpec('Time', control: _FieldControl.readonly, width: 162),
              _FieldSpec(
                'Location/Total',
                control: _FieldControl.readonly,
                width: 96,
              ),
            ],
          ],
        ),
        SizedBox(height: 8),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(child: _GraphPanelStack()),
              SizedBox(width: 8),
              _GraphStatsColumn(),
              SizedBox(width: 6),
              _SlimScrollRail(),
            ],
          ),
        ),
        SizedBox(height: 8),
        _ActionBar(
          alignment: MainAxisAlignment.center,
          compact: true,
          items: <_ActionSpec>[
            _ActionSpec('←', width: 48),
            _ActionSpec('ItemSort', width: 86, disabled: true),
            _ActionSpec('Delete', width: 78, disabled: true),
            _ActionSpec('→', width: 48),
          ],
        ),
        SizedBox(height: 6),
      ],
    );
  }
}

class _ListStateView extends StatelessWidget {
  const _ListStateView();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const <Widget>[
        _HeaderGrid(
          rows: <List<_FieldSpec>>[
            <_FieldSpec>[
              _FieldSpec('FileNo.', value: '1', control: _FieldControl.select),
              _FieldSpec('LotNo.', control: _FieldControl.readonly),
              _FieldSpec('Mode', control: _FieldControl.readonly),
            ],
            <_FieldSpec>[
              _FieldSpec('level', control: _FieldControl.readonly),
              _FieldSpec('Exp.date', control: _FieldControl.readonly),
              _FieldSpec(''),
            ],
          ],
        ),
        SizedBox(height: 8),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: _MatrixTable(
                  headers: <String>['No.', 'Target', 'Limit', '', '', '', ''],
                  rows: _listRows,
                ),
              ),
              SizedBox(width: 6),
              _SlimScrollRail(),
            ],
          ),
        ),
        SizedBox(height: 8),
        _ActionBar(
          alignment: MainAxisAlignment.spaceEvenly,
          items: <_ActionSpec>[
            _ActionSpec('Delete', width: 92, disabled: true),
            _ActionSpec('Communicate', width: 118, disabled: true),
            _ActionSpec('Export', width: 92, disabled: true),
          ],
        ),
        SizedBox(height: 4),
        _PagerRow(),
      ],
    );
  }
}

enum _FieldControl { input, readonly, select }

class _FieldSpec {
  const _FieldSpec(
    this.label, {
    this.value = '',
    this.control = _FieldControl.input,
    this.width = 120,
    this.labelWidth = 78,
  });

  final String label;
  final String value;
  final _FieldControl control;
  final double width;
  final double labelWidth;
}

class _HeaderGrid extends StatelessWidget {
  const _HeaderGrid({required this.rows});

  final List<List<_FieldSpec>> rows;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 6, 8, 8),
      color: UiPalette.panelBackground,
      child: Column(
        children: rows
            .map(
              (List<_FieldSpec> row) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: row
                      .map(
                        (_FieldSpec spec) => Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: _HeaderField(spec: spec),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _HeaderField extends StatelessWidget {
  const _HeaderField({required this.spec});

  final _FieldSpec spec;

  @override
  Widget build(BuildContext context) {
    if (spec.label.isEmpty && spec.value.isEmpty) {
      return const SizedBox(height: UiMetrics.formFieldHeight);
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          width: spec.labelWidth,
          child: Text(spec.label, style: UiTypography.fieldLabel),
        ),
        _FieldBox(spec: spec),
      ],
    );
  }
}

class _FieldBox extends StatelessWidget {
  const _FieldBox({required this.spec});

  final _FieldSpec spec;

  @override
  Widget build(BuildContext context) {
    final bool readonly = spec.control == _FieldControl.readonly;
    final bool select = spec.control == _FieldControl.select;
    return Container(
      width: spec.width,
      height: UiMetrics.formFieldHeight,
      padding: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: readonly ? UiPalette.surfaceMuted : UiPalette.surface,
        border: Border.all(color: UiPalette.inputBorder),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              spec.value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: UiTypography.inputValue.copyWith(
                color: readonly
                    ? UiPalette.disabledForeground
                    : UiPalette.foreground,
              ),
            ),
          ),
          if (select)
            const Icon(
              Icons.arrow_drop_down,
              size: 18,
              color: UiPalette.foreground,
            ),
        ],
      ),
    );
  }
}

class _TripletTable extends StatelessWidget {
  const _TripletTable({
    required this.headers,
    required this.rows,
    required this.accentColumns,
    this.fillTrailingSpace = false,
  });

  final List<String> headers;
  final List<List<String>> rows;
  final Set<int> accentColumns;
  final bool fillTrailingSpace;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: UiPalette.panelBackground,
        border: Border.all(color: UiPalette.panelBorder),
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: List<Widget>.generate(
              9,
              (int index) => Expanded(
                child: _TableHeaderCell(headers[index % headers.length]),
              ),
            ),
          ),
          ...rows.asMap().entries.map(
            (MapEntry<int, List<String>> entry) => Expanded(
              child: Row(
                children: entry.value.asMap().entries.map((
                  MapEntry<int, String> cell,
                ) {
                  final Color background =
                      cell.key == 0 && cell.value.isEmpty && fillTrailingSpace
                      ? Colors.transparent
                      : accentColumns.contains(cell.key)
                      ? UiPalette.tableHeaderLight
                      : (entry.key.isEven
                            ? UiPalette.surface
                            : UiPalette.tableRowLight);
                  final Color foreground = accentColumns.contains(cell.key)
                      ? Colors.white
                      : UiPalette.foreground;
                  return Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: background,
                        border: Border(
                          right: BorderSide(
                            color: UiPalette.panelBorder.withValues(alpha: 0.6),
                          ),
                          bottom: BorderSide(
                            color: UiPalette.panelBorder.withValues(alpha: 0.7),
                          ),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        cell.value,
                        style: UiTypography.dataValue.copyWith(
                          color: foreground,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MatrixTable extends StatelessWidget {
  const _MatrixTable({required this.headers, required this.rows});

  final List<String> headers;
  final List<List<String>> rows;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: UiPalette.panelBackground,
        border: Border.all(color: UiPalette.panelBorder),
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: headers
                .map(
                  (String text) => Expanded(
                    child: Container(
                      height: 38,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: text.isEmpty
                            ? UiPalette.panelBackground
                            : UiPalette.tableHeaderLight,
                        border: Border(
                          right: BorderSide(
                            color: UiPalette.panelBorder.withValues(alpha: 0.7),
                          ),
                        ),
                      ),
                      child: text.isEmpty
                          ? const SizedBox.shrink()
                          : Text(text, style: UiTypography.tableHeader),
                    ),
                  ),
                )
                .toList(),
          ),
          ...rows.asMap().entries.map(
            (MapEntry<int, List<String>> entry) => Expanded(
              child: Row(
                children: entry.value.asMap().entries.map((
                  MapEntry<int, String> cell,
                ) {
                  final bool firstColumn = cell.key == 0;
                  return Expanded(
                    child: Container(
                      alignment: firstColumn
                          ? Alignment.centerLeft
                          : Alignment.center,
                      padding: firstColumn
                          ? const EdgeInsets.only(left: 12)
                          : EdgeInsets.zero,
                      decoration: BoxDecoration(
                        color: entry.key.isEven
                            ? UiPalette.surface
                            : UiPalette.tableRowLight,
                        border: Border(
                          right: BorderSide(
                            color: UiPalette.panelBorder.withValues(alpha: 0.6),
                          ),
                          bottom: BorderSide(
                            color: UiPalette.panelBorder.withValues(alpha: 0.7),
                          ),
                        ),
                      ),
                      child: Text(cell.value, style: UiTypography.dataValue),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TableHeaderCell extends StatelessWidget {
  const _TableHeaderCell(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: UiPalette.tableHeaderLight,
        border: Border(
          right: BorderSide(
            color: UiPalette.panelBorder.withValues(alpha: 0.7),
          ),
        ),
      ),
      child: Text(label, style: UiTypography.tableHeader),
    );
  }
}

class _HistogramCard extends StatelessWidget {
  const _HistogramCard({required this.title, required this.scaleLabels});

  final String title;
  final List<String> scaleLabels;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: UiPalette.chartBackground,
        border: Border.all(color: UiPalette.chartBorder),
      ),
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.topRight,
            child: Text(title, style: UiTypography.tableHeader),
          ),
          const SizedBox(height: 2),
          Expanded(
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 14,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List<Widget>.generate(
                      4,
                      (int index) =>
                          Container(width: 4, height: 1, color: Colors.white),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Stack(
                          children: <Widget>[
                            Positioned.fill(
                              child: CustomPaint(
                                painter: _HistogramGridPainter(),
                              ),
                            ),
                            Positioned(
                              left: 0,
                              right: 0,
                              bottom: 0,
                              child: Container(height: 1, color: Colors.white),
                            ),
                            Positioned(
                              top: 0,
                              bottom: 0,
                              left: 0,
                              child: Container(width: 1, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: scaleLabels
                            .map(
                              (String value) =>
                                  Text(value, style: UiTypography.chartScale),
                            )
                            .toList(),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'fL',
                          style: UiTypography.chartScale.copyWith(
                            color: const Color(0xFFFFA3A3),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HistogramGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.22)
      ..strokeWidth = 1;
    final double rowGap = size.height / 4;
    for (int i = 1; i < 4; i++) {
      final double dy = rowGap * i;
      canvas.drawLine(Offset(0, dy), Offset(size.width, dy), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _GraphPanelStack extends StatelessWidget {
  const _GraphPanelStack();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const <Widget>[
        Expanded(child: _GraphFrame(title: 'WBC')),
        SizedBox(height: 8),
        Expanded(child: _GraphFrame(title: 'RBC')),
      ],
    );
  }
}

class _GraphFrame extends StatelessWidget {
  const _GraphFrame({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: UiPalette.chartBackground,
        border: Border.all(color: UiPalette.chartBorder),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Text(title, style: UiTypography.tableHeader),
          ),
          const SizedBox(height: 6),
          Expanded(
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: CustomPaint(painter: _HistogramGridPainter()),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(height: 1, color: Colors.white),
                ),
                Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  child: Container(width: 1, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GraphStatsColumn extends StatelessWidget {
  const _GraphStatsColumn();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 118,
      child: Column(
        children: const <Widget>[
          Expanded(
            child: _StatsBlock(
              title: 'WBC',
              rows: <String>['Mean', 'SD', 'CV%', ''],
            ),
          ),
          SizedBox(height: 8),
          Expanded(
            child: _StatsBlock(
              title: 'RBC',
              rows: <String>['Mean', 'SD', 'CV%', ''],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatsBlock extends StatelessWidget {
  const _StatsBlock({required this.title, required this.rows});

  final String title;
  final List<String> rows;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: UiPalette.panelBackground,
        border: Border.all(color: UiPalette.panelBorder),
      ),
      child: Column(
        children: <Widget>[
          Container(
            height: 36,
            alignment: Alignment.center,
            color: UiPalette.tableHeaderLight,
            child: Text(title, style: UiTypography.tableHeader),
          ),
          ...rows.map(
            (String text) => Expanded(
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: UiPalette.surface,
                  border: Border(
                    top: BorderSide(
                      color: UiPalette.panelBorder.withValues(alpha: 0.7),
                    ),
                  ),
                ),
                child: Text(text, style: UiTypography.dataValue),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SlimScrollRail extends StatelessWidget {
  const _SlimScrollRail();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      decoration: BoxDecoration(
        color: UiPalette.surfaceMuted,
        border: Border.all(color: UiPalette.panelBorder),
      ),
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          margin: const EdgeInsets.only(top: 22),
          width: 6,
          height: 58,
          decoration: BoxDecoration(
            color: UiPalette.softButtonBorder,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
      ),
    );
  }
}

class _ActionSpec {
  const _ActionSpec(this.label, {this.width, this.disabled = false});

  final String label;
  final double? width;
  final bool disabled;
}

class _ActionBar extends StatelessWidget {
  const _ActionBar({
    required this.items,
    required this.alignment,
    this.compact = false,
  });

  final List<_ActionSpec> items;
  final MainAxisAlignment alignment;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final double height = compact ? 36 : 42;
    return Row(
      mainAxisAlignment: alignment,
      children: items
          .map(
            (_ActionSpec item) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Opacity(
                opacity: item.disabled ? 0.72 : 1,
                child: SoftButton(
                  label: item.label,
                  width: item.width,
                  height: height,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _PagerRow extends StatelessWidget {
  const _PagerRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const <Widget>[
        Text('1/15', style: UiTypography.dataValue),
        SizedBox(width: 14),
        SoftButton(label: '←', width: 40, height: 30),
        SizedBox(width: 8),
        SoftButton(label: '→', width: 40, height: 30),
      ],
    );
  }
}

const List<List<String>> _settingsRows = <List<String>>[
  <String>['WBC', '', '', 'RBC', '', '', 'PLT', '', ''],
  <String>['Lym%', '', '', 'HGB', '', '', 'MPV', '', ''],
  <String>['Mid%', '', '', 'HCT', '', '', 'PDW-CV', '', ''],
  <String>['Gran%', '', '', 'MCV', '', '', 'PDW-SD', '', ''],
  <String>['Lym#', '', '', 'MCH', '', '', 'PCT', '', ''],
  <String>['Mid#', '', '', 'MCHC', '', '', 'P-LCR', '', ''],
  <String>['Gran#', '', '', 'RDW-CV', '', '', 'P-LCC', '', ''],
  <String>['', '', '', 'RDW-SD', '', '', '', '', ''],
];

const List<List<String>> _analyseRows = <List<String>>[
  <String>['WBC', '', '', 'RBC', '', '', 'PLT', '', ''],
  <String>['Lym%', '', '', 'HGB', '', '', 'MPV', '', ''],
  <String>['Mid%', '', '', 'HCT', '', '', 'PDW-CV', '', ''],
  <String>['Gran%', '', '', 'MCV', '', '', 'PDW-SD', '', ''],
  <String>['Lym#', '', '', 'MCH', '', '', 'PCT', '', ''],
  <String>['Mid#', '', '', 'MCHC', '', '', 'P-LCR', '', ''],
  <String>['Gran#', '', '', 'RDW-CV', '', '', 'P-LCC', '', ''],
  <String>['', '', '', 'RDW-SD', '', '', '', '', ''],
];

const List<List<String>> _listRows = <List<String>>[
  <String>['Date', '', '', '', '', '', ''],
  <String>['Time', '', '', '', '', '', ''],
  <String>['WBC', '', '', '', '', '', ''],
  <String>['Lym%', '', '', '', '', '', ''],
  <String>['Mid%', '', '', '', '', '', ''],
  <String>['Gran%', '', '', '', '', '', ''],
  <String>['Lym#', '', '', '', '', '', ''],
  <String>['Mid#', '', '', '', '', '', ''],
  <String>['Gran#', '', '', '', '', '', ''],
  <String>['RBC', '', '', '', '', '', ''],
  <String>['HGB', '', '', '', '', '', ''],
];
