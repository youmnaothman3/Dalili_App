import 'package:dalili_app/core/services/progress_service.dart';
import 'package:dalili_app/core/services/saved_transactions_service.dart';
import 'package:dalili_app/features/transactions/data/model/transaction_model.dart';
import 'package:dalili_app/features/transactions/data/transactions_mock_data.dart';
import 'package:get/get.dart';

class MyTransactionsController extends GetxController {
  final SavedTransactionsService _savedTransactionsService =
      Get.find<SavedTransactionsService>();
  final ProgressService _progressService = Get.find<ProgressService>();

  final transactions = <TransactionModel>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadTransactions();
  }

  Future<void> loadTransactions() async {
    isLoading.value = true;

    final savedIds = _savedTransactionsService.savedTransactionIds.toList();
    final allTransactions = TransactionsMockData.getTransactions();

    transactions.assignAll(
      allTransactions
          .where((transaction) => savedIds.contains(transaction.id))
          .toList(),
    );

    isLoading.value = false;
  }

  int completedStagesFor(TransactionModel transaction) {
    return _progressService
        .completedStageIdsForTransaction(transaction.id)
        .length;
  }

  int totalStagesFor(TransactionModel transaction) => transaction.stages.length;
}
