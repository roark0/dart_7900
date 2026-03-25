import 'package:flutter/material.dart';

import 'sections.dart';

class MaintenanceBasicPage extends StatelessWidget {
  const MaintenanceBasicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaintenanceTabbedPage(
      initialTab: 'Carryover',
      tabs: const <MaintenanceTabSpec>[
        MaintenanceTabSpec(
          label: 'Carryover',
          sections: <MaintenanceSectionSpec>[
            MaintenanceFormGridSpec(
              columns: 2,
              rows: <List<MaintenanceFieldSpec>>[
                <MaintenanceFieldSpec>[
                  MaintenanceFieldSpec(
                    label: 'Mode',
                    value: 'Whole blood',
                    select: true,
                  ),
                  MaintenanceFieldSpec(
                    label: 'Item',
                    value: 'WBC+PLT',
                    select: true,
                  ),
                ],
              ],
            ),
            MaintenanceMatrixTableSpec(
              headers: <String>['Item', 'WBC', 'RBC', 'HGB', 'PLT', 'HCT'],
              rows: <List<String>>[
                <String>['H1', '', '', '', '', ''],
                <String>['H2', '', '', '', '', ''],
                <String>['H3', '', '', '', '', ''],
                <String>['L1', '', '', '', '', ''],
                <String>['L2', '', '', '', '', ''],
                <String>['L3', '', '', '', '', ''],
                <String>['CV%', '', '', '', '', ''],
                <String>['Range', '0.5%', '0.5%', '0.5%', '1.0%', '0.5%'],
                <String>['Result', '', '', '', '', ''],
              ],
            ),
            MaintenanceInfoBarSpec(
              items: <String>['H1', 'Press the aspiration key to test'],
            ),
            MaintenanceActionRowSpec(
              items: <MaintenanceActionItemSpec>[
                MaintenanceActionItemSpec(text: 'Calc'),
                MaintenanceActionItemSpec(text: 'Delete'),
                MaintenanceActionItemSpec(text: 'Export'),
              ],
            ),
          ],
        ),
        MaintenanceTabSpec(
          label: 'Precision',
          sections: <MaintenanceSectionSpec>[
            MaintenanceInfoBarSpec(
              items: <String>[
                'Mode: Whole blood',
                '1',
                'Press the aspiration key to test',
              ],
            ),
            MaintenanceMatrixTableSpec(
              headers: <String>[
                'Item',
                'WBC',
                'RBC',
                'HGB',
                'MCV',
                'PLT',
                'MPV',
                'LYMP%',
                'Mid%',
                'Gran%',
              ],
              rows: <List<String>>[
                <String>['1', '', '', '', '', '', '', '', '', ''],
                <String>['2', '', '', '', '', '', '', '', '', ''],
                <String>['3', '', '', '', '', '', '', '', '', ''],
                <String>['4', '', '', '', '', '', '', '', '', ''],
                <String>['5', '', '', '', '', '', '', '', '', ''],
                <String>['6', '', '', '', '', '', '', '', '', ''],
                <String>['7', '', '', '', '', '', '', '', '', ''],
                <String>['8', '', '', '', '', '', '', '', '', ''],
                <String>['9', '', '', '', '', '', '', '', '', ''],
                <String>['10', '', '', '', '', '', '', '', '', ''],
                <String>['Std', '', '', '', '', '', '', '', '', ''],
                <String>['Ave', '', '', '', '', '', '', '', '', ''],
                <String>['CV%', '', '', '', '', '', '', '', '', ''],
                <String>[
                  'Range',
                  '2%',
                  '1.5%',
                  '1.5%',
                  '1.0%',
                  '4%',
                  '4%',
                  '4',
                  '3',
                  '5',
                ],
                <String>['Result', '', '', '', '', '', '', '', '', ''],
              ],
            ),
            MaintenanceActionRowSpec(
              items: <MaintenanceActionItemSpec>[
                MaintenanceActionItemSpec(text: 'Calc'),
                MaintenanceActionItemSpec(text: 'Delete'),
                MaintenanceActionItemSpec(text: 'Export'),
              ],
            ),
          ],
        ),
        MaintenanceTabSpec(
          label: 'Comparability',
          sections: <MaintenanceSectionSpec>[
            MaintenanceInfoBarSpec(
              items: <String>[
                'Mode: Whole blood',
                '1',
                'Press the aspiration key to test',
              ],
            ),
            MaintenanceMatrixTableSpec(
              headers: <String>[
                'Item',
                'WBC',
                'RBC',
                'HGB',
                'MCV',
                'HCT',
                'PLT',
              ],
              rows: <List<String>>[
                <String>['1', '', '', '', '', '', ''],
                <String>['2', '', '', '', '', '', ''],
                <String>['3', '', '', '', '', '', ''],
                <String>['4', '', '', '', '', '', ''],
                <String>['5', '', '', '', '', '', ''],
                <String>['Target', '', '', '', '', '', ''],
                <String>['Std', '', '', '', '', '', ''],
                <String>['Ave', '', '', '', '', '', ''],
                <String>['CV%', '', '', '', '', '', ''],
                <String>['Dev%', '', '', '', '', '', ''],
                <String>['Range', '5%', '2.5%', '2.5%', '3.0%', '3.0%', '8.0%'],
                <String>['Result', '', '', '', '', '', ''],
              ],
            ),
            MaintenanceActionRowSpec(
              items: <MaintenanceActionItemSpec>[
                MaintenanceActionItemSpec(text: 'Calc'),
                MaintenanceActionItemSpec(text: 'Delete'),
                MaintenanceActionItemSpec(text: 'Export'),
              ],
            ),
          ],
        ),
        MaintenanceTabSpec(
          label: 'Accuracy',
          sections: <MaintenanceSectionSpec>[
            MaintenanceFormGridSpec(
              columns: 2,
              rows: <List<MaintenanceFieldSpec>>[
                <MaintenanceFieldSpec>[
                  MaintenanceFieldSpec(
                    label: 'Mode',
                    value: 'Whole blood',
                    select: true,
                  ),
                  MaintenanceFieldSpec(
                    label: 'Sample type',
                    value: 'Sample type1',
                    select: true,
                  ),
                ],
              ],
            ),
            MaintenanceMatrixTableSpec(
              headers: <String>[
                'Item',
                'WBC',
                'RBC',
                'HGB',
                'MCV',
                'HCT',
                'PLT',
              ],
              rows: <List<String>>[
                <String>['1', '', '', '', '', '', ''],
                <String>['2', '', '', '', '', '', ''],
                <String>['3', '', '', '', '', '', ''],
                <String>['Target', '', '', '', '', '', ''],
                <String>['Dev1%', '', '', '', '', '', ''],
                <String>['Dev2%', '', '', '', '', '', ''],
                <String>['Dev3%', '', '', '', '', '', ''],
                <String>[
                  'Range',
                  '15.0%',
                  '6.0%',
                  '6.0%',
                  '7.0%',
                  '9.0%',
                  '20.0%',
                ],
                <String>['Result', '', '', '', '', '', ''],
              ],
            ),
            MaintenanceInfoBarSpec(
              items: <String>['1', 'Press the aspiration key to test'],
            ),
            MaintenanceActionRowSpec(
              items: <MaintenanceActionItemSpec>[
                MaintenanceActionItemSpec(text: 'Calc'),
                MaintenanceActionItemSpec(text: 'Delete'),
                MaintenanceActionItemSpec(text: 'Export'),
              ],
            ),
          ],
        ),
        MaintenanceTabSpec(
          label: 'Linear',
          sections: <MaintenanceSectionSpec>[
            MaintenanceInfoBarSpec(
              items: <String>[
                'Mode: WBC',
                '100.0%-1',
                'Press the aspiration key to test',
              ],
            ),
            MaintenanceMatrixTableSpec(
              headers: <String>[
                'Con%',
                '1',
                '2',
                '3',
                'Ave',
                'Fitted.',
                'Dev',
                'Dev%',
                'Std.',
                'Std.%',
                'Result',
              ],
              rows: <List<String>>[
                <String>['100.0%', '', '', '', '', '', '', '', '10', '', ''],
                <String>['75.0%', '', '', '', '', '', '', '', '10', '', ''],
                <String>['50.0%', '', '', '', '', '', '', '', '10', '', ''],
                <String>['37.5%', '', '', '', '', '', '', '', '10', '', ''],
                <String>['25.0%', '', '', '', '', '', '', '', '10', '', ''],
                <String>[
                  'K',
                  '',
                  'B',
                  '',
                  'Corre',
                  '',
                  'Range',
                  '',
                  '0.99',
                  'Result',
                  '',
                ],
              ],
            ),
            MaintenanceMatrixTableSpec(
              headers: <String>[
                'Con%',
                '1',
                '2',
                '3',
                'Ave',
                'Fitted.',
                'Dev',
                'Dev%',
                'Std.',
                'Std.%',
                'Result',
              ],
              rows: <List<String>>[
                <String>['50.0%', '', '', '', '', '', '', '', '0.5', '5', ''],
                <String>['25.0%', '', '', '', '', '', '', '', '0.5', '5', ''],
                <String>['6.25%', '', '', '', '', '', '', '', '0.5', '5', ''],
                <String>['1.5625%', '', '', '', '', '', '', '', '0.5', '5', ''],
                <String>[
                  '0.390625...',
                  '',
                  '',
                  '',
                  '',
                  '',
                  '',
                  '',
                  '0.5',
                  '5',
                  '',
                ],
                <String>[
                  'K',
                  '',
                  'B',
                  '',
                  'Corre',
                  '',
                  'Range',
                  '',
                  '0.99',
                  'Result',
                  '',
                ],
              ],
            ),
            MaintenanceActionRowSpec(
              items: <MaintenanceActionItemSpec>[
                MaintenanceActionItemSpec(text: 'Calc'),
                MaintenanceActionItemSpec(text: 'Delete'),
                MaintenanceActionItemSpec(text: 'Export'),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
