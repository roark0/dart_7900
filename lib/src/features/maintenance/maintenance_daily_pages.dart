import 'package:flutter/material.dart';

import 'maintenance_generated_base.dart';

class MaintenanceDailyReplaceReagentsPage extends MaintenanceGeneratedPage {
  const MaintenanceDailyReplaceReagentsPage({super.key});

  @override
  String get clockText => '2026-03-18 16:39:57';

  @override
  String get selectedTab => 'Replace Reagents';

  @override
  Widget buildPageBody(BuildContext context) => const MaintenanceReagentPanel();
}

class MaintenanceDailyCleanPage extends MaintenanceGeneratedPage {
  const MaintenanceDailyCleanPage({super.key});

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

class MaintenanceDailyMaintenancePage extends MaintenanceGeneratedPage {
  const MaintenanceDailyMaintenancePage({super.key});

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

class MaintenanceDailyWholeMachinePage extends MaintenanceGeneratedPage {
  const MaintenanceDailyWholeMachinePage({super.key});

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
