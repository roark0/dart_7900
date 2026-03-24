import 'dart:async';

import 'package:flutter/material.dart';

import 'model/navigation.dart';
import 'screens/analysis_page.dart';
import 'screens/lj_qc_page.dart';
import 'screens/list_review_page.dart';
import 'screens/maintenance_page.dart';
import 'screens/print_page.dart';
import 'startup_config.dart';
import 'style/palette.dart';
import 'widgets/instrument_scaffold.dart';

TopModule _resolveInitialModule() {
  switch (getStartModule()) {
    case 'listReview':
      return TopModule.listReview;
    case 'ljQc':
      return TopModule.ljQc;
    case 'maintenance':
      return TopModule.maintenance;
    case 'addDiluent':
      return TopModule.addDiluent;
    case 'print':
      return TopModule.print;
    case 'analysis':
    default:
      return TopModule.analysis;
  }
}

class AnalyzerDemoApp extends StatelessWidget {
  const AnalyzerDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Analyzer UI Demo',
      theme: UiTheme.materialTheme(),
      home: const AnalyzerHomePage(),
    );
  }
}

class AnalyzerHomePage extends StatefulWidget {
  const AnalyzerHomePage({super.key});

  @override
  State<AnalyzerHomePage> createState() => _AnalyzerHomePageState();
}

class _AnalyzerHomePageState extends State<AnalyzerHomePage> {
  TopModule _module = _resolveInitialModule();
  int _maintenanceSide = 0;
  int _ljSide = getStartLjSide();
  late Timer _timer;
  String _clockText = _formatTime(DateTime.now());

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      setState(() => _clockText = _formatTime(DateTime.now()));
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AspectRatio(
          aspectRatio: 4 / 3,
          child: Container(
            decoration: BoxDecoration(
              color: UiPalette.frameBackground,
              border: Border.all(color: UiPalette.border, width: 1.5),
            ),
            child: InstrumentScaffold(
              selectedModule: _module,
              onModuleChanged: (TopModule module) =>
                  setState(() => _module = module),
              clockText: _clockText,
              sideMenu: _resolveSideMenu(),
              selectedSideIndex: _resolveSideIndex(),
              onSideChanged: _handleSideChange,
              content: _buildPage(),
            ),
          ),
        ),
      ),
    );
  }

  List<SideNavItem> _resolveSideMenu() {
    if (_module == TopModule.maintenance || _module == TopModule.addDiluent) {
      return maintenanceSideMenu;
    }
    if (_module == TopModule.ljQc) {
      return ljQcSideMenu;
    }
    return const <SideNavItem>[];
  }

  int _resolveSideIndex() {
    if (_module == TopModule.maintenance || _module == TopModule.addDiluent) {
      return _maintenanceSide;
    }
    if (_module == TopModule.ljQc) {
      return _ljSide;
    }
    return 0;
  }

  void _handleSideChange(int index) {
    setState(() {
      if (_module == TopModule.maintenance || _module == TopModule.addDiluent) {
        _maintenanceSide = index;
      } else if (_module == TopModule.ljQc) {
        _ljSide = index;
      }
    });
  }

  Widget _buildPage() {
    switch (_module) {
      case TopModule.analysis:
        return const AnalysisPage();
      case TopModule.listReview:
        return const ListReviewPage();
      case TopModule.ljQc:
        return LjQcPage(selectedSideIndex: _ljSide);
      case TopModule.maintenance:
      case TopModule.addDiluent:
        return MaintenancePage(selectedSideIndex: _maintenanceSide);
      case TopModule.print:
        return const PrintPage();
    }
  }
}

String _formatTime(DateTime time) {
  String two(int v) => v.toString().padLeft(2, '0');
  return '${time.year}-${two(time.month)}-${two(time.day)} ${two(time.hour)}:${two(time.minute)}:${two(time.second)}';
}
