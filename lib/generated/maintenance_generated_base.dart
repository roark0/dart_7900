import 'package:flutter/material.dart';

import '../src/model/navigation.dart';
import '../src/widgets/instrument_scaffold.dart';

const _MaintenanceDslTheme _maintenanceTheme = _MaintenanceDslTheme();

abstract class MaintenanceGeneratedPage extends StatelessWidget {
  const MaintenanceGeneratedPage({super.key});

  String get clockText;
  String get selectedTab;
  Widget buildPageBody(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return InstrumentScaffold(
      selectedModule: TopModule.maintenance,
      onModuleChanged: (_) {},
      clockText: clockText,
      sideMenu: maintenanceSideMenu,
      selectedSideIndex: 0,
      onSideChanged: (_) {},
      content: Container(
        color: _maintenanceTheme.bg,
        padding: const EdgeInsets.fromLTRB(4, 4, 8, 2),
        child: Column(
          children: <Widget>[
            _MaintenanceTabRow(selected: selectedTab),
            const SizedBox(height: 10),
            Expanded(child: buildPageBody(context)),
          ],
        ),
      ),
    );
  }
}

class MaintenanceButtonAction {
  const MaintenanceButtonAction(this.text, {this.width});

  final String text;
  final double? width;
}

class MaintenanceActionGrid extends StatelessWidget {
  const MaintenanceActionGrid({
    super.key,
    required this.items,
    this.columns = 2,
    this.mainAxisSpacing = 48,
    this.crossAxisSpacing = 84,
    this.topPadding = 84,
  });

  final List<MaintenanceButtonAction> items;
  final int columns;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final double topPadding;

