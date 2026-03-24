import 'package:flutter/material.dart';

import 'maintenance_generated_base.dart';

class Maintenance13Page extends MaintenanceGeneratedPage {
  const Maintenance13Page({super.key});

  @override
  String get clockText => '2026-03-24 17:40:07';

  @override
  String get selectedTab => 'Maintenance';

  @override
  Widget buildPageBody(BuildContext context) {
    return const MaintenanceActionGrid(
      items: <MaintenanceButtonAction>[
        MaintenanceButtonAction('Aperture\nblockage\nremoval'),
        MaintenanceButtonAction('Aperture\nburning'),
        MaintenanceButtonAction('Whole\nmachine conc.\nCleanser soak'),
        MaintenanceButtonAction('Aperture\nBackflush'),
      ],
    );
  }
}
