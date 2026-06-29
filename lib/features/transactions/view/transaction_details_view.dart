import 'package:dalili_app/core/constant/app_colors.dart';
import 'package:dalili_app/core/routes/route_class.dart';
import 'package:dalili_app/core/services/progress_service.dart';
import 'package:dalili_app/core/services/saved_transactions_service.dart';
import 'package:dalili_app/features/app_bar/controller/app_bar_controller.dart';
import 'package:dalili_app/features/app_bar/widgets/custom_app_bar.dart';
import 'package:dalili_app/features/transactions/data/model/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionDetailsView extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionDetailsView({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    Get.isRegistered<AppBarController>()
        ? Get.find<AppBarController>()
        : Get.put(AppBarController());

    final savedTransactionsService = Get.find<SavedTransactionsService>();
    final progressService = Get.find<ProgressService>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(title: transaction.name),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSummaryCard(savedTransactionsService),
                    const SizedBox(height: 18),
                    _buildStagesCard(progressService),
                    const SizedBox(height: 18),
                    if (transaction.institution != null)
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Get.toNamed(
                              Routes.institutionDetails,
                              arguments: transaction.institution,
                            );
                          },
                          icon: const Icon(Icons.account_balance_outlined),
                          label: const Text('عرض تفاصيل المؤسسة'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(SavedTransactionsService savedTransactionsService) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 14,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  transaction.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ),
              Obx(
                () => IconButton(
                  onPressed: () =>
                      savedTransactionsService.toggleSave(transaction.id),
                  icon: Icon(
                    savedTransactionsService.isSaved(transaction.id)
                        ? Icons.bookmark
                        : Icons.bookmark_border,
                    color: AppColors.primary,
                    size: 24,
                  ),
                  tooltip: savedTransactionsService.isSaved(transaction.id)
                      ? 'إزالة من المعاملات'
                      : 'حفظ المعاملة',
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            transaction.description,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _buildInfoChip(
                Icons.account_balance_outlined,
                transaction.institutionName,
              ),
              _buildInfoChip(
                Icons.location_on_outlined,
                transaction.governorate,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStagesCard(ProgressService progressService) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 14,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'مراحل المعاملة',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 12),
          Obx(() {
            final completedIds = progressService
                .completedStageIdsForTransaction(transaction.id);
            final currentStageIndex = transaction.stages.indexWhere(
              (stage) => !completedIds.contains(stage.id),
            );

            return Column(
              children: transaction.stages.asMap().entries.map((entry) {
                final index = entry.key + 1;
                final stage = entry.value;
                final isCompleted = completedIds.contains(stage.id);
                final isCurrent =
                    !isCompleted && currentStageIndex == entry.key;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: InkWell(
                    onTap: () => Get.toNamed(
                      Routes.stageDetails,
                      arguments: {
                        'stageId': stage.id,
                        'transactionId': transaction.id,
                      },
                    ),
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isCompleted
                            ? const Color(0xFFE8F5E9)
                            : AppColors.background,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isCurrent
                              ? AppColors.primary
                              : AppColors.primary.withValues(alpha: 0.12),
                          width: isCurrent ? 2 : 1,
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              color: isCompleted
                                  ? Colors.green.withValues(alpha: 0.15)
                                  : (isCurrent
                                        ? AppColors.primary.withValues(
                                            alpha: 0.12,
                                          )
                                        : AppColors.primary.withValues(
                                            alpha: 0.08,
                                          )),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Center(
                              child: isCompleted
                                  ? const Icon(
                                      Icons.check,
                                      size: 16,
                                      color: Colors.green,
                                    )
                                  : Text(
                                      '$index',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primary,
                                      ),
                                    ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  stage.name,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  stage.responsibleInstitution,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: AppColors.primary,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  stage.shortDescription,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: AppColors.textSecondary,
                                    height: 1.4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppColors.primary),
          const SizedBox(width: 6),
          Text(
            value,
            style: const TextStyle(fontSize: 12, color: AppColors.primary),
          ),
        ],
      ),
    );
  }
}
