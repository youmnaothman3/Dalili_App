import 'package:dalili_app/features/transactions/data/model/transaction_model.dart';
import 'package:dalili_app/features/transactions/data/transactions_mock_data.dart';

class TransactionsRepository {
  Future<List<TransactionModel>> getTransactions({String? searchQuery}) async {
    final transactions = TransactionsMockData.getTransactions();

    if (searchQuery == null || searchQuery.trim().isEmpty) {
      return transactions;
    }

    final normalizedQuery = searchQuery.trim().toLowerCase();
    return transactions.where((transaction) {
      final matchesName = transaction.name.toLowerCase().contains(
        normalizedQuery,
      );
      final matchesInstitution = transaction.institutionName
          .toLowerCase()
          .contains(normalizedQuery);
      final matchesGovernorate = transaction.governorate.toLowerCase().contains(
        normalizedQuery,
      );

      return matchesName || matchesInstitution || matchesGovernorate;
    }).toList();
  }
}
