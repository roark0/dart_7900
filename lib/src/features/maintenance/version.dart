import 'package:flutter/material.dart';

import 'sections.dart';

class MaintenanceVersionPage extends StatelessWidget {
  const MaintenanceVersionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaintenanceStaticPage(
      sections: <MaintenanceSectionSpec>[
        MaintenanceFormGridSpec(
          title: 'Version information',
          columns: 1,
          rows: <List<MaintenanceFieldSpec>>[
            <MaintenanceFieldSpec>[
              MaintenanceFieldSpec(
                label: 'Operation software',
                value: 'V2.0e',
                readOnly: true,
              ),
            ],
            <MaintenanceFieldSpec>[
              MaintenanceFieldSpec(
                label: 'Fluid path timing sequence',
                value: '',
                readOnly: true,
              ),
            ],
            <MaintenanceFieldSpec>[
              MaintenanceFieldSpec(
                label: 'Algorithm version',
                value: '0.0.1.9',
                readOnly: true,
              ),
            ],
            <MaintenanceFieldSpec>[
              MaintenanceFieldSpec(
                label: 'Reagent consumption',
                value: 'V1.0-7900',
                readOnly: true,
              ),
            ],
            <MaintenanceFieldSpec>[
              MaintenanceFieldSpec(
                label: 'MCU version',
                value: '',
                readOnly: true,
              ),
            ],
          ],
        ),
        MaintenanceActionRowSpec(
          title: 'System upgrade',
          wrap: true,
          items: <MaintenanceActionItemSpec>[
            MaintenanceActionItemSpec(text: 'Timing sequence upgrades'),
            MaintenanceActionItemSpec(text: 'MCU upgrade'),
          ],
        ),
      ],
    );
  }
}
