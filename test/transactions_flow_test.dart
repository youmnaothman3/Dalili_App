import 'package:dalili_app/features/transactions/data/office_details_repository.dart';
import 'package:dalili_app/features/transactions/data/stage_details_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Transactions flow repositories', () {
    test('stage repository returns ordered stages with details', () async {
      final repository = StageDetailsRepository();
      final stages = await repository.getStages();

      expect(stages, isNotEmpty);
      expect(stages.first.name, isNotEmpty);
      expect(stages.first.requiredDocuments, isNotEmpty);
      expect(stages.first.requiredFees, isNotEmpty);
    });

    test('office repository returns office details for a stage', () async {
      final repository = OfficeDetailsRepository();
      final offices = await repository.getOffices();

      expect(offices, isNotEmpty);
      expect(offices.first.name, isNotEmpty);
      expect(offices.first.institutionName, isNotEmpty);
    });
  });
}
