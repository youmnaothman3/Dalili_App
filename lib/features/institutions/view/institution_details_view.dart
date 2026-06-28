import 'package:dalili_app/core/constant/app_colors.dart';
import 'package:dalili_app/features/app_bar/controller/app_bar_controller.dart';
import 'package:dalili_app/features/app_bar/widgets/custom_app_bar.dart';
import 'package:dalili_app/features/institutions/controller/institution_details_controller.dart';
import 'package:dalili_app/features/institutions/view/widgets/institution_branches_tab.dart';
import 'package:dalili_app/features/institutions/view/widgets/institution_header_card.dart';
import 'package:dalili_app/features/institutions/view/widgets/institution_info_tab.dart';
import 'package:dalili_app/features/institutions/view/widgets/institution_transactions_tab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InstitutionDetailsView extends StatelessWidget {
  const InstitutionDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<InstitutionDetailsController>();
    Get.isRegistered<AppBarController>()
        ? Get.find<AppBarController>()
        : Get.put(AppBarController());

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

          final institution = controller.institution;

          return DefaultTabController(
            length: 3,
            child: Column(
              children: [
                CustomAppBar(title: institution.name),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        InstitutionHeaderCard(institution: institution),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 0,
                            vertical: 12,
                          ),
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
                          child: TabBar(
                            labelColor: AppColors.primary,
                            unselectedLabelColor: AppColors.textSecondary,
                            indicatorColor: AppColors.primary,
                            indicatorWeight: 3,
                            labelStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                            tabs: const [
                              Tab(text: ' معلومات المؤسسة'),
                              Tab(text: 'الأفرع التابعة'),
                              Tab(text: 'المعاملات'),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: TabBarView(
                            children: [
                              InstitutionInfoTab(institution: institution),
                              InstitutionBranchesTab(
                                branches: controller.branches,
                              ),
                              InstitutionTransactionsTab(
                                transactions: controller.transactions,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
