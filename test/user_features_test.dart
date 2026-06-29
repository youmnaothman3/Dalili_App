import 'package:dalili_app/core/services/progress_service.dart';
import 'package:dalili_app/core/services/saved_transactions_service.dart';
import 'package:dalili_app/features/feedback/data/model/feedback_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:path_provider_windows/path_provider_windows.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  PathProviderPlatform.instance = PathProviderWindows();

  setUp(() async {
    await GetStorage.init();
  });

  test('saved transactions service toggles and persists ids', () async {
    final service = SavedTransactionsService();
    await service.init();
    await service.toggleSave('tx-1');
    expect(service.isSaved('tx-1'), isTrue);
    expect(service.savedTransactionIds, contains('tx-1'));

    await service.toggleSave('tx-1');
    expect(service.isSaved('tx-1'), isFalse);
  });

  test('progress service toggles completed stages per transaction', () async {
    final service = ProgressService();
    await service.init();
    await service.toggleStageCompleted('tx-1', 'stage-1');
    expect(service.isStageCompleted('tx-1', 'stage-1'), isTrue);
    await service.toggleStageCompleted('tx-1', 'stage-1');
    expect(service.isStageCompleted('tx-1', 'stage-1'), isFalse);
  });

  test('feedback model serializes correctly', () {
    final feedback = FeedbackModel(
      id: 'feed-1',
      stageId: 'stage-1',
      institutionId: 'inst-1',
      officeId: 'office-1',
      stageName: 'المرحلة الأولى',
      institutionName: 'المؤسسة',
      officeName: 'المكتب',
      rating: 5,
      complaintText: 'ملاحظة',
      submittedAt: DateTime.utc(2024, 1, 1),
    );

    final json = feedback.toJson();
    final decoded = FeedbackModel.fromJson(json);

    expect(decoded.id, 'feed-1');
    expect(decoded.rating, 5);
    expect(decoded.complaintText, 'ملاحظة');
  });
}
