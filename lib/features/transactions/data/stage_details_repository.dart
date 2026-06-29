import 'package:dalili_app/features/transactions/data/model/stage_model.dart';
import 'package:dalili_app/features/transactions/data/stage_details_mock_data.dart';

class StageDetailsRepository {
  Future<List<StageModel>> getStages() async {
    return StageDetailsMockData.getStages();
  }
}
