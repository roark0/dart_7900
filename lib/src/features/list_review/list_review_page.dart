import 'package:flutter/material.dart';

import '../../design_system/palette.dart';
import '../../core/common_widgets.dart';

class ListReviewPage extends StatelessWidget {
  const ListReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    const List<String> labels = <String>[
      'No.',
      'Date',
      'Time',
      'Process tags',
      'Name',
      'Sample No.',
      'WBC',
      'Lym%',
      'Mid%',
      'Gran%',
      'Lym#',
      'Mid#',
      'Gran#',
      'RBC',
      'HGB',
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 5, 6),
      child: Column(
        children: <Widget>[
          Row(
            children: const <Widget>[
              SizedBox(
                width: 150,
                child: Text('Sample list', style: UiTypography.fieldLabel),
              ),
              InputBox(value: 'Sample of the present day', width: 268),
              SizedBox(width: 24),
              Text(
                'The number of records in total:',
                style: UiTypography.fieldLabel,
              ),
              SizedBox(width: 14),
              Text('0', style: UiTypography.fieldLabel),
            ],
          ),
          const SizedBox(height: UiMetrics.space8),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Container(
                        color: UiPalette.tableHeader,
                        height: 30,
                        child: const Row(
                          children: <Widget>[
                            SizedBox(width: 166),
                            Expanded(child: SizedBox()),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: labels.length,
                          itemBuilder: (BuildContext context, int index) {
                            final bool even = index.isEven;
                            return SizedBox(
                              height: 34,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: 166,
                                    color: UiPalette.tableAccent,
                                    alignment: Alignment.center,
                                    child: Text(
                                      labels[index],
                                      style: UiTypography.buttonLabelOnPrimary,
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      color: even
                                          ? UiPalette.tableRowA
                                          : UiPalette.tableRowB,
                                      child: Row(
                                        children: List<Widget>.generate(
                                          6,
                                          (int i) => Expanded(
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                border: Border(
                                                  right: BorderSide(
                                                    color: Color(0xFFE5EDF4),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 36,
                  margin: const EdgeInsets.only(left: 3),
                  color: UiPalette.border,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: <Color>[
                                Color(0xFFF4F4F4),
                                Color(0xFFCFCFCF),
                              ],
                            ),
                          ),
                          child: const Icon(
                            Icons.arrow_drop_up,
                            color: Color(0xFFADB5BC),
                            size: 36,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: <Color>[
                                Color(0xFFDCE5EC),
                                Color(0xFFC4D2DE),
                              ],
                            ),
                          ),
                          child: const Icon(
                            Icons.arrow_drop_down,
                            color: Color(0xFF7693AF),
                            size: 36,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 42,
            margin: const EdgeInsets.only(top: UiMetrics.space2),
            decoration: BoxDecoration(
              border: Border.all(color: UiPalette.inputBorder),
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[Color(0xFFE7E7E7), Color(0xFFBDBDBD)],
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Icon(Icons.first_page, color: Color(0xFFBFC4CA), size: 34),
                Icon(Icons.chevron_left, color: Color(0xFFBFC4CA), size: 34),
                Icon(Icons.play_arrow, color: Color(0xFFBFC4CA), size: 34),
                Icon(Icons.last_page, color: Color(0xFFBFC4CA), size: 34),
              ],
            ),
          ),
          const SizedBox(height: UiMetrics.space6),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SoftButton(label: 'Details', width: 92, height: 52),
              SoftButton(label: 'Search', width: 92, height: 52),
              SoftButton(label: 'Verify', width: 92, height: 52),
              SoftButton(label: 'Comm.', width: 92, height: 52),
              SoftButton(label: 'Delete', width: 92, height: 52),
              SoftButton(label: 'Export', width: 92, height: 52),
              SoftButton(label: 'CV', width: 92, height: 52),
            ],
          ),
        ],
      ),
    );
  }
}
