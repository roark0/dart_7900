import 'package:flutter/material.dart';

import 'maintenance_generated_base.dart';

class Maintenance12Page extends MaintenanceGeneratedPage {
  const Maintenance12Page({super.key});

  @override
  String get clockText => '2026-03-24 17:39:51';

  @override
  String get selectedTab => 'Clean';

  @override
  Widget buildPageBody(BuildContext context) {
    return const MaintenanceActionGrid(
      items: <MaintenanceButtonAction>[
        MaintenanceButtonAction('Liquid path\ncleaning'),
        MaintenanceButtonAction('Sampling\nprobe cleaning'),
        MaintenanceButtonAction('WBC chamber\ncleaning'),
        MaintenanceButtonAction('RBC chamber\ncleaning'),
      ],
    );
  }
}
