import '../entities/reagent_info.dart';

abstract class MaintenanceRepository {
  Future<List<ReagentInfo>> fetchReagentInfo();
}
