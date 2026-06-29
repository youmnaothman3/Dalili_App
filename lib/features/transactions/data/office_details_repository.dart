import 'package:dalili_app/features/transactions/data/model/office_model.dart';
import 'package:dalili_app/features/transactions/data/office_details_mock_data.dart';

class OfficeDetailsRepository {
  Future<List<OfficeModel>> getOffices() async {
    return OfficeDetailsMockData.getOffices();
  }
}
