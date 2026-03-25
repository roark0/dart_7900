import 'package:flutter/material.dart';

import '../../design_system/design_system.dart';

const Color _bg = Color(0xFFC8D6E4);
const Color _panel = Color(0xFFC8D6E4);
const Color _header = Color(0xFF3E7AAA);
const Color _accent = Color(0xFFDCE8F2);
const Color _border = Color(0xFF8FAECC);
const Color _text = Color(0xFF000000);

abstract class MaintenanceSectionSpec {
  const MaintenanceSectionSpec();
}

class MaintenanceActionItemSpec {
  const MaintenanceActionItemSpec({
    required this.text,
    this.variant = MaintenanceActionVariant.primary,
    this.disabled = false,
  });

  final String text;
  final MaintenanceActionVariant variant;
  final bool disabled;
}

enum MaintenanceActionVariant { primary, secondary, muted }

class MaintenanceActionRowSpec extends MaintenanceSectionSpec {
  const MaintenanceActionRowSpec({
    required this.items,
    this.title,
    this.align = MainAxisAlignment.center,
    this.selectedText,
    this.wrap = false,
  });

  final String? title;
  final List<MaintenanceActionItemSpec> items;
  final MainAxisAlignment align;
  final String? selectedText;
  final bool wrap;
}

class MaintenanceFieldSpec {
  const MaintenanceFieldSpec({
    required this.label,
    required this.value,
    this.readOnly = false,
    this.select = false,
  });

  final String label;
  final String value;
  final bool readOnly;
  final bool select;
}

class MaintenanceFormGridSpec extends MaintenanceSectionSpec {
  const MaintenanceFormGridSpec({
    required this.rows,
    this.title,
    this.columns = 2,
  });

  final String? title;
  final int columns;
  final List<List<MaintenanceFieldSpec>> rows;
}

class MaintenanceMatrixTableSpec extends MaintenanceSectionSpec {
  const MaintenanceMatrixTableSpec({
    required this.headers,
    required this.rows,
    this.title,
  });

  final String? title;
  final List<String> headers;
  final List<List<String>> rows;
}

class MaintenanceInfoBarSpec extends MaintenanceSectionSpec {
  const MaintenanceInfoBarSpec({required this.items, this.title});

  final String? title;
  final List<String> items;
}

class MaintenanceChartSpec {
  const MaintenanceChartSpec({required this.title, required this.xAxis});

  final String title;
  final String xAxis;
}

class MaintenanceChartRowSpec extends MaintenanceSectionSpec {
  const MaintenanceChartRowSpec({required this.charts});

  final List<MaintenanceChartSpec> charts;
}

class MaintenanceSurface extends StatelessWidget {
  const MaintenanceSurface({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _bg,
      padding: const EdgeInsets.fromLTRB(6, 6, 8, 6),
      child: Container(
        decoration: BoxDecoration(
          color: _panel,
          border: Border.all(color: _border),
        ),
        padding: const EdgeInsets.all(8),
        child: child,
      ),
    );
  }
}

class MaintenanceSectionView extends StatelessWidget {
  const MaintenanceSectionView({super.key, required this.spec});

  final MaintenanceSectionSpec spec;

  @override
  Widget build(BuildContext context) {
    return switch (spec) {
      MaintenanceActionRowSpec row => _ActionRowSection(spec: row),
      MaintenanceFormGridSpec grid => _FormGridSection(spec: grid),
      MaintenanceMatrixTableSpec table => _MatrixTableSection(spec: table),
      MaintenanceInfoBarSpec info => _InfoBarSection(spec: info),
      MaintenanceChartRowSpec chart => _ChartRowSection(spec: chart),
      _ => const SizedBox.shrink(),
    };
  }
}

class MaintenanceSectionList extends StatelessWidget {
  const MaintenanceSectionList({super.key, required this.sections});

  final List<MaintenanceSectionSpec> sections;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: sections.length,
      separatorBuilder: (_, index) => const SizedBox(height: 10),
      itemBuilder: (BuildContext context, int index) {
        return MaintenanceSectionView(spec: sections[index]);
      },
    );
  }
}

class MaintenanceTabbedPage extends StatefulWidget {
  const MaintenanceTabbedPage({
    super.key,
    required this.tabs,
    required this.initialTab,
  });

  final List<MaintenanceTabSpec> tabs;
  final String initialTab;

  @override
  State<MaintenanceTabbedPage> createState() => _MaintenanceTabbedPageState();
}

class _MaintenanceTabbedPageState extends State<MaintenanceTabbedPage> {
  late String _selected = widget.initialTab;

