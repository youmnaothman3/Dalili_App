import 'package:dalili_app/core/constant/app_colors.dart';
import 'package:dalili_app/core/routes/route_class.dart';
import 'package:dalili_app/features/app_bar/controller/app_bar_controller.dart';
import 'package:dalili_app/features/app_bar/widgets/custom_app_bar.dart';
import 'package:dalili_app/features/stages/controller/stage_controller.dart';
import 'package:dalili_app/features/transactions/data/model/stage_model.dart';
import 'package:dalili_app/features/transactions/view/widgets/info_section_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StageDetailsView extends GetView<StageController> {
  const StageDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.isRegistered<AppBarController>()
        ? Get.find<AppBarController>()
        : Get.put(AppBarController());

    final controller = Get.isRegistered<StageController>()
        ? Get.find<StageController>()
        : Get.put(StageController());

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          if (controller.hasError.value) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 64,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    controller.errorMessage.value,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: controller.retry,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'إعادة محاولة',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          final StageModel? stage = controller.stage.value;
          if (stage == null) {
            return const Center(child: Text('لا توجد بيانات للمرحلة'));
          }

          return Column(
            children: [
              CustomAppBar(title: stage.name),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
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
                            Text(
                              stage.name,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              stage.description,
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.textSecondary,
                                height: 1.6,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: [
                                _buildInfoChip(
                                  Icons.account_balance_outlined,
                                  stage.responsibleInstitution,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Obx(
                        () => InkWell(
                          onTap: controller.toggleStageCompletion,
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: controller.isStageCompleted.value
                                  ? const Color(0xFFE8F5E9)
                                  : AppColors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: controller.isStageCompleted.value
                                    ? Colors.green
                                    : AppColors.primary.withValues(alpha: 0.2),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  controller.isStageCompleted.value
                                      ? Icons.check_circle
                                      : Icons.radio_button_unchecked,
                                  color: controller.isStageCompleted.value
                                      ? Colors.green
                                      : AppColors.primary,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    controller.isStageCompleted.value
                                        ? 'تم إنجاز هذه المرحلة ✓'
                                        : 'تم إنجاز هذه المرحلة',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: controller.isStageCompleted.value
                                          ? Colors.green
                                          : AppColors.primary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      if (stage.institution != null)
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Get.toNamed(
                                Routes.institutionDetails,
                                arguments: stage.institution,
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
                      if (stage.office != null) const SizedBox(height: 12),
                      if (stage.office != null)
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Get.toNamed(
                                Routes.officeDetails,
                                arguments: {'officeId': stage.office!.id},
                              );
                            },
                            icon: const Icon(Icons.location_on_outlined),
                            label: const Text('عرض تفاصيل المكتب'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: AppColors.primary,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                                side: const BorderSide(
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ),
                        ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Get.toNamed(
                              Routes.feedback,
                              arguments: {
                                'stageId': stage.id,
                                'institutionId': stage.institution?.id ?? '',
                                'officeId': stage.office?.id ?? '',
                                'stageName': stage.name,
                                'institutionName': stage.responsibleInstitution,
                                'officeName': stage.office?.name ?? '',
                              },
                            );
                          },
                          icon: const Icon(Icons.rate_review_outlined),
                          label: const Text('تقديم تقييم أو شكوى'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.white,
                            foregroundColor: AppColors.primary,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                              side: const BorderSide(color: AppColors.primary),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      InfoSectionCard(
                        title: 'المستندات المطلوبة',
                        icon: Icons.description_outlined,
                        items: stage.requiredDocuments,
                      ),
                      const SizedBox(height: 12),
                      InfoSectionCard(
                        title: 'الرسوم المطلوبة',
                        icon: Icons.payments_outlined,
                        items: stage.requiredFees,
                      ),
                      const SizedBox(height: 12),
                      InfoSectionCard(
                        title: 'الأختام المطلوبة',
                        icon: Icons.verified_outlined,
                        items: stage.requiredStamps,
                      ),
                      const SizedBox(height: 12),
                      InfoSectionCard(
                        title: 'ملاحظات',
                        icon: Icons.note_alt_outlined,
                        items: stage.notes,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
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
