import 'package:dalili_app/core/constant/app_colors.dart';
import 'package:dalili_app/features/app_bar/widgets/custom_app_bar.dart';
import 'package:dalili_app/features/my_transactions/controller/my_transactions_controller.dart';
import 'package:dalili_app/features/my_transactions/view/widgets/saved_transaction_card.dart';
import 'package:dalili_app/core/routes/route_class.dart';
import 'package:dalili_app/features/transactions/data/model/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyTransactionsView extends GetView<MyTransactionsController> {
  const MyTransactionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(title: 'معاملاتي'),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  );
                }

                if (controller.transactions.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: Text(
                        'لا توجد معاملات محفوظة بعد. احفظ إحدى المعاملات للبدء.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: AppColors.textSecondary,
                          height: 1.6,
                        ),
                      ),
                    ),
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                  itemCount: controller.transactions.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final TransactionModel transaction =
                        controller.transactions[index];
                    return SavedTransactionCard(
                      transaction: transaction,
                      completedStages: controller.completedStagesFor(
                        transaction,
                      ),
                      totalStages: controller.totalStagesFor(transaction),
                      onTap: () => Get.toNamed(
                        Routes.transactionDetails,
                        arguments: transaction,
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
