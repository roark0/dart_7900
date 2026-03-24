import 'package:flutter/material.dart';

import '../style/palette.dart';
import '../widgets/common.dart';

class LjQcPage extends StatelessWidget {
  const LjQcPage({super.key, required this.selectedSideIndex});

  final int selectedSideIndex;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = <Widget>[
      const _SettingsView(),
      const _AnalyseView(),
      const _GraphView(),
      const _ListView(),
    ];

    final int index = selectedSideIndex.clamp(0, pages.length - 1);
    return Padding(
      padding: const EdgeInsets.fromLTRB(6, 6, 6, 2),
      child: pages[index],
    );
  }
}

class _SettingsView extends StatelessWidget {
  const _SettingsView();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const <Widget>[
        _HeaderPanel(
          rows: <List<_FormItem>>[
            <_FormItem>[
              _FormItem('FileNo.', value: '1', width: 118, dropdown: true),
              _FormItem('LotNo.', width: 118),
              _FormItem('Exp.Date', value: '2026-03-18', width: 118),
            ],
            <_FormItem>[
              _FormItem('FileName', width: 118),
              _FormItem('QC Level', value: 'M', width: 118, dropdown: true),
              _FormItem(
                'Mode',
                value: 'Whole blood',
                width: 118,
                dropdown: true,
              ),
            ],
            <_FormItem>[
              _FormItem('Set By', value: 'Engineer', width: 118, muted: true),
              _FormItem(
                'Date Created',
                value: '2026-03-18',
                width: 118,
                muted: true,
              ),
              _FormItem('QCNo.', width: 118),
            ],
          ],
        ),
        SizedBox(height: 8),
        Expanded(
          child: _QcTripletGrid(
            labels: <String>['Item', 'Target', 'Limit'],
            rows: _settingsRows,
            darkColumns: <int>[0, 3, 6],
          ),
        ),
        SizedBox(height: 10),
        _ActionRow(
          actions: <_ActionDef>[
            _ActionDef(label: 'Save'),
            _ActionDef(label: 'Delete'),
          ],
        ),
        SizedBox(height: 8),
      ],
    );
  }
}

class _AnalyseView extends StatelessWidget {
  const _AnalyseView();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const <Widget>[
        _HeaderPanel(
          rows: <List<_FormItem>>[
            <_FormItem>[
              _FormItem('FileNo.', value: '1', width: 80, dropdown: true),
              _FormItem('LotNo.', width: 100),
              _FormItem('QC Level', width: 100),
              _FormItem('Exp.Date', width: 100),
            ],
            <_FormItem>[
              _FormItem('FileName', width: 100),
              _FormItem('Mode', width: 100),
              _FormItem('QCNo.', width: 100),
            ],
          ],
          itemGap: 18,
        ),
        SizedBox(height: 6),
        _QcTripletGrid(
          labels: <String>['Item', 'Result', 'Unit'],
          rows: _analyseRows,
          darkColumns: <int>[0, 3, 6],
        ),
        SizedBox(height: 4),
        Expanded(
          child: Row(
            children: <Widget>[
              Expanded(
                child: _HistogramCard(
                  title: 'WBC',
                  scale: '0       100      200      300      400 fL',
                ),
              ),
              SizedBox(width: 6),
              Expanded(
                child: _HistogramCard(
                  title: 'RBC',
                  scale: '0       50      100      150      200      250 fL',
                ),
              ),
              SizedBox(width: 6),
              Expanded(
                child: _HistogramCard(
                  title: 'PLT',
                  scale: '0          10          20          30 fL',
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 4),
        Align(
          alignment: Alignment.centerLeft,
          child: SoftButton(label: 'Start test', width: 92, height: 44),
        ),
        SizedBox(height: 2),
      ],
    );
  }
}

class _GraphView extends StatelessWidget {
  const _GraphView();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const <Widget>[
        _HeaderPanel(
          rows: <List<_FormItem>>[
            <_FormItem>[
              _FormItem('FileNo.', value: '1', width: 100, dropdown: true),
              _FormItem('LotNo.', width: 164),
              _FormItem('Exp.date', width: 88),
            ],
            <_FormItem>[
              _FormItem('Mode', width: 100),
              _FormItem('Time', width: 164),
              _FormItem('Location/Tot\nal', width: 88),
            ],
          ],
        ),
        SizedBox(height: 8),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(child: _GraphStack()),
              SizedBox(width: 8),
              _StatsColumn(),
              SizedBox(width: 6),
              _NarrowScroller(blockCount: 2),
            ],
          ),
        ),
        SizedBox(height: 8),
        _ActionRow(
          compact: true,
          actions: <_ActionDef>[
            _ActionDef(icon: Icons.arrow_back, muted: true),
            _ActionDef(label: 'ItemSort', muted: true),
            _ActionDef(label: 'Delete', muted: true),
            _ActionDef(icon: Icons.arrow_forward, muted: true),
          ],
        ),
        SizedBox(height: 8),
      ],
    );
  }
}

