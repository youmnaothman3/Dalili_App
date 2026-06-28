import 'package:dalili_app/core/constant/app_colors.dart';
import 'package:dalili_app/features/app_bar/controller/app_bar_controller.dart';
import 'package:dalili_app/features/app_bar/widgets/custom_app_bar.dart';
import 'package:dalili_app/features/institutions/controller/institutions_controller.dart';
import 'package:dalili_app/features/institutions/data/model/institution_model.dart';
import 'package:dalili_app/features/institutions/view/widgets/build_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InstitutionsView extends GetView<InstitutionsController> {
  const InstitutionsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(InstitutionsController());
    Get.isRegistered<AppBarController>()
        ? Get.find<AppBarController>()
        : Get.put(AppBarController());

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(title: 'المؤسسات'),
            Expanded(
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

                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      const Text(
                        'المؤسسات',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Search Bar
                      buildSearchBar(controller),
                      const SizedBox(height: 12),

                      // Location Filter
                      _buildLocationFilter(controller),
                      const SizedBox(height: 20),

                      // Institutions List
                      if (controller.institutions.isEmpty)
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 32),
                            child: Column(
                              children: [
                                const Icon(
                                  Icons.business_center_outlined,
                                  size: 64,
                                  color: AppColors.textSecondary,
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                  'لم يتم العثور على مؤسسات',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      else
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.institutions.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final institution = controller.institutions[index];
                            return _buildInstitutionCard(
                              institution,
                              () => controller.onInstitutionTap(institution),
                            );
                          },
                        ),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationFilter(InstitutionsController controller) {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(28),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 14,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: DropdownButton<String>(
            underline: const SizedBox(),
            isExpanded: true,
            borderRadius: BorderRadius.circular(28),
            value: controller.selectedLocation.value?.isEmpty ?? true
                ? 'كل المحافظات'
                : controller.selectedLocation.value,
            items: controller.locations
                .map(
                  (location) => DropdownMenuItem<String>(
                    value: location,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          size: 18,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          location,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
            onChanged: (value) => controller.onLocationChanged(value),
            selectedItemBuilder: (BuildContext context) {
              return controller.locations
                  .map<Widget>(
                    (item) => Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.textPrimary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Icon(
                          Icons.location_on_outlined,
                          size: 18,
                          color: AppColors.primary,
                        ),
                      ],
                    ),
                  )
                  .toList();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildInstitutionCard(Institution institution, VoidCallback onTap) {
    return InkWell(
      borderRadius: BorderRadius.circular(28),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(28),
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
            // Header: Title and Icon
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    Icons.account_balance,
                    size: 24,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        institution.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        institution.description,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Footer: Ministry and Location
            Row(
              children: [
                // Ministry
                Expanded(
                  child: Row(
                    children: [
                      const Icon(
                        Icons.business,
                        size: 14,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          institution.ministry,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),

                // Divider
                Container(width: 1, height: 16, color: const Color(0xFFE8E8E8)),
                const SizedBox(width: 12),

                // Location
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Text(
                          institution.location,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.right,
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Icon(
                        Icons.location_on_outlined,
                        size: 14,
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
