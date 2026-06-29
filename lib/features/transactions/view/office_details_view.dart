import 'package:dalili_app/core/constant/app_colors.dart';
import 'package:dalili_app/features/app_bar/controller/app_bar_controller.dart';
import 'package:dalili_app/features/app_bar/widgets/custom_app_bar.dart';
import 'package:dalili_app/features/transactions/controller/office_details_controller.dart';
import 'package:dalili_app/features/transactions/data/model/office_model.dart';
import 'package:dalili_app/features/transactions/view/widgets/info_section_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OfficeDetailsView extends GetView<OfficeDetailsController> {
  final OfficeModel office;

  const OfficeDetailsView({super.key, required this.office});

  @override
  Widget build(BuildContext context) {
    Get.isRegistered<AppBarController>()
        ? Get.find<AppBarController>()
        : Get.put(AppBarController());

    final controller = Get.isRegistered<OfficeDetailsController>()
        ? Get.find<OfficeDetailsController>()
        : Get.put(OfficeDetailsController());

    if (controller.office.value == null) {
      controller.office.value = office;
    }

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
                ],
              ),
            );
          }

          final currentOffice = controller.office.value ?? office;

          return Column(
            children: [
              CustomAppBar(title: currentOffice.name),
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
                              currentOffice.name,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'المكتب المعني بمتابعة المعاملة داخل المؤسسة',
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.textSecondary,
                                height: 1.6,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      InfoSectionCard(
                        title: 'اسم المؤسسة',
                        icon: Icons.account_balance_outlined,
                        items: [currentOffice.institutionName],
                      ),
                      const SizedBox(height: 12),
                      InfoSectionCard(
                        title: 'اسم الإدارة',
                        icon: Icons.business_outlined,
                        items: [currentOffice.departmentName],
                      ),
                      const SizedBox(height: 12),
                      InfoSectionCard(
                        title: 'موقع المكتب داخل المؤسسة',
                        icon: Icons.location_on_outlined,
                        items: [currentOffice.locationInsideInstitution],
                      ),
                      const SizedBox(height: 12),
                      InfoSectionCard(
                        title: 'ملاحظات الوصول',
                        icon: Icons.info_outline,
                        items: [currentOffice.notes],
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
}
