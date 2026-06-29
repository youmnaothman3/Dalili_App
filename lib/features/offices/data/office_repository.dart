import 'package:dalili_app/features/transactions/data/office_details_mock_data.dart';
import 'package:dalili_app/features/transactions/data/model/office_model.dart';

class OfficeRepository {
  Future<List<OfficeModel>> getOffices() async {
    return OfficeDetailsMockData.getOffices();
  }

  Future<OfficeModel?> getOfficeById(String id) async {
    final list = await getOffices();
    try {
      return list.firstWhere((o) => o.id == id);
    } catch (e) {
      return null;
    }
  }
}
