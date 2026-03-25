import 'package:flutter/material.dart';

import 'sections.dart';

class MaintenanceDataPage extends StatelessWidget {
  const MaintenanceDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaintenanceStaticPage(
      sections: <MaintenanceSectionSpec>[
        MaintenanceActionRowSpec(
          title: 'System data',
          items: <MaintenanceActionItemSpec>[
            MaintenanceActionItemSpec(text: 'Backup'),
            MaintenanceActionItemSpec(text: 'Recover'),
          ],
        ),
        MaintenanceActionRowSpec(
          title: 'Configure parameters',
          items: <MaintenanceActionItemSpec>[
            MaintenanceActionItemSpec(text: 'Export'),
            MaintenanceActionItemSpec(text: 'Import'),
          ],
        ),
        MaintenanceCleanupPanelSpec(
          options: <String>[
            "List review",
            "Quality control data",
            "Log",
            "All data",
          ],
          actionText: "Delete",
          selectedOption: "List review",
        ),
      ],
    );
  }
}