  @override
  Widget build(BuildContext context) {
    final MaintenanceTabSpec active = widget.tabs.firstWhere(
      (MaintenanceTabSpec tab) => tab.label == _selected,
      orElse: () => widget.tabs.first,
    );

    return MaintenanceSurface(
      child: Column(
        children: <Widget>[
          _TabBar(
            tabs: widget.tabs.map((MaintenanceTabSpec e) => e.label).toList(),
            selected: _selected,
            onChanged: (String value) => setState(() => _selected = value),
          ),
          const SizedBox(height: 10),
          Expanded(child: MaintenanceSectionList(sections: active.sections)),
        ],
      ),
    );
  }
}

class MaintenanceStaticPage extends StatelessWidget {
  const MaintenanceStaticPage({super.key, required this.sections});

  final List<MaintenanceSectionSpec> sections;

  @override
  Widget build(BuildContext context) {
    return MaintenanceSurface(
      child: MaintenanceSectionList(sections: sections),
    );
  }
}

class MaintenanceTabSpec {
  const MaintenanceTabSpec({required this.label, required this.sections});

  final String label;
  final List<MaintenanceSectionSpec> sections;
}

class _TabBar extends StatelessWidget {
  const _TabBar({
    required this.tabs,
    required this.selected,
    required this.onChanged,
  });

  final List<String> tabs;
  final String selected;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: tabs
            .map(
              (String tab) => Padding(
                padding: const EdgeInsets.only(right: 6),
                child: GestureDetector(
                  onTap: () => onChanged(tab),
                  child: Container(
                    constraints: const BoxConstraints(minWidth: 126),
                    height: 42,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: tab == selected ? _header : _accent,
                      border: Border.all(color: _border),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      tab,
                      textAlign: TextAlign.center,
                      style:
                          (tab == selected
                                  ? UiTypography.buttonLabelOnPrimary
                                  : UiTypography.buttonLabel)
                              .copyWith(height: 1.0),
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _ActionRowSection extends StatelessWidget {
  const _ActionRowSection({required this.spec});

  final MaintenanceActionRowSpec spec;

  @override
  Widget build(BuildContext context) {
    final Widget buttons = spec.wrap
        ? Wrap(
            alignment: WrapAlignment.center,
            spacing: 24,
            runSpacing: 24,
            children: spec.items
                .map(
                  (MaintenanceActionItemSpec item) => _ActionButton(item: item),
                )
                .toList(),
          )
        : SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: spec.align,
              children: spec.items
                  .map(
                    (MaintenanceActionItemSpec item) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: _ActionButton(
                        item: item,
                        selected: item.text == spec.selectedText,
                      ),
                    ),
                  )
                  .toList(),
            ),
          );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (spec.title != null) ...<Widget>[
          Text(spec.title!, style: UiTypography.sectionTitle),
          const SizedBox(height: 6),
        ],
        buttons,
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({required this.item, this.selected = false});

  final MaintenanceActionItemSpec item;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final bool secondary = item.variant == MaintenanceActionVariant.secondary;
    final Color bg = selected
        ? _header
        : secondary
        ? _accent
        : UiPalette.softButtonBackground;
    final Color fg = selected ? Colors.white : _text;

    return Opacity(
      opacity: item.disabled ? 0.55 : 1,
      child: Container(
        constraints: const BoxConstraints(minWidth: 126),
        height: secondary ? 42 : 56,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          gradient: secondary || selected
              ? null
              : const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[Color(0xFFD6E6F1), Color(0xFFB7D0E4)],
                ),
          color: secondary || selected ? bg : null,
          border: Border.all(color: _border),
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.center,
        child: Text(
          item.text,
          textAlign: TextAlign.center,
          style: UiTypography.bottomActionLabel.copyWith(
            color: fg,
            height: 1.05,
            fontSize: secondary ? 13 : 14,
          ),
        ),
      ),
    );
  }
}

class _FormGridSection extends StatelessWidget {
  const _FormGridSection({required this.spec});

