import 'package:flutter/material.dart';

import 'sections.dart';

class MaintenanceDailyPage extends StatelessWidget {
  const MaintenanceDailyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaintenanceTabbedPage(
      initialTab: 'Replace Reagents',
      tabs: const <MaintenanceTabSpec>[
        MaintenanceTabSpec(
          label: 'Replace Reagents',
          sections: <MaintenanceSectionSpec>[
            MaintenanceActionRowSpec(
              title: 'Replace Reagents',
              items: <MaintenanceActionItemSpec>[
                MaintenanceActionItemSpec(text: 'All reagents'),
                MaintenanceActionItemSpec(text: 'Diluent'),
                MaintenanceActionItemSpec(text: 'Lyse'),
              ],
            ),
            MaintenanceMatrixTableSpec(
              title: 'Reagent information',
              headers: <String>[
                'Type',
                'Lot No.',
                'Remaining volume',
                '%',
                'Original capacity',
                'Expired date',
              ],
              rows: <List<String>>[
                <String>[
                  'Diluent',
                  'Dil',
                  '1000',
                  '100.00',
                  '1000',
                  '2122-06-01',
                ],
                <String>['Lyse', 'Lys', '100', '100.00', '100', '2122-06-01'],
              ],
            ),
          ],
        ),
        MaintenanceTabSpec(
          label: 'Clean',
          sections: <MaintenanceSectionSpec>[
            MaintenanceActionRowSpec(
              wrap: true,
              items: <MaintenanceActionItemSpec>[
                MaintenanceActionItemSpec(text: 'Liquid path cleaning'),
                MaintenanceActionItemSpec(text: 'Sampling probe cleaning'),
                MaintenanceActionItemSpec(text: 'WBC chamber cleaning'),
                MaintenanceActionItemSpec(text: 'RBC chamber cleaning'),
              ],
            ),
          ],
        ),
        MaintenanceTabSpec(
          label: 'Maintenance',
          sections: <MaintenanceSectionSpec>[
            MaintenanceActionRowSpec(
              wrap: true,
              items: <MaintenanceActionItemSpec>[
                MaintenanceActionItemSpec(text: 'Aperture blockage removal'),
                MaintenanceActionItemSpec(text: 'Aperture burning'),
                MaintenanceActionItemSpec(
                  text: 'Whole machine conc. Cleanser soak',
                ),
                MaintenanceActionItemSpec(text: 'Aperture Backflush'),
              ],
            ),
          ],
        ),
        MaintenanceTabSpec(
          label: 'Whole machine maintenance',
          sections: <MaintenanceSectionSpec>[
            MaintenanceActionRowSpec(
              wrap: true,
              items: <MaintenanceActionItemSpec>[
                MaintenanceActionItemSpec(text: 'Liquid path Drainage'),
                MaintenanceActionItemSpec(text: 'WBC chamber drainage'),
                MaintenanceActionItemSpec(text: 'RBC chamber drainage'),
                MaintenanceActionItemSpec(text: 'Instrument pack'),
                MaintenanceActionItemSpec(text: 'Initialize'),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
