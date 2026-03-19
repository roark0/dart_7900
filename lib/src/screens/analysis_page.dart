import 'package:flutter/material.dart';

import '../style/palette.dart';
import '../widgets/common.dart';

class AnalysisPage extends StatelessWidget {
  const AnalysisPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _TopInfo(),
          const SizedBox(height: 6),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: <Widget>[
                      const _TripleResultTable(),
                      const SizedBox(height: 8),
                      Expanded(
                        child: Row(
                          children: const <Widget>[
                            Expanded(child: _ChartBox(title: 'WBC', scale: '0      100      200      300      400 fL')),
                            SizedBox(width: 2),
                            Expanded(child: _ChartBox(title: 'RBC', scale: '0       50      100      150      200      250 fL')),
                            SizedBox(width: 2),
                            Expanded(child: _ChartBox(title: 'PLT', scale: '0          10          20          30 fL')),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                const _FlagPanel(),
              ],
            ),
          ),
          const SizedBox(height: 8),
          const _BottomActions(),
        ],
      ),
    );
  }
}

class _TopInfo extends StatelessWidget {
  const _TopInfo();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            FieldLabel('Sample No.', width: 196),
            FieldLabel('Name', width: 256),
            FieldLabel('Gender', width: 120),
          ],
        ),
        SizedBox(height: 4),
        Row(
          children: <Widget>[
            FieldLabel('Inspection time', width: 196),
            FieldLabel('Mode', width: 76),
            Text('Whole blood', style: TextStyle(fontSize: 32 / 3)),
            Spacer(),
            FieldLabel('Age', width: 120),
          ],
        ),
      ],
    );
  }
}

class _TripleResultTable extends StatelessWidget {
  const _TripleResultTable();

  @override
  Widget build(BuildContext context) {
    const List<List<String>> rows = <List<String>>[
      <String>['WBC', '', '', 'RBC', '', '', 'PLT', '', ''],
      <String>['Lym%', '', '', 'HGB', '', '', 'MPV', '', ''],
      <String>['Mid%', '', '', 'HCT', '', '', 'PDW-CV', '', ''],
      <String>['Gran%', '', '', 'MCV', '', '', 'PDW-SD', '', ''],
      <String>['Lym#', '', '', 'MCH', '', '', 'PCT', '', ''],
      <String>['Mid#', '', '', 'MCHC', '', '', 'P-LCR', '', ''],
      <String>['Gran#', '', '', 'RDW-CV', '', '', 'P-LCC', '', ''],
      <String>['', '', '', 'RDW-SD', '', '', '', '', ''],
    ];

    return Column(
      children: <Widget>[
        Container(
          color: UiPalette.tableHeader,
          child: const Row(
            children: <Widget>[
              TableHeaderCell('Item'),
              TableHeaderCell('Result'),
              TableHeaderCell('Unit'),
              TableHeaderCell('Item'),
              TableHeaderCell('Result'),
              TableHeaderCell('Unit'),
              TableHeaderCell('Item'),
              TableHeaderCell('Result'),
              TableHeaderCell('Unit'),
            ],
          ),
        ),
        ...rows.asMap().entries.map((MapEntry<int, List<String>> entry) {
          return ZebraRow(values: entry.value, rowIndex: entry.key);
        }),
      ],
    );
  }
}

class _FlagPanel extends StatelessWidget {
  const _FlagPanel();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 148,
      child: Column(
        children: <Widget>[
          _FlagSlot(title: 'WBC Flag'),
          const SizedBox(height: 4),
          _FlagSlot(title: 'RBC Flag'),
          const SizedBox(height: 4),
          _FlagSlot(title: 'PLT Flag'),
        ],
      ),
    );
  }
}

class _FlagSlot extends StatelessWidget {
  const _FlagSlot({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: <Widget>[
          Container(
            height: 34,
            color: UiPalette.tableHeaderLight,
            alignment: Alignment.center,
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
            ),
          ),
          Expanded(
            child: Container(
              color: const Color(0xFFB8C8D9),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChartBox extends StatelessWidget {
  const _ChartBox({required this.title, required this.scale});

  final String title;
  final String scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: const Color(0xFF2F4F69))),
      child: Stack(
        children: <Widget>[
          Container(color: Colors.black),
          Positioned(
            left: 5,
            right: 5,
            bottom: 18,
            child: Container(height: 1, color: Colors.white70),
          ),
          Positioned(
            top: 8,
            left: 0,
            right: 0,
            child: Text(title, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 20 / 2)),
          ),
          Positioned(
            left: 2,
            right: 2,
            bottom: 2,
            child: Text(scale, style: const TextStyle(color: Colors.white, fontSize: 8.5)),
          ),
        ],
      ),
    );
  }
}

class _BottomActions extends StatelessWidget {
  const _BottomActions();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: const <Widget>[
        SoftButton(label: 'Next sample', width: 108, height: 52),
        SoftButton(label: 'Mode', width: 108, height: 52),
        SoftButton(label: 'Retest', width: 108, height: 52),
        SoftButton(label: 'Verify', width: 108, height: 52),
        SoftButton(label: 'Start test', width: 108, height: 52),
      ],
    );
  }
}