  final MaintenanceFormGridSpec spec;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (spec.title != null) ...<Widget>[
          Text(spec.title!, style: UiTypography.sectionTitle),
          const SizedBox(height: 6),
        ],
        Column(
          children: spec.rows
              .map(
                (List<MaintenanceFieldSpec> row) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: row
                        .map(
                          (MaintenanceFieldSpec field) => Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: _FieldCell(field: field),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class _FieldCell extends StatelessWidget {
  const _FieldCell({required this.field});

  final MaintenanceFieldSpec field;

  @override
  Widget build(BuildContext context) {
    final bool blank = field.label.isEmpty && field.value.isEmpty;
    if (blank) return const SizedBox(height: 32);

    return Row(
      children: <Widget>[
        if (field.label.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(right: 6),
            child: Text(field.label, style: UiTypography.fieldLabel),
          ),
        Expanded(
          child: Container(
            height: 32,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: field.readOnly ? _accent : Colors.white,
              border: Border.all(color: UiPalette.inputBorder),
            ),
            alignment: Alignment.centerLeft,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    field.value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: UiTypography.inputValue,
                  ),
                ),
                if (field.select)
                  const Icon(Icons.arrow_drop_down, size: 18, color: _text),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _MatrixTableSection extends StatelessWidget {
  const _MatrixTableSection({required this.spec});

  final MaintenanceMatrixTableSpec spec;

  @override
  Widget build(BuildContext context) {
    final List<int> flexes = spec.headers
        .map((String e) => e.length > 12 ? 2 : 1)
        .toList();
    if (flexes.isNotEmpty) {
      flexes[0] = flexes[0] < 2 ? 2 : flexes[0];
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (spec.title != null) ...<Widget>[
          Text(spec.title!, style: UiTypography.sectionTitle),
          const SizedBox(height: 6),
        ],
        Container(
          decoration: BoxDecoration(border: Border.all(color: _border)),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: MediaQuery.sizeOf(context).width - 150,
              ),
              child: Column(
                children: <Widget>[
                  _TableRow(values: spec.headers, flexes: flexes, header: true),
                  ...spec.rows.asMap().entries.map(
                    (MapEntry<int, List<String>> entry) => _TableRow(
                      values: entry.value,
                      flexes: flexes,
                      header: false,
                      rowIndex: entry.key,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _TableRow extends StatelessWidget {
  const _TableRow({
    required this.values,
    required this.flexes,
    required this.header,
    this.rowIndex = 0,
  });

  final List<String> values;
  final List<int> flexes;
  final bool header;
  final int rowIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List<Widget>.generate(values.length, (int index) {
        final bool accentFirst = !header && index == 0;
        final double width = (index < flexes.length ? flexes[index] : 1) * 104;
        return SizedBox(
          width: width,
          child: Container(
            height: header ? 36 : 28,
            padding: const EdgeInsets.symmetric(horizontal: 6),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: header
                  ? _header
                  : accentFirst
                  ? UiPalette.tableHeaderLight
                  : rowIndex.isEven
                  ? Colors.white.withValues(alpha: 0.55)
                  : UiPalette.tableRowLight.withValues(alpha: 0.4),
              border: Border(
                right: const BorderSide(color: Colors.white, width: 0.6),
                bottom: BorderSide(
                  color: header ? Colors.white : _border.withValues(alpha: 0.6),
                  width: 0.6,
                ),
              ),
            ),
            child: Text(
              values[index],
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: header
                  ? UiTypography.tableHeader
                  : UiTypography.dataValue.copyWith(
                      color: accentFirst ? Colors.white : _text,
                    ),
            ),
          ),
        );
      }),
    );
  }
}

class _InfoBarSection extends StatelessWidget {
  const _InfoBarSection({required this.spec});

  final MaintenanceInfoBarSpec spec;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (spec.title != null) ...<Widget>[
          Text(spec.title!, style: UiTypography.sectionTitle),
          const SizedBox(height: 6),
        ],
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: _accent,
            border: Border.all(color: _border),
          ),
          child: Wrap(
            spacing: 20,
            runSpacing: 4,
            children: spec.items
                .map(
                  (String item) => Text(item, style: UiTypography.fieldLabel),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}

class _ChartRowSection extends StatelessWidget {
  const _ChartRowSection({required this.spec});

  final MaintenanceChartRowSpec spec;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: spec.charts
          .map(
            (MaintenanceChartSpec chart) => Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: _ChartCard(spec: chart),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _ChartCard extends StatelessWidget {
  const _ChartCard({required this.spec});

  final MaintenanceChartSpec spec;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 156,
      decoration: BoxDecoration(
        color: UiPalette.chartBackground,
        border: Border.all(color: _border),
      ),
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
      child: Stack(
        children: <Widget>[
          Positioned.fill(child: CustomPaint(painter: _ChartAxesPainter())),
          Align(
            alignment: Alignment.topRight,
            child: Text(spec.title, style: UiTypography.tableHeader),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Text(spec.xAxis, style: UiTypography.chartScale),
          ),
        ],
      ),
    );
  }
}

class _ChartAxesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1;
    canvas.drawLine(const Offset(14, 8), Offset(14, size.height - 18), paint);
    canvas.drawLine(
      Offset(14, size.height - 18),
      Offset(size.width - 8, size.height - 18),
      paint,
    );
    for (int i = 0; i < 4; i++) {
      final double y = 16 + i * ((size.height - 34) / 3);
      canvas.drawLine(Offset(11, y), Offset(14, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
