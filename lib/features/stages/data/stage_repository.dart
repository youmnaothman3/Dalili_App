import 'package:dalili_app/features/transactions/data/stage_details_mock_data.dart';
import 'package:dalili_app/features/transactions/data/model/stage_model.dart';

class StageRepository {
  Future<List<StageModel>> getStages() async {
    return StageDetailsMockData.getStages();
  }

  Future<StageModel?> getStageById(String id) async {
    final list = await getStages();
    try {
      return list.firstWhere((s) => s.id == id);
    } catch (e) {
      return null;
    }
  }
}
