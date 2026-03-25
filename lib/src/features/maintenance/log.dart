import 'package:flutter/material.dart';

import '../../core/theme/theme.dart';
import '../../core/widget/buttons.dart';
import 'sections.dart';

class MaintenanceLogPage extends StatefulWidget {
  const MaintenanceLogPage({super.key});

  @override
  State<MaintenanceLogPage> createState() => _MaintenanceLogPageState();
}

class _MaintenanceLogPageState extends State<MaintenanceLogPage> {
  static const List<String> _tabs = <String>[
    'Calibration\nrecords',
    'Parameter\nmodification',
    'Fault\ninformation',
    'Daily\nmaintenance',
    'Delete the\noperation',
    'Other actions',
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaintenanceSurface(
      child: Column(
        children: <Widget>[
          _LogTabs(
            tabs: _tabs,
            selectedIndex: _selectedIndex,
            onChanged: (int index) => setState(() => _selectedIndex = index),
          ),
          const SizedBox(height: 10),
          const Expanded(child: _LogTableArea()),
          const SizedBox(height: 10),
          const _LogBottomActions(),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class _LogTabs extends StatelessWidget {
  const _LogTabs({
    required this.tabs,
    required this.selectedIndex,
    required this.onChanged,
  });

  final List<String> tabs;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: tabs.asMap().entries.map((MapEntry<int, String> entry) {
          final bool selected = entry.key == selectedIndex;
          return Padding(
            padding: const EdgeInsets.only(right: 6),
            child: GestureDetector(
              onTap: () => onChanged(entry.key),
              child: Container(
                constraints: const BoxConstraints(minWidth: 94),
                height: 56,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: selected
                      ? UiPalette.tableHeader
                      : UiPalette.softButtonBackground,
                  border: Border.all(color: UiPalette.softButtonBorder),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Text(
                  entry.value,
                  textAlign: TextAlign.center,
                  style:
                      (selected
                              ? UiTypography.buttonLabelOnPrimary
                              : UiTypography.buttonLabel)
                          .copyWith(height: 1.1),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _LogTableArea extends StatelessWidget {
  const _LogTableArea();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: UiPalette.border),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  height: 36,
                  color: UiPalette.tableHeader,
                  child: const Row(
                    children: <Widget>[
                      _HeaderCell(text: 'No.', flex: 2),
                      _HeaderCell(text: 'Time', flex: 3),
                      _HeaderCell(text: 'Event', flex: 5),
                      _HeaderCell(text: 'User', flex: 2),
                    ],
                  ),
                ),
                const Expanded(child: SizedBox.shrink()),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        const _ScrollControlBar(),
      ],
    );
  }
}

class _HeaderCell extends StatelessWidget {
  const _HeaderCell({required this.text, required this.flex});

  final String text;
  final int flex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(
        decoration: const BoxDecoration(
          border: Border(right: BorderSide(color: Color(0xFFD5E2EB))),
        ),
        alignment: Alignment.center,
        child: Text(text, style: UiTypography.tableHeader),
      ),
    );
  }
}

class _ScrollControlBar extends StatelessWidget {
  const _ScrollControlBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      decoration: BoxDecoration(border: Border.all(color: UiPalette.border)),
      child: Column(
        children: const <Widget>[
          _ScrollCell(icon: Icons.keyboard_double_arrow_up),
          _ScrollCell(icon: Icons.keyboard_arrow_up),
          _ScrollCell(icon: Icons.keyboard_arrow_down),
          _ScrollCell(icon: Icons.keyboard_double_arrow_down),
        ],
      ),
    );
  }
}

class _ScrollCell extends StatelessWidget {
  const _ScrollCell({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: UiPalette.border)),
        ),
        alignment: Alignment.center,
        child: Icon(icon, color: UiPalette.softButtonBorder, size: 28),
      ),
    );
  }
}

class _LogBottomActions extends StatelessWidget {
  const _LogBottomActions();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const <Widget>[
        SoftButton(label: 'Export', width: 98),
        SizedBox(width: 180),
        SoftButton(label: 'Delete', width: 98),
      ],
    );
  }
}