class _ListView extends StatelessWidget {
  const _ListView();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const <Widget>[
        _HeaderPanel(
          rows: <List<_FormItem>>[
            <_FormItem>[
              _FormItem('FileNo.', value: '1', width: 108, dropdown: true),
              _FormItem('LotNo.', width: 118),
              _FormItem('Mode', width: 118),
            ],
            <_FormItem>[
              _FormItem('level', width: 108),
              _FormItem('Exp.date', width: 118),
            ],
          ],
        ),
        SizedBox(height: 4),
        Expanded(
          child: Row(
            children: <Widget>[
              Expanded(
                child: _QcTripletGrid(
                  labels: <String>['No.', 'Target', 'Limit'],
                  rows: _listRows,
                  darkColumns: <int>[0, 1, 2],
                  rightBlankRows: 4,
                ),
              ),
              SizedBox(width: 4),
              _NarrowScroller(blockCount: 3),
            ],
          ),
        ),
        SizedBox(height: 2),
        _PageNavRow(),
        SizedBox(height: 12),
        _ActionRow(
          compact: true,
          actions: <_ActionDef>[
            _ActionDef(label: 'Delete', muted: true),
            _ActionDef(label: 'Communicate', muted: true),
            _ActionDef(label: 'Export', muted: true),
          ],
        ),
        SizedBox(height: 6),
      ],
    );
  }
}

class _FormItem {
  const _FormItem(
    this.label, {
    this.value = '',
    this.width = 110,
    this.dropdown = false,
    this.muted = false,
  });

  final String label;
  final String value;
  final double width;
  final bool dropdown;
  final bool muted;
}

class _HeaderPanel extends StatelessWidget {
  const _HeaderPanel({required this.rows, this.itemGap = 10});

