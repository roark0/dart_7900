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
              wrapColumns: 2,
              items: <MaintenanceActionItemSpec>[
                MaintenanceActionItemSpec(text: 'Liquid path\ncleaning'),
                MaintenanceActionItemSpec(text: 'Sampling\nprobe cleaning'),
                MaintenanceActionItemSpec(text: 'WBC chamber\ncleaning'),
                MaintenanceActionItemSpec(text: 'RBC chamber\ncleaning'),
              ],
            ),
          ],
        ),
        MaintenanceTabSpec(
          label: 'Maintenance',
          sections: <MaintenanceSectionSpec>[
            MaintenanceActionRowSpec(
              wrap: true,
              wrapColumns: 2,
              items: <MaintenanceActionItemSpec>[
                MaintenanceActionItemSpec(text: 'Aperture\nblockage\nremoval'),
                MaintenanceActionItemSpec(text: 'Aperture\nburning'),
                MaintenanceActionItemSpec(
                  text: 'Whole\nmachine conc.\nCleanser soak',
                ),
                MaintenanceActionItemSpec(text: 'Aperture\nBackflush'),
              ],
            ),
          ],
        ),
        MaintenanceTabSpec(
          label: 'Whole machine maintenance',
          sections: <MaintenanceSectionSpec>[
            MaintenanceActionRowSpec(
              wrap: true,
              wrapColumns: 3,
              items: <MaintenanceActionItemSpec>[
                MaintenanceActionItemSpec(text: 'Liquid path\nDrainage'),
                MaintenanceActionItemSpec(text: 'WBC chamber\ndrainage'),
                MaintenanceActionItemSpec(text: 'RBC chamber\ndrainage'),
                MaintenanceActionItemSpec(text: 'Instrument\npack'),
                MaintenanceActionItemSpec(text: 'Initialize'),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
