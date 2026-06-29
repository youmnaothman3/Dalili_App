import 'package:dalili_app/features/transactions/data/transactions_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TransactionsRepository', () {
    late TransactionsRepository repository;

    setUp(() {
      repository = TransactionsRepository();
    });

    test(
      'filters transactions by transaction name, institution name and governorate',
      () async {
        final results = await repository.getTransactions(searchQuery: 'دمشق');

        expect(results, isNotEmpty);
        expect(
          results.any(
            (transaction) =>
                transaction.name.contains('دمشق') ||
                transaction.institutionName.contains('دمشق') ||
                transaction.governorate.contains('دمشق'),
          ),
          isTrue,
        );
      },
    );

    test('returns all transactions when search query is empty', () async {
      final results = await repository.getTransactions();

      expect(results.length, greaterThan(1));
    });
  });
}
