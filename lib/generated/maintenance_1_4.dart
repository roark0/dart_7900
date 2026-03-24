import 'package:flutter/material.dart';

import 'maintenance_generated_base.dart';

class Maintenance14Page extends MaintenanceGeneratedPage {
  const Maintenance14Page({super.key});

  @override
  String get clockText => '2026-03-24 17:40:20';

  @override
  String get selectedTab => 'Whole machine maintenance';

  @override
  Widget buildPageBody(BuildContext context) {
    return const MaintenanceActionGrid(
      columns: 3,
      mainAxisSpacing: 34,
      crossAxisSpacing: 44,
      topPadding: 94,
      items: <MaintenanceButtonAction>[
        MaintenanceButtonAction('Liquid path\nDrainage', width: 126),
        MaintenanceButtonAction('WBC chamber\ndrainage', width: 126),
        MaintenanceButtonAction('RBC chamber\ndrainage', width: 126),
        MaintenanceButtonAction('Instrument\npack', width: 126),
        MaintenanceButtonAction('Initialize', width: 126),
      ],
    );
  }
}
