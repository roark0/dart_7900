import 'package:flutter/material.dart';

import 'sections.dart';

class MaintenanceEngineeringPage extends StatelessWidget {
  const MaintenanceEngineeringPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaintenanceTabbedPage(
      initialTab: 'Performance parameters',
      tabs: <MaintenanceTabSpec>[
        MaintenanceTabSpec(
          label: 'Performance parameters',
          sections: <MaintenanceSectionSpec>[
            MaintenanceFormGridSpec(
              columns: 2,
              rows: <List<MaintenanceFieldSpec>>[
                _pair('WBC gain', '100', 'WBC threshold', '120'),
                _pair('RBC gain', '100', 'RBC threshold', '50'),
                _pair('HGB gain', '100', '', 'Set up'),
                _pair('Ambient temperature', '', '', '+ 0 °C'),
                _pair('', '', '', 'Set up'),
              ],
            ),
          ],
        ),
        MaintenanceTabSpec(
          label: 'Probe position',
          sections: <MaintenanceSectionSpec>[
            MaintenanceFormGridSpec(
              title: 'Horizontal motor position steps',
              columns: 3,
              rows: <List<MaintenanceFieldSpec>>[
                <MaintenanceFieldSpec>[
                  _ro('Sampling', '0'),
                  _ro('WBC', '0'),
                  _ro('RBC', '0'),
                ],
              ],
            ),
            MaintenanceActionRowSpec(items: _repeat('Adjust', 3)),
            MaintenanceActionRowSpec(items: _repeat('Detect', 3)),
            MaintenanceFormGridSpec(
              title: 'Vertical motor position steps',
              columns: 3,
              rows: <List<MaintenanceFieldSpec>>[
                <MaintenanceFieldSpec>[
                  _ro('Upper', '0'),
                  _ro('WBC', '0'),
                  _ro('RBC', '0'),
                ],
                <MaintenanceFieldSpec>[
                  _ro('Blocks air', '550'),
                  _ro('Sampling', '4200'),
                  _ro('Swab', '0'),
                ],
              ],
            ),
            MaintenanceActionRowSpec(items: _repeat('Adjust', 6)),
            MaintenanceActionRowSpec(items: _repeat('Detect', 6)),
            MaintenanceActionRowSpec(
              title: 'Motor control',
              wrap: true,
              items: const <MaintenanceActionItemSpec>[
                MaintenanceActionItemSpec(
                  text: 'The horizontal motor deactivate',
                ),
                MaintenanceActionItemSpec(
                  text: 'Horizontal motor incoming activate',
                ),
                MaintenanceActionItemSpec(
                  text: 'The vertical motor deactivate',
                ),
                MaintenanceActionItemSpec(text: 'Vertical motor activate'),
              ],
            ),
            MaintenanceActionRowSpec(
              wrap: true,
              items: const <MaintenanceActionItemSpec>[
                MaintenanceActionItemSpec(text: 'Save'),
                MaintenanceActionItemSpec(text: 'Search'),
                MaintenanceActionItemSpec(text: 'Component initialization'),
              ],
            ),
          ],
        ),
        MaintenanceTabSpec(
          label: 'Pressure calibration',
          sections: <MaintenanceSectionSpec>[
            MaintenanceFormGridSpec(
              columns: 2,
              rows: <List<MaintenanceFieldSpec>>[
                _pair('AD', '', 'KPa', ''),
                _pair(
                  'Establish posi. press.',
                  '',
                  'Establish neg. press.',
                  '',
                ),
                _pair('Y=', '96.386', 'Y=', '100.644'),
                _pair('KPa', '', 'KPa', ''),
                _pair(
                  '',
                  'Add to / Delete / Remove / Fit',
                  '',
                  'Add to / Delete / Remove / Fit',
                ),
                _pair(
                  '',
                  'Posi. press. detection',
                  '',
                  'Neg. press. detection',
                ),
                _pair(
                  '',
                  'Stop / Releases / Save',
                  '',
                  'Stop / Releases / Save',
                ),
              ],
            ),
          ],
        ),
        MaintenanceTabSpec(
          label: 'CBC gain',
          sections: <MaintenanceSectionSpec>[
            const MaintenanceChartRowSpec(
              charts: <MaintenanceChartSpec>[
                MaintenanceChartSpec(
                  title: 'WBC',
                  xAxis: '0 100 200 300 400 fL',
                ),
                MaintenanceChartSpec(
                  title: 'RBC',
                  xAxis: '0 50 100 150 200 250 fL',
                ),
                MaintenanceChartSpec(title: 'PLT', xAxis: '0 10 20 30 fL'),
              ],
            ),
            MaintenanceFormGridSpec(
              columns: 2,
              rows: <List<MaintenanceFieldSpec>>[
                _pair('WBC gain', '100 (0-255)', 'RBC gain', '100 (0-255)'),
                _pair('HGB gain', '100 (0-255)', '', 'Set up'),
                _pair('Lymphocyte peaks', '', 'MCV', ''),
                _pair('Granulocyte peaks', '', 'RBC main peak', ''),
                _pair('HGB blank AD', '', 'MPV', ''),
                _pair('HGB sample AD', '', '', ''),
              ],
            ),
          ],
        ),
        const MaintenanceTabSpec(
          label: 'CBC raw pulse diagram',
          sections: <MaintenanceSectionSpec>[
            MaintenanceInfoBarSpec(
              title: 'CBC raw pulse diagram',
              items: <String>[
                'WBC Position: 0 Pulse Number: 44262',
                'RBC Position: 0 Pulse Number: 44262',
                'PLT Position: 0 Pulse Number: 44262',
              ],
            ),
            MaintenanceActionRowSpec(
              items: <MaintenanceActionItemSpec>[
                MaintenanceActionItemSpec(text: 'Forward'),
                MaintenanceActionItemSpec(text: 'Backward'),
                MaintenanceActionItemSpec(text: 'Load'),
              ],
            ),
          ],
        ),
        MaintenanceTabSpec(
          label: 'Sensor AD',
          sections: <MaintenanceSectionSpec>[
            MaintenanceFormGridSpec(
              columns: 3,
              rows: <List<MaintenanceFieldSpec>>[
                <MaintenanceFieldSpec>[
                  _ro('Diluent sensor', '0 [0-1023]'),
                  _ro('AD threshold', '0'),
                  _ro('Measured AD', ''),
                ],
                <MaintenanceFieldSpec>[
                  _ro('Lyse sensor', '0 [0-1023]'),
                  _ro('AD threshold', '0'),
                  _ro('Measured AD', ''),
                ],
                <MaintenanceFieldSpec>[
                  _ro('', ''),
                  _ro('', 'Save'),
                  _ro('', ''),
                ],
              ],
            ),
          ],
        ),
        MaintenanceTabSpec(
          label: 'Aging',
          sections: <MaintenanceSectionSpec>[
            MaintenanceFormGridSpec(
              columns: 3,
              rows: <List<MaintenanceFieldSpec>>[
                <MaintenanceFieldSpec>[
                  _ro('Aging times', ''),
                  _ro('', ''),
                  _ro('', '-1: Unlimited times'),
                ],
                <MaintenanceFieldSpec>[
                  _ro('Analysis times', ''),
                  _ro('', ''),
                  _ro('', ''),
                ],
                <MaintenanceFieldSpec>[
                  _ro('', ''),
                  _ro('', 'Initiate'),
                  _ro('', ''),
                ],
              ],
            ),
          ],
        ),
        MaintenanceTabSpec(
          label: 'Fluid commissioning',
          sections: <MaintenanceSectionSpec>[
            MaintenanceFormGridSpec(
              title: 'Timing testing',
              columns: 2,
              rows: <List<MaintenanceFieldSpec>>[
                <MaintenanceFieldSpec>[_ro('', ''), _ro('', 'Execute')],
                <MaintenanceFieldSpec>[_ro('', ''), _ro('', 'Execute')],
              ],
            ),
          ],
        ),
      ],
    );
  }
}

List<MaintenanceFieldSpec> _pair(
  String leftLabel,
  String leftValue,
  String rightLabel,
  String rightValue,
) {
  return <MaintenanceFieldSpec>[
    _ro(leftLabel, leftValue),
    _ro(rightLabel, rightValue),
  ];
}

MaintenanceFieldSpec _ro(String label, String value) {
  return MaintenanceFieldSpec(label: label, value: value, readOnly: true);
}

List<MaintenanceActionItemSpec> _repeat(String text, int count) {
  return List<MaintenanceActionItemSpec>.generate(
    count,
    (_) => MaintenanceActionItemSpec(text: text),
  );
}
