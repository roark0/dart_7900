import 'package:flutter/material.dart';

import 'sections.dart';

class MaintenanceLogPage extends StatelessWidget {
  const MaintenanceLogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaintenanceStaticPage(
      sections: <MaintenanceSectionSpec>[
        MaintenanceActionRowSpec(
          selectedText: 'Calibration records',
          items: <MaintenanceActionItemSpec>[
            MaintenanceActionItemSpec(
              text: 'Calibration records',
              variant: MaintenanceActionVariant.secondary,
            ),
            MaintenanceActionItemSpec(
              text: 'Parameter modification',
              variant: MaintenanceActionVariant.secondary,
            ),
            MaintenanceActionItemSpec(
              text: 'Fault information',
              variant: MaintenanceActionVariant.secondary,
            ),
            MaintenanceActionItemSpec(
              text: 'Daily maintenance',
              variant: MaintenanceActionVariant.secondary,
            ),
            MaintenanceActionItemSpec(
              text: 'Delete the operation',
              variant: MaintenanceActionVariant.secondary,
            ),
            MaintenanceActionItemSpec(
              text: 'Other actions',
              variant: MaintenanceActionVariant.secondary,
            ),
          ],
        ),
        MaintenanceMatrixTableSpec(
          headers: <String>['No.', 'Time', 'Event', 'User'],
          rows: <List<String>>[],
        ),
        MaintenanceActionRowSpec(
          items: <MaintenanceActionItemSpec>[
            MaintenanceActionItemSpec(text: 'Export'),
            MaintenanceActionItemSpec(text: 'Delete'),
          ],
        ),
      ],
    );
  }
}
