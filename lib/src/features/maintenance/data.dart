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
        MaintenanceFormGridSpec(
          columns: 3,
          rows: <List<MaintenanceFieldSpec>>[
            <MaintenanceFieldSpec>[
              MaintenanceFieldSpec(
                label: 'Data cleanup',
                value: 'List review',
                readOnly: true,
              ),
              MaintenanceFieldSpec(
                label: '',
                value: 'Quality control data',
                readOnly: true,
              ),
              MaintenanceFieldSpec(label: '', value: 'Delete', readOnly: true),
            ],
            <MaintenanceFieldSpec>[
              MaintenanceFieldSpec(label: '', value: 'Log', readOnly: true),
              MaintenanceFieldSpec(
                label: '',
                value: 'All data',
                readOnly: true,
              ),
              MaintenanceFieldSpec(label: '', value: '', readOnly: true),
            ],
          ],
        ),
      ],
    );
  }
}
