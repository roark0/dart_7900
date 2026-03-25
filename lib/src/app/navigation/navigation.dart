import 'package:flutter/material.dart';

enum TopModule { analysis, listReview, ljQc, maintenance, addDiluent, print }

class TopNavItem {
  const TopNavItem({
    required this.module,
    required this.label,
    required this.icon,
  });

  final TopModule module;
  final String label;
  final IconData icon;
}

class SideNavItem {
  const SideNavItem(this.label);

  final String label;
}

const List<TopNavItem> topNavItems = <TopNavItem>[
  TopNavItem(
    module: TopModule.analysis,
    label: 'Analysis',
    icon: Icons.assessment_outlined,
  ),
  TopNavItem(
    module: TopModule.listReview,
    label: 'List Review',
    icon: Icons.bar_chart,
  ),
  TopNavItem(
    module: TopModule.ljQc,
    label: 'L-J QC',
    icon: Icons.balance_outlined,
  ),
  TopNavItem(
    module: TopModule.maintenance,
    label: 'Maintenance',
    icon: Icons.build_outlined,
  ),
  TopNavItem(
    module: TopModule.addDiluent,
    label: 'Add Diluent',
    icon: Icons.water_drop_outlined,
  ),
  TopNavItem(
    module: TopModule.print,
    label: 'Print',
    icon: Icons.print_outlined,
  ),
];

const List<SideNavItem> maintenanceSideMenu = <SideNavItem>[
  SideNavItem('Daily\nmaintenance'),
  SideNavItem('Data\nmaintenance'),
  SideNavItem('Version\ninformation'),
  SideNavItem('Statistics'),
  SideNavItem('Log\ninformation'),
  SideNavItem('Status\ninformation'),
  SideNavItem('Mechanical\ninspection'),
  SideNavItem('Engineering\ncommissioning'),
  SideNavItem('Basic'),
];

const List<SideNavItem> ljQcSideMenu = <SideNavItem>[
  SideNavItem('L-J QC\nSettings'),
  SideNavItem('L-J QC\nAnalyse'),
  SideNavItem('L-J QC\nGraph'),
  SideNavItem('L-J QC list'),
];
