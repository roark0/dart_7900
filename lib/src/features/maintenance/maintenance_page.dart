import 'package:flutter/material.dart';

import 'maintenance_generated_base.dart';
import '../../design_system/palette.dart';

class MaintenancePage extends StatefulWidget {
  const MaintenancePage({super.key, this.selectedSideIndex = 0});

  final int selectedSideIndex;

  @override
  State<MaintenancePage> createState() => _MaintenancePageState();
}

class _MaintenancePageState extends State<MaintenancePage> {
  int _tabIndex = 0;

  static const List<String> _tabs = <String>[
    'Replace Reagents',
    'Clean',
    'Maintenance',
    'Whole machine maintenance',
  ];

  @override
  Widget build(BuildContext context) {
    if (widget.selectedSideIndex != 0) {
      return _PlaceholderPanel(label: _sideTitle(widget.selectedSideIndex));
    }

    return Padding(
      padding: const EdgeInsets.all(UiMetrics.space6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _MaintenanceTabs(
            selectedIndex: _tabIndex,
            onChanged: (int value) => setState(() => _tabIndex = value),
          ),
          const SizedBox(height: UiMetrics.space8),
          Expanded(child: _buildActivePanel()),
        ],
      ),
    );
  }

  Widget _buildActivePanel() {
    switch (_tabIndex) {
      case 0:
        return const MaintenanceReagentPanel();
      case 1:
        return const MaintenanceActionGrid(
          items: <MaintenanceButtonAction>[
            MaintenanceButtonAction('Liquid path\ncleaning'),
            MaintenanceButtonAction('Sampling\nprobe cleaning'),
            MaintenanceButtonAction('WBC chamber\ncleaning'),
            MaintenanceButtonAction('RBC chamber\ncleaning'),
          ],
        );
      case 2:
        return const MaintenanceActionGrid(
          items: <MaintenanceButtonAction>[
            MaintenanceButtonAction('Aperture\nblockage\nremoval'),
            MaintenanceButtonAction('Aperture\nburning'),
            MaintenanceButtonAction('Whole\nmachine conc.\nCleanser soak'),
            MaintenanceButtonAction('Aperture\nBackflush'),
          ],
        );
      case 3:
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
      default:
        return const SizedBox.shrink();
    }
  }

  String _sideTitle(int index) {
    const List<String> titles = <String>[
      'Daily maintenance',
      'Data maintenance',
      'Version information',
      'Statistics',
      'Log information',
      'Status information',
      'Mechanical inspection',
      'Engineering commissioning',
      'Basic',
    ];
    return titles[index];
  }
}

class _MaintenanceTabs extends StatelessWidget {
  const _MaintenanceTabs({
    required this.selectedIndex,
    required this.onChanged,
  });

  final int selectedIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List<Widget>.generate(_MaintenancePageState._tabs.length, (
        int index,
      ) {
        final bool selected = index == selectedIndex;
        final String label = _MaintenancePageState._tabs[index];
        return Expanded(
          child: GestureDetector(
            onTap: () => onChanged(index),
            child: Container(
              height: 38,
              margin: const EdgeInsets.only(right: UiMetrics.space4),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selected ? UiPalette.tabHeader : UiPalette.border,
                border: Border.all(color: UiPalette.sideNavBorder),
                borderRadius: BorderRadius.circular(UiMetrics.radius),
              ),
              child: Text(
                label == 'Whole machine maintenance'
                    ? 'Whole machine\nmaintenance'
                    : label,
                textAlign: TextAlign.center,
                style: selected
                    ? UiTypography.buttonLabelOnPrimary
                    : UiTypography.buttonLabel.copyWith(
                        color: UiPalette.foreground,
                      ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _PlaceholderPanel extends StatelessWidget {
  const _PlaceholderPanel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: UiPalette.panelBackground,
      alignment: Alignment.center,
      child: Text(
        '$label is not generated yet.',
        style: UiTypography.sectionTitle,
      ),
    );
  }
}
