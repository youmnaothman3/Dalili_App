import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProgressService extends GetxService {
  static const String _storageKey = 'transaction_progress';

  late final GetStorage _storage;
  final RxMap<String, List<String>> progressByTransaction =
      <String, List<String>>{}.obs;

  Future<ProgressService> init() async {
    _storage = GetStorage();
    final raw = _storage.read<Map>(_storageKey);
    final parsed = <String, List<String>>{};

    if (raw != null) {
      raw.forEach((key, value) {
        if (value is List) {
          parsed[key.toString()] = value.whereType<String>().toList();
        }
      });
    }

    progressByTransaction.assignAll(parsed);
    return this;
  }

  bool isStageCompleted(String transactionId, String stageId) {
    final completedStages = completedStageIdsForTransaction(transactionId);
    return completedStages.contains(stageId);
  }

  List<String> completedStageIdsForTransaction(String transactionId) {
    return List<String>.from(
      progressByTransaction[transactionId] ?? const <String>[],
    );
  }

  Future<void> toggleStageCompleted(
    String transactionId,
    String stageId,
  ) async {
    final completedStages = completedStageIdsForTransaction(
      transactionId,
    ).toList();

    if (completedStages.contains(stageId)) {
      completedStages.remove(stageId);
    } else {
      completedStages.add(stageId);
    }

    progressByTransaction[transactionId] = completedStages;
    await _persist();
  }

  Future<void> _persist() async {
    final data = <String, dynamic>{};
    progressByTransaction.forEach((key, value) {
      data[key] = value.toList();
    });
    await _storage.write(_storageKey, data);
  }
}
