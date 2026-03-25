import 'package:flutter/material.dart';

import 'sections.dart';

class MaintenanceStatisticsPage extends StatelessWidget {
  const MaintenanceStatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaintenanceStaticPage(
      sections: <MaintenanceSectionSpec>[
        MaintenanceFormGridSpec(
          columns: 3,
          rows: <List<MaintenanceFieldSpec>>[
            <MaintenanceFieldSpec>[
              MaintenanceFieldSpec(
                label: 'Sample testing times',
                value: '',
                readOnly: true,
              ),
              MaintenanceFieldSpec(label: '', value: '0', readOnly: true),
              MaintenanceFieldSpec(label: '', value: 'Details', readOnly: true),
            ],
            <MaintenanceFieldSpec>[
              MaintenanceFieldSpec(
                label: 'Quality control testing Times',
                value: '',
                readOnly: true,
              ),
              MaintenanceFieldSpec(label: '', value: '0', readOnly: true),
              MaintenanceFieldSpec(label: '', value: 'Details', readOnly: true),
            ],
            <MaintenanceFieldSpec>[
              MaintenanceFieldSpec(
                label: 'Automatic calibration Test times',
                value: '',
                readOnly: true,
              ),
              MaintenanceFieldSpec(label: '', value: '0', readOnly: true),
              MaintenanceFieldSpec(label: '', value: 'Details', readOnly: true),
            ],
            <MaintenanceFieldSpec>[
              MaintenanceFieldSpec(
                label: 'Blank testing times',
                value: '',
                readOnly: true,
              ),
              MaintenanceFieldSpec(label: '', value: '0', readOnly: true),
              MaintenanceFieldSpec(label: '', value: 'Reset', readOnly: true),
            ],
          ],
        ),
      ],
    );
  }
}
