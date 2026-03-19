import 'package:flutter/material.dart';

import '../style/palette.dart';
import '../widgets/common.dart';

class LjQcPage extends StatelessWidget {
  const LjQcPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(6, 6, 6, 2),
      child: Column(
        children: <Widget>[
          const _EditorHeader(),
          const SizedBox(height: 8),
          Expanded(
            child: Container(
              decoration: BoxDecoration(border: Border.all(color: const Color(0xFFD9E2E9))),
              child: Column(
                children: <Widget>[
                  Container(
                    color: UiPalette.tableHeaderLight,
                    child: const Row(
                      children: <Widget>[
                        TableHeaderCell('Item'),
                        TableHeaderCell('Target'),
                        TableHeaderCell('Limit'),
                        TableHeaderCell('Item'),
                        TableHeaderCell('Target'),
                        TableHeaderCell('Limit'),
                        TableHeaderCell('Item'),
                        TableHeaderCell('Target'),
                        TableHeaderCell('Limit'),
                      ],
                    ),
                  ),
                  ..._qcRows.asMap().entries.map(
                        (MapEntry<int, List<String>> entry) => ZebraRow(values: entry.value, rowIndex: entry.key),
                      ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SoftButton(label: 'Save', width: 108, height: 52),
              SoftButton(label: 'Delete', width: 108, height: 52),
            ],
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

const List<List<String>> _qcRows = <List<String>>[
  <String>['WBC', '', '', 'RBC', '', '', 'PLT', '', ''],
  <String>['Lym%', '', '', 'HGB', '', '', 'MPV', '', ''],
  <String>['Mid%', '', '', 'HCT', '', '', 'PDW-CV', '', ''],
  <String>['Gran%', '', '', 'MCV', '', '', 'PDW-SD', '', ''],
  <String>['Lym#', '', '', 'MCH', '', '', 'PCT', '', ''],
  <String>['Mid#', '', '', 'MCHC', '', '', 'P-LCR', '', ''],
  <String>['Gran#', '', '', 'RDW-CV', '', '', 'P-LCC', '', ''],
  <String>['', '', '', 'RDW-SD', '', '', '', '', ''],
];

class _EditorHeader extends StatelessWidget {
  const _EditorHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: const <Widget>[
            FieldLabel('FileNo.'),
            InputBox(value: '1', width: 100),
            SizedBox(width: 10),
            FieldLabel('LotNo.', width: 70),
            InputBox(width: 100),
            SizedBox(width: 6),
            FieldLabel('Exp.Date', width: 64),
            InputBox(value: '2026-03-18', width: 120),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          children: const <Widget>[
            FieldLabel('FileName'),
            InputBox(width: 100),
            SizedBox(width: 10),
            FieldLabel('QC Level', width: 70),
            InputBox(value: 'M', width: 100),
            SizedBox(width: 6),
            FieldLabel('Mode', width: 64),
            InputBox(value: 'Whole blood', width: 120),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          children: const <Widget>[
            FieldLabel('Set By'),
            InputBox(value: 'Engineer', width: 100, grayText: true),
            SizedBox(width: 10),
            FieldLabel('Date Created', width: 118),
            InputBox(value: '2026-03-18', width: 100, grayText: true),
            SizedBox(width: 6),
            FieldLabel('QCNo.', width: 64),
            InputBox(width: 120),
          ],
        ),
      ],
    );
  }
}
