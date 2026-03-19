import 'dart:async';

import 'package:flutter/material.dart';

import 'model/navigation.dart';
import 'screens/analysis_page.dart';
import 'screens/lj_qc_page.dart';
import 'screens/list_review_page.dart';
import 'screens/maintenance_page.dart';
import 'screens/print_page.dart';
import 'style/palette.dart';
import 'widgets/instrument_scaffold.dart';

class AnalyzerDemoApp extends StatelessWidget {
  const AnalyzerDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Analyzer UI Demo',
      theme: ThemeData(
        useMaterial3: false,
        scaffoldBackgroundColor: const Color(0xFF284D6A),
        fontFamily: 'Arial',
      ),
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
  TopModule _module = TopModule.analysis;
  int _maintenanceSide = 8;
  int _ljSide = 0;
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
              border: Border.all(color: const Color(0xFF89A5BC), width: 1.5),
            ),
            child: InstrumentScaffold(
              selectedModule: _module,
              onModuleChanged: (TopModule module) => setState(() => _module = module),
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
        return const LjQcPage();
      case TopModule.maintenance:
      case TopModule.addDiluent:
        return const MaintenancePage();
      case TopModule.print:
        return const PrintPage();
    }
  }
}

String _formatTime(DateTime time) {
  String two(int v) => v.toString().padLeft(2, '0');
  return '${time.year}-${two(time.month)}-${two(time.day)} ${two(time.hour)}:${two(time.minute)}:${two(time.second)}';
}