  @override
  Widget build(BuildContext context) {
    final List<List<MaintenanceButtonAction>> rows =
        <List<MaintenanceButtonAction>>[];
    for (int index = 0; index < items.length; index += columns) {
      rows.add(items.skip(index).take(columns).toList());
    }

    return Padding(
      padding: EdgeInsets.only(top: topPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: rows
            .map(
              (List<MaintenanceButtonAction> row) => Padding(
                padding: EdgeInsets.only(
                  bottom: row == rows.last ? 0 : mainAxisSpacing,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: row
                      .map(
                        (MaintenanceButtonAction item) => Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: crossAxisSpacing / 2,
                          ),
                          child: _ActionButtonCard(
                            label: item.text,
                            width:
                                item.width ??
                                _maintenanceTheme.actionButtonWidth,
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

class MaintenanceReagentPanel extends StatelessWidget {
  const MaintenanceReagentPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _maintenanceTheme.panel,
        border: Border.all(
          color: _maintenanceTheme.border,
          width: _maintenanceTheme.borderWidth,
        ),
      ),
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Replace Reagents', style: _maintenanceTheme.sectionTitleStyle),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              _ActionButtonCard(label: 'All reagents', width: 125, height: 48),
              SizedBox(width: 62),
              _ActionButtonCard(label: 'Diluent', width: 125, height: 48),
              SizedBox(width: 62),
              _ActionButtonCard(label: 'Lyse', width: 125, height: 48),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            'Reagent information',
            style: _maintenanceTheme.sectionTitleStyle,
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: _maintenanceTheme.border,
                  width: _maintenanceTheme.borderWidth,
                ),
              ),
              child: Column(
                children: <Widget>[
                  const _MatrixHeaderRow(
                    cells: <_HeaderCellData>[
                      _HeaderCellData('Type', flex: 16),
                      _HeaderCellData('Lot No.', flex: 14),
                      _HeaderCellData('Remaining\nvolume', flex: 18),
                      _HeaderCellData('%', flex: 10),
                      _HeaderCellData('Original\ncapacity', flex: 18),
                      _HeaderCellData('Expired\ndate', flex: 18),
                    ],
                  ),
                  const _MatrixDataRow(
                    values: <String>[
                      'Diluent',
                      'Dil',
                      '1000',
                      '100.00',
                      '1000',
                      '2122-06-01',
                    ],
                    rowIndex: 0,
                    accentFirst: true,
                  ),
                  const _MatrixDataRow(
                    values: <String>[
                      'Lyse',
                      'Lys',
                      '100',
                      '100.00',
                      '100',
                      '2122-06-01',
                    ],
                    rowIndex: 1,
                    accentFirst: true,
                  ),
                  Expanded(child: Container(color: _maintenanceTheme.panel)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MaintenanceTabRow extends StatelessWidget {
  const _MaintenanceTabRow({required this.selected});

  final String selected;

  static const List<String> _tabs = <String>[
    'Replace Reagents',
    'Clean',
    'Maintenance',
    'Whole machine maintenance',
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: _tabs
          .map(
            (String label) => Expanded(
              child: Container(
                height: _maintenanceTheme.subTabHeight,
                margin: const EdgeInsets.only(right: 6),
                decoration: BoxDecoration(
                  color: label == selected
                      ? _maintenanceTheme.header
                      : _maintenanceTheme.accent,
                  border: Border.all(
                    color: _maintenanceTheme.border,
                    width: _maintenanceTheme.borderWidth,
                  ),
                  borderRadius: BorderRadius.circular(
                    _maintenanceTheme.cornerRadius,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  label == 'Whole machine maintenance'
                      ? 'Whole machine\nmaintenance'
                      : label,
                  textAlign: TextAlign.center,
                  style: label == selected
                      ? _maintenanceTheme.tabSelectedStyle
                      : _maintenanceTheme.tabStyle,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _ActionButtonCard extends StatelessWidget {
  const _ActionButtonCard({required this.label, this.width, this.height});

  final String label;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? _maintenanceTheme.actionButtonWidth,
      height: height ?? _maintenanceTheme.actionButtonHeight,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[Color(0xFFF5FBFF), Color(0xFFB9D4EB)],
        ),
        borderRadius: BorderRadius.circular(_maintenanceTheme.cornerRadius),
        border: Border.all(
          color: _maintenanceTheme.border,
          width: _maintenanceTheme.borderWidth,
        ),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: _maintenanceTheme.buttonStyle,
      ),
    );
  }
}

class _MatrixHeaderRow extends StatelessWidget {
  const _MatrixHeaderRow({required this.cells});

  final List<_HeaderCellData> cells;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _maintenanceTheme.header,
      child: Row(
        children: cells
            .map(
              (_HeaderCellData cell) => Expanded(
                flex: cell.flex,
                child: Container(
                  height: 33,
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(
                        color: Colors.white.withValues(alpha: 0.85),
                      ),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    cell.label,
                    textAlign: TextAlign.center,
                    style: _maintenanceTheme.tableHeaderStyle,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _MatrixDataRow extends StatelessWidget {
  const _MatrixDataRow({
    required this.values,
    required this.rowIndex,
    this.accentFirst = false,
  });

  final List<String> values;
  final int rowIndex;
  final bool accentFirst;

  @override
  Widget build(BuildContext context) {
    final Color background = rowIndex.isEven
        ? const Color(0xFFD7E5EF)
        : const Color(0xFFC9DCE9);

    return Container(
      color: background,
      child: Row(
        children: values
            .asMap()
            .entries
            .map(
              (MapEntry<int, String> entry) => Expanded(
                child: Container(
                  height: 25,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: accentFirst && entry.key == 0
                        ? _maintenanceTheme.header
                        : null,
                    border: Border(
                      right: BorderSide(
                        color: Colors.white.withValues(alpha: 0.45),
                      ),
                      bottom: BorderSide(
                        color: Colors.white.withValues(alpha: 0.45),
                      ),
                    ),
                  ),
                  child: Text(
                    entry.value,
                    textAlign: TextAlign.center,
                    style: accentFirst && entry.key == 0
                        ? _maintenanceTheme.tableHeaderStyle
                        : _maintenanceTheme.tableCellStyle,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _HeaderCellData {
  const _HeaderCellData(this.label, {this.flex = 1});

  final String label;
  final int flex;
}

class _MaintenanceDslTheme {
  const _MaintenanceDslTheme();

  final Color bg = const Color(0xFFC6D5E3);
  final Color topBar = const Color(0xFF2F6F9E);
  final Color sideBar = const Color(0xFF5E89B0);
  final Color panel = const Color(0xFFC8D6E4);
  final Color header = const Color(0xFF3E7AAA);
  final Color text = const Color(0xFF000000);
  final Color textOnDark = const Color(0xFFFFFFFF);
  final Color accent = const Color(0xFFDCE8F2);
  final Color border = const Color(0xFF8FAECC);
  final double subTabHeight = 42;
  final double actionButtonWidth = 126;
  final double actionButtonHeight = 80;
  final double cornerRadius = 12;
  final double borderWidth = 1;

  TextStyle get tabStyle => const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Color(0xFF000000),
    height: 1.0,
  );

  TextStyle get tabSelectedStyle => const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Color(0xFFFFFFFF),
    height: 1.0,
  );

  TextStyle get sectionTitleStyle => const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Color(0xFF000000),
    height: 1.0,
  );

  TextStyle get buttonStyle => const TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: Color(0xFF000000),
    height: 1.15,
  );

  TextStyle get tableHeaderStyle => const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: Color(0xFFFFFFFF),
    height: 1.0,
  );

  TextStyle get tableCellStyle => const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Color(0xFF000000),
    height: 1.0,
  );
}
