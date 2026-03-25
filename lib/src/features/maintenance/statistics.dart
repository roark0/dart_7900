import 'package:flutter/material.dart';

import '../../core/theme/theme.dart';
import '../../core/widget/buttons.dart';
import 'sections.dart';

class MaintenanceStatisticsPage extends StatelessWidget {
  const MaintenanceStatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaintenanceSurface(
      child: Padding(
        padding: EdgeInsets.fromLTRB(22, 52, 22, 20),
        child: _StatisticsContent(),
      ),
    );
  }
}

class _StatisticsContent extends StatelessWidget {
  const _StatisticsContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        _StatisticsRow(
          label: 'Sample testing times',
          value: '0',
          action: 'Details',
        ),
        SizedBox(height: 12),
        _StatisticsRow(
          label: 'Quality control testing\nTimes',
          value: '0',
          action: 'Details',
        ),
        SizedBox(height: 12),
        _StatisticsRow(
          label: 'Automatic calibration\nTest times',
          value: '0',
          action: 'Details',
        ),
        SizedBox(height: 12),
        _StatisticsRow(label: 'Blank testing  times', value: '0'),
        SizedBox(height: 34),
        Padding(
          padding: EdgeInsets.only(left: 223),
          child: SoftButton(label: 'Reset', width: 100),
        ),
      ],
    );
  }
}

class _StatisticsRow extends StatelessWidget {
  const _StatisticsRow({required this.label, required this.value, this.action});

  final String label;
  final String value;
  final String? action;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: 245,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: UiTypography.sectionTitle,
          ),
        ),
        const SizedBox(width: 14),
        Container(
          width: 150,
          height: 26,
          padding: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: const Color(0xFFD8D8D8),
            border: Border.all(color: UiPalette.inputBorder),
          ),
          alignment: Alignment.centerLeft,
          child: Text(value, style: UiTypography.inputValue),
        ),
        const SizedBox(width: 70),
        SizedBox(
          width: 128,
          child: action == null
              ? const SizedBox.shrink()
              : SoftButton(label: action!, height: 50),
        ),
      ],
    );
  }
}
