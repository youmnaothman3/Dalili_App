import 'package:dalili_app/features/feedback/data/model/feedback_model.dart';
import 'package:get_storage/get_storage.dart';

class FeedbackRepository {
  static const String _storageKey = 'feedbacks';

  late final GetStorage _storage;

  Future<FeedbackRepository> init() async {
    _storage = GetStorage();
    return this;
  }

  Future<List<FeedbackModel>> getFeedback() async {
    final raw = _storage.read<List>(_storageKey);
    if (raw == null) {
      return [];
    }

    return raw
        .whereType<Map>()
        .map((item) => FeedbackModel.fromJson(Map<String, dynamic>.from(item)))
        .toList();
  }

  Future<void> saveFeedback(FeedbackModel feedback) async {
    final currentFeedback = await getFeedback();
    currentFeedback.add(feedback);
    await _storage.write(
      _storageKey,
      currentFeedback.map((item) => item.toJson()).toList(),
    );
  }
}
