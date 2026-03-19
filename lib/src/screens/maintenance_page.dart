import 'package:flutter/material.dart';

import '../style/palette.dart';
import '../widgets/common.dart';

class MaintenancePage extends StatelessWidget {
  const MaintenancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _MaintenanceTabs(),
          const SizedBox(height: 8),
          Expanded(
            child: SectionBox(
              title: 'Replace Reagents',
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const <Widget>[
                      SoftButton(label: 'All reagents', width: 104, height: 50),
                      SoftButton(label: 'Diluent', width: 104, height: 50),
                      SoftButton(label: 'Lyse', width: 104, height: 50),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Expanded(
                    child: SectionBox(
                      title: 'Reagent information',
                      child: Column(
                        children: <Widget>[
                          Container(
                            color: UiPalette.tableHeader,
                            child: const Row(
                              children: <Widget>[
                                TableHeaderCell('Type'),
                                TableHeaderCell('Lot No.'),
                                TableHeaderCell('Remaining\nvolume'),
                                TableHeaderCell('%'),
                                TableHeaderCell('Original\ncapacity'),
                                TableHeaderCell('Expired\ndate'),
                              ],
                            ),
                          ),
                          const ZebraRow(
                            rowIndex: 0,
                            accentFirst: true,
                            values: <String>['Diluent', 'Dil', '1000', '100.00', '1000', '2122-06-01'],
                          ),
                          const ZebraRow(
                            rowIndex: 1,
                            values: <String>['Lyse', 'Lys', '100', '100.00', '100', '2122-06-01'],
                          ),
                          Expanded(
                            child: Container(
                              color: UiPalette.panelBackground,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MaintenanceTabs extends StatelessWidget {
  const _MaintenanceTabs();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        _Tab(label: 'Replace Reagents', selected: true),
        _Tab(label: 'Clean'),
        _Tab(label: 'Maintenance'),
        _Tab(label: 'Whole machine\nmaintenance'),
      ],
    );
  }
}

class _Tab extends StatelessWidget {
  const _Tab({required this.label, this.selected = false});

  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 38,
        margin: const EdgeInsets.only(right: 4),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? UiPalette.tabHeader : const Color(0xFFB5C8DC),
          border: Border.all(color: const Color(0xFF5D8FBB)),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(color: selected ? Colors.white : Colors.black, fontSize: 13),
        ),
      ),
    );
  }
}