  final List<List<_FormItem>> rows;
  final double itemGap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFFB8C6D4),
      padding: const EdgeInsets.fromLTRB(8, 6, 8, 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: rows
            .asMap()
            .entries
            .map(
              (MapEntry<int, List<_FormItem>> entry) => Padding(
                padding: EdgeInsets.only(
                  bottom: entry.key == rows.length - 1 ? 0 : 8,
                ),
                child: Wrap(
                  spacing: itemGap,
                  runSpacing: 6,
                  children: entry.value
                      .map(((_FormItem item) => _HeaderField(item: item)))
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
  const _HeaderField({required this.item});

  final _FormItem item;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: item.width + 86,
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 84,
            child: Text(item.label, style: const TextStyle(fontSize: 12)),
          ),
          Container(
            width: item.width,
            height: 30,
            decoration: BoxDecoration(
              color: const Color(0xFFD5D5D5),
              border: Border.all(color: const Color(0xFF8A9BAB)),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Text(
                      item.value,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        color: item.muted ? Colors.grey.shade700 : Colors.black,
                      ),
                    ),
                  ),
                ),
                if (item.dropdown)
                  const Padding(
                    padding: EdgeInsets.only(right: 2),
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      size: 18,
                      color: Color(0xFF6D7A86),
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

class _QcTripletGrid extends StatelessWidget {
  const _QcTripletGrid({
    required this.labels,
    required this.rows,
    this.darkColumns = const <int>[],
    this.rightBlankRows = 0,
  });

  final List<String> labels;
  final List<List<String>> rows;
  final List<int> darkColumns;
  final int rightBlankRows;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFD9E2E9)),
      ),
      child: Column(
        children: <Widget>[
          _GridHeader(labels: labels),
          ...rows.asMap().entries.map((MapEntry<int, List<String>> row) {
            final bool even = row.key.isEven;
            return SizedBox(
              height: 28,
              child: Row(
                children: row.value.asMap().entries.map((
                  MapEntry<int, String> cell,
                ) {
                  final bool dark = darkColumns.contains(cell.key);
                  return Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: dark
                            ? UiPalette.tableHeaderLight
                            : (even
                                  ? UiPalette.tableRowA
                                  : UiPalette.tableRowB),
                        border: Border(
                          right: BorderSide(
                            color: Colors.white.withValues(alpha: 0.42),
                            width: 0.8,
                          ),
                        ),
                      ),
                      child: Text(
                        cell.value,
                        style: TextStyle(
                          color: dark ? Colors.white : Colors.black,
                          fontSize: 28 / 3,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          }),
          if (rightBlankRows > 0)
            Expanded(
              child: Row(
                children: List<Widget>.generate(9, (int index) {
                  final bool dark = darkColumns.contains(index);
                  return Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: dark
                            ? UiPalette.tableHeaderLight
                            : UiPalette.tableRowA,
                        border: Border(
                          right: BorderSide(
                            color: Colors.white.withValues(alpha: 0.4),
                            width: 0.8,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
        ],
      ),
    );
  }
}

class _GridHeader extends StatelessWidget {
  const _GridHeader({required this.labels});

  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 68,
      child: Row(
        children: List<Widget>.generate(3, (int _) {
          return Expanded(
            child: Row(
              children: labels
                  .map(
                    (String label) => Expanded(child: _HeaderCell(text: label)),
                  )
                  .toList(),
            ),
          );
        }),
      ),
    );
  }
}

class _HeaderCell extends StatelessWidget {
  const _HeaderCell({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: UiPalette.tableHeaderLight,
        border: Border(right: BorderSide(color: Color(0xFFE5EDF4), width: 0.8)),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }
}

class _HistogramCard extends StatelessWidget {
  const _HistogramCard({required this.title, required this.scale});

  final String title;
  final String scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF2F4F69)),
      ),
      child: Stack(
        children: <Widget>[
          Container(color: Colors.black),
          Positioned(
            left: 8,
            right: 8,
            bottom: 20,
            child: Container(height: 1, color: Colors.white70),
          ),
          Positioned(
            top: 6,
            left: 0,
            right: 0,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
          Positioned(
            left: 3,
            right: 2,
            bottom: 2,
            child: Text(
              scale,
              style: const TextStyle(color: Colors.white, fontSize: 8.5),
            ),
          ),
        ],
      ),
    );
  }
}

class _GraphStack extends StatelessWidget {
  const _GraphStack();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const <Widget>[
        Expanded(child: _GraphFrame(label: 'WBC')),
        SizedBox(height: 8),
        Expanded(child: _GraphFrame(label: 'RBC')),
      ],
    );
  }
}

class _GraphFrame extends StatelessWidget {
  const _GraphFrame({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFC5D6E6),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 88,
            child: Text(
              label,
              textAlign: TextAlign.left,
              style: const TextStyle(fontSize: 30 / 3),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 4),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: Color(0xFF1E3550), width: 0.9),
                  bottom: BorderSide(color: Color(0xFF1E3550), width: 0.9),
                  left: BorderSide(color: Color(0xFF1A47F0), width: 1),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatsColumn extends StatelessWidget {
  const _StatsColumn();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 88,
      child: Column(
        children: <Widget>[
          SizedBox(height: 4),
          Expanded(child: _StatsBlock()),
          SizedBox(height: 8),
          Expanded(child: _StatsBlock()),
        ],
      ),
    );
  }
}

class _StatsBlock extends StatelessWidget {
  const _StatsBlock();

  @override
  Widget build(BuildContext context) {
    const List<String> labels = <String>['Mean:', 'SD:', 'CV%:', ''];

    return Column(
      children: labels
          .map(
            (String label) => Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(label, style: const TextStyle(fontSize: 12)),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _NarrowScroller extends StatelessWidget {
  const _NarrowScroller({required this.blockCount});

  final int blockCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 32,
      child: Column(
        children: List<Widget>.generate(blockCount, (int index) {
          return Expanded(
            child: Container(
              margin: EdgeInsets.only(bottom: index == blockCount - 1 ? 0 : 1),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[Color(0xFFECECEC), Color(0xFFC9C9C9)],
                ),
                border: Border.all(color: const Color(0xFFBCC4CC)),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Icon(Icons.arrow_drop_up, color: Color(0xFFB8BEC4), size: 28),
                  Icon(
                    Icons.arrow_drop_down,
                    color: Color(0xFFB8BEC4),
                    size: 28,
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _ActionDef {
  const _ActionDef({this.label, this.icon, this.muted = false});

  final String? label;
  final IconData? icon;
  final bool muted;
}

class _ActionRow extends StatelessWidget {
  const _ActionRow({required this.actions, this.compact = false});

  final List<_ActionDef> actions;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: actions
          .map(
            (_ActionDef action) => _ActionButton(
              action: action,
              width: compact ? 112 : 108,
              height: compact ? 42 : 52,
            ),
          )
          .toList(),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.action,
    required this.width,
    required this.height,
  });

  final _ActionDef action;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final bool muted = action.muted;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: muted
              ? const <Color>[Color(0xFFD7E2EC), Color(0xFFA7B8C8)]
              : const <Color>[Color(0xFFC8DCEB), Color(0xFFAAC3D5)],
        ),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF87A7C0)),
      ),
      alignment: Alignment.center,
      child: action.icon != null
          ? Icon(
              action.icon,
              color: muted ? const Color(0xFF9AA9B5) : Colors.black54,
            )
          : Text(
              action.label ?? '',
              style: TextStyle(
                fontSize: 29 / 3,
                color: muted ? const Color(0xFF8798A8) : Colors.black,
              ),
            ),
    );
  }
}

class _PageNavRow extends StatelessWidget {
  const _PageNavRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const <Widget>[
        Expanded(child: _NavCell(icon: Icons.first_page)),
        SizedBox(width: 2),
        Expanded(child: _NavCell(icon: Icons.chevron_left)),
        SizedBox(width: 2),
        Expanded(child: _NavCell(icon: Icons.chevron_right)),
        SizedBox(width: 2),
        Expanded(child: _NavCell(icon: Icons.last_page)),
      ],
    );
  }
}

class _NavCell extends StatelessWidget {
  const _NavCell({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[Color(0xFFECECEC), Color(0xFFBCBCBC)],
        ),
        border: Border.all(color: const Color(0xFF9DAAB7)),
      ),
      child: Icon(icon, color: const Color(0xFFBEC4CA), size: 28),
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
  <String>['Date', '', '', '', '', '', '', '', ''],
  <String>['Time', '', '', '', '', '', '', '', ''],
  <String>['WBC', '', '', '', '', '', '', '', ''],
  <String>['Lym%', '', '', '', '', '', '', '', ''],
  <String>['Mid%', '', '', '', '', '', '', '', ''],
  <String>['Gran%', '', '', '', '', '', '', '', ''],
  <String>['Lym#', '', '', '', '', '', '', '', ''],
  <String>['Mid#', '', '', '', '', '', '', '', ''],
  <String>['Gran#', '', '', '', '', '', '', '', ''],
  <String>['RBC', '', '', '', '', '', '', '', ''],
  <String>['HGB', '', '', '', '', '', '', '', ''],
];
