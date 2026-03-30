class ReagentInfo {
  const ReagentInfo({
    required this.type,
    required this.lotNo,
    required this.remainingVolume,
    required this.percent,
    required this.originalCapacity,
    required this.expiredDate,
  });

  final String type;
  final String lotNo;
  final String remainingVolume;
  final String percent;
  final String originalCapacity;
  final String expiredDate;

  factory ReagentInfo.fromJson(Map<String, dynamic> json) {
    return ReagentInfo(
      type: (json['type'] ?? '').toString(),
      lotNo: (json['lotNo'] ?? json['lot_no'] ?? '').toString(),
      remainingVolume:
          (json['remainingVolume'] ?? json['remaining_volume'] ?? '')
              .toString(),
      percent: (json['percent'] ?? json['%'] ?? '').toString(),
      originalCapacity:
          (json['originalCapacity'] ?? json['original_capacity'] ?? '')
              .toString(),
      expiredDate: (json['expiredDate'] ?? json['expired_date'] ?? '')
          .toString(),
    );
  }

  List<String> toTableRow() {
    return <String>[
      type,
      lotNo,
      remainingVolume,
      percent,
      originalCapacity,
      expiredDate,
    ];
  }
}
