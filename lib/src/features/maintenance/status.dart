import 'package:flutter/material.dart';

import 'sections.dart';

class MaintenanceStatusPage extends StatelessWidget {
  const MaintenanceStatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaintenanceStaticPage(
      sections: <MaintenanceSectionSpec>[
        MaintenanceMatrixTableSpec(
          title: 'Pressure',
          headers: <String>['', 'KPa', 'Range'],
          rows: <List<String>>[
            <String>['Vacuum', '', ''],
          ],
        ),
        MaintenanceMatrixTableSpec(
          title: 'Sensor',
          headers: <String>['Device components', 'Status'],
          rows: <List<String>>[
            <String>['Waste floater sensor', ''],
            <String>['Sampling probe horizontal...', ''],
            <String>['Sampling probe vertical ...', ''],
            <String>['Sample syringe opticalco...', ''],
            <String>['Aspiration key', ''],
          ],
        ),
        MaintenanceMatrixTableSpec(
          title: 'AD',
          headers: <String>['', 'AD', 'Range'],
          rows: <List<String>>[
            <String>['HGB', '', ''],
          ],
        ),
      ],
    );
  }
}
