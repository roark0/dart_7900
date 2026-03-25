import 'package:flutter/material.dart';

import '../theme/theme.dart';

class SectionBox extends StatelessWidget {
  const SectionBox({
    super.key,
    required this.title,
    required this.child,
    this.padding = const EdgeInsets.all(8),
  });

  final String title;
  final Widget child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: UiPalette.panelBackground,
        border: Border.all(color: UiPalette.panelBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: UiTypography.sectionTitle),
          const SizedBox(height: UiMetrics.space6),
          child,
        ],
      ),
    );
  }
}
