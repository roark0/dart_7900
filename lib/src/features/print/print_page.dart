import 'package:flutter/material.dart';

import '../../core/common_widgets.dart';

class PrintPage extends StatelessWidget {
  const PrintPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Print',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: SectionBox(
              title: 'Print preview area',
              child: Container(
                color: const Color(0xFFCAD6E1),
                alignment: Alignment.center,
                child: const Text(
                  'Reserved for report template preview',
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              SoftButton(label: 'Setup', width: 96, height: 48),
              SizedBox(width: 10),
              SoftButton(label: 'Print', width: 96, height: 48),
            ],
          ),
        ],
      ),
    );
  }
}
