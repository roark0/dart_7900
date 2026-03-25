import 'package:flutter/material.dart';

import '../../core/theme/theme.dart';
import '../../core/widget/buttons.dart';
import 'sections.dart';

class MaintenanceVersionPage extends StatelessWidget {
  const MaintenanceVersionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaintenanceSurface(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: _VersionPanel(
              title: 'Version information',
              child: Column(
                children: <Widget>[
                  _VersionValueRow(
                    label: 'Operation\nsoftware',
                    value: 'V2.0e',
                  ),
                  _VersionValueRow(
                    label: 'Fluid path timing\nsequence',
                    value: '',
                  ),
                  _VersionValueRow(
                    label: 'Algorithm\nversion',
                    value: '0.0.1.9',
                  ),
                  _VersionValueRow(
                    label: 'Reagent\nconsumption',
                    value: 'V1.0-7900',
                  ),
                  _VersionValueRow(label: 'MCU version', value: ''),
                ],
              ),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: _VersionPanel(
              title: 'System upgrade',
              child: Column(
                children: <Widget>[
                  SizedBox(height: 62),
                  Center(
                    child: SoftButton(
                      label: 'Timing sequence\nupgrades',
                      width: 170,
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(child: SoftButton(label: 'MCU upgrade', width: 170)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _VersionPanel extends StatelessWidget {
  const _VersionPanel({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: UiPalette.border)),
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: UiTypography.sectionTitle),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _VersionValueRow extends StatelessWidget {
  const _VersionValueRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(flex: 7, child: Text(label, style: UiTypography.fieldLabel)),
          const SizedBox(width: 8),
          Expanded(
            flex: 12,
            child: Container(
              height: 26,
              padding: const EdgeInsets.symmetric(horizontal: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFD8D8D8),
                border: Border.all(color: UiPalette.inputBorder),
              ),
              alignment: Alignment.centerLeft,
              child: Text(value, style: UiTypography.inputValue),
            ),
          ),
        ],
      ),
    );
  }
}
