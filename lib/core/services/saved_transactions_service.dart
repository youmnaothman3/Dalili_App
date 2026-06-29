import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SavedTransactionsService extends GetxService {
  static const String _storageKey = 'saved_transactions';

  late final GetStorage _storage;
  final RxList<String> savedTransactionIds = <String>[].obs;

  Future<SavedTransactionsService> init() async {
    _storage = GetStorage();
    final saved = _storage.read<List>(_storageKey);
    final ids = (saved ?? <dynamic>[]).whereType<String>().toList();
    savedTransactionIds.assignAll(ids);
    return this;
  }

  bool isSaved(String transactionId) =>
      savedTransactionIds.contains(transactionId);

  Future<void> toggleSave(String transactionId) async {
    if (isSaved(transactionId)) {
      savedTransactionIds.remove(transactionId);
    } else {
      savedTransactionIds.add(transactionId);
    }

    await _persist();
  }

  Future<void> _persist() async {
    await _storage.write(_storageKey, savedTransactionIds.toList());
  }
}
