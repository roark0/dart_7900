import 'package:flutter/material.dart';

import '../../core/theme/theme.dart';
import 'basic.dart';
import 'daily.dart';
import 'data.dart';
import 'engineering.dart';
import 'log.dart';
import 'statistics.dart';
import 'status.dart';
import 'version.dart';

class MaintenancePage extends StatelessWidget {
  const MaintenancePage({super.key, this.selectedSideIndex = 0});

  final int selectedSideIndex;

  @override
  Widget build(BuildContext context) {
    return switch (selectedSideIndex) {
      0 => const MaintenanceDailyPage(),
      1 => const MaintenanceDataPage(),
      2 => const MaintenanceVersionPage(),
      3 => const MaintenanceStatisticsPage(),
      4 => const MaintenanceLogPage(),
      5 => const MaintenanceStatusPage(),
      6 => const _PendingMaintenancePage(label: 'Mechanical inspection'),
      7 => const MaintenanceEngineeringPage(),
      8 => const MaintenanceBasicPage(),
      _ => const SizedBox.shrink(),
    };
  }
}

class _PendingMaintenancePage extends StatelessWidget {
  const _PendingMaintenancePage({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: UiPalette.panelBackground,
      alignment: Alignment.center,
      child: Text(
        '$label is pending in DSL.',
        style: UiTypography.sectionTitle,
      ),
    );
  }
}
