import 'package:flutter/material.dart';

import 'domain/entities/reagent_info.dart';
import 'domain/repositories/maintenance_repository.dart';
import 'sections.dart';

class MaintenanceDailyPage extends StatefulWidget {
  const MaintenanceDailyPage({super.key, required this.repository});

  final MaintenanceRepository repository;

  @override
  State<MaintenanceDailyPage> createState() => _MaintenanceDailyPageState();
}

class _MaintenanceDailyPageState extends State<MaintenanceDailyPage> {
  static const List<String> _headers = <String>[
    'Type',
    'Lot No.',
    'Remaining volume',
    '%',
    'Original capacity',
    'Expired date',
  ];

  static const List<List<String>> _fallbackRows = <List<String>>[
    <String>['Diluent', 'Dil', '1000', '100.00', '1000', '2122-06-01'],
    <String>['Lyse', 'Lys', '100', '100.00', '100', '2122-06-01'],
  ];

  late final MaintenanceRepository _repository = widget.repository;

  late Future<List<ReagentInfo>> _future;

  @override
  void initState() {
    super.initState();
    _future = _repository.fetchReagentInfo();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ReagentInfo>>(
      future: _future,
      builder:
          (BuildContext context, AsyncSnapshot<List<ReagentInfo>> snapshot) {
            final List<MaintenanceSectionSpec> replaceSections =
                _buildReplaceReagentsSections(snapshot);

            return MaintenanceTabbedPage(
              initialTab: 'Replace Reagents',
              tabs: <MaintenanceTabSpec>[
                MaintenanceTabSpec(
                  label: 'Replace Reagents',
                  sections: replaceSections,
                ),
                const MaintenanceTabSpec(
                  label: 'Clean',
                  sections: <MaintenanceSectionSpec>[
                    MaintenanceActionRowSpec(
                      wrap: true,
                      wrapColumns: 2,
                      items: <MaintenanceActionItemSpec>[
                        MaintenanceActionItemSpec(
                          text: 'Liquid path\ncleaning',
                        ),
                        MaintenanceActionItemSpec(
                          text: 'Sampling\nprobe cleaning',
                        ),
                        MaintenanceActionItemSpec(
                          text: 'WBC chamber\ncleaning',
                        ),
                        MaintenanceActionItemSpec(
                          text: 'RBC chamber\ncleaning',
                        ),
                      ],
                    ),
                  ],
                ),
                const MaintenanceTabSpec(
                  label: 'Maintenance',
                  sections: <MaintenanceSectionSpec>[
                    MaintenanceActionRowSpec(
                      wrap: true,
                      wrapColumns: 2,
                      items: <MaintenanceActionItemSpec>[
                        MaintenanceActionItemSpec(
                          text: 'Aperture\nblockage\nremoval',
                        ),
                        MaintenanceActionItemSpec(text: 'Aperture\nburning'),
                        MaintenanceActionItemSpec(
                          text: 'Whole\nmachine conc.\nCleanser soak',
                        ),
                        MaintenanceActionItemSpec(text: 'Aperture\nBackflush'),
                      ],
                    ),
                  ],
                ),
                const MaintenanceTabSpec(
                  label: 'Whole machine maintenance',
                  sections: <MaintenanceSectionSpec>[
                    MaintenanceActionRowSpec(
                      wrap: true,
                      wrapColumns: 3,
                      items: <MaintenanceActionItemSpec>[
                        MaintenanceActionItemSpec(
                          text: 'Liquid path\nDrainage',
                        ),
                        MaintenanceActionItemSpec(
                          text: 'WBC chamber\ndrainage',
                        ),
                        MaintenanceActionItemSpec(
                          text: 'RBC chamber\ndrainage',
                        ),
                        MaintenanceActionItemSpec(text: 'Instrument\npack'),
                        MaintenanceActionItemSpec(text: 'Initialize'),
                      ],
                    ),
                  ],
                ),
              ],
            );
          },
    );
  }

  List<MaintenanceSectionSpec> _buildReplaceReagentsSections(
    AsyncSnapshot<List<ReagentInfo>> snapshot,
  ) {
    final List<MaintenanceSectionSpec> sections = <MaintenanceSectionSpec>[
      const MaintenanceActionRowSpec(
        title: 'Replace Reagents',
        items: <MaintenanceActionItemSpec>[
          MaintenanceActionItemSpec(text: 'All reagents'),
          MaintenanceActionItemSpec(text: 'Diluent'),
          MaintenanceActionItemSpec(text: 'Lyse'),
        ],
      ),
    ];
    final List<List<String>> rows = snapshot.hasData
        ? _normalizeRows(snapshot.data!)
        : _fallbackRows;

    sections.add(
      MaintenanceMatrixTableSpec(
        title: 'Reagent information',
        headers: _headers,
        rows: rows,
      ),
    );

    return sections;
  }

  List<List<String>> _normalizeRows(List<ReagentInfo> items) {
    if (items.isEmpty) {
      return const <List<String>>[
        <String>['-', '-', '-', '-', '-', '-'],
      ];
    }

    return items.map((ReagentInfo item) {
      final List<String> row = item.toTableRow();
      if (row.length >= _headers.length) {
        return row.take(_headers.length).toList();
      }
      return <String>[
        ...row,
        ...List<String>.filled(_headers.length - row.length, '-'),
      ];
    }).toList();
  }
}
