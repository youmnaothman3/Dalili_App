import 'package:dalili_app/core/routes/route_class.dart';
import 'package:dalili_app/features/transactions/data/model/transaction_model.dart';
import 'package:dalili_app/features/transactions/data/transactions_repository.dart';
import 'package:get/get.dart';

class TransactionsController extends GetxController {
  final TransactionsRepository _repository = TransactionsRepository();

  final transactions = RxList<TransactionModel>([]);
  final isLoading = RxBool(false);
  final hasError = RxBool(false);
  final errorMessage = RxString('');
  final searchQuery = RxString('');

  @override
  void onInit() {
    super.onInit();
    loadTransactions();
  }

  Future<void> loadTransactions() async {
    try {
      isLoading.value = true;
      hasError.value = false;

      final results = await _repository.getTransactions(
        searchQuery: searchQuery.value.isNotEmpty ? searchQuery.value : null,
      );

      transactions.assignAll(results);
    } catch (e) {
      hasError.value = true;
      errorMessage.value = 'حدث خطأ في تحميل المعاملات: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> onSearch(String query) async {
    searchQuery.value = query;
    await loadTransactions();
  }

  void onTransactionTap(TransactionModel transaction) {
    Get.toNamed(Routes.transactionDetails, arguments: transaction);
  }

  void retry() => loadTransactions();
}
