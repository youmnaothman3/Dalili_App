import 'package:dalili_app/core/constant/app_colors.dart';
import 'package:dalili_app/core/constant/app_images.dart';
import 'package:dalili_app/core/routes/route_class.dart';
import 'package:dalili_app/features/app_bar/controller/app_bar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends GetView<AppBarController> {
  final String title;
  final bool isRootScreen;
  final GlobalKey _profileKey = GlobalKey();
  final GlobalKey _notificationKey = GlobalKey();

  CustomAppBar({super.key, required this.title, this.isRootScreen = false});

  @override
  Widget build(BuildContext context) {
    final bool showBackButton = !isRootScreen && Navigator.of(context).canPop();

    return Container(
      height: kToolbarHeight,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      child: Obx(() {
        final activeOverlay = controller.activeOverlay.value;

        Widget rightChild() {
          if (isRootScreen) {
            return GestureDetector(
              onTap: _navigateToHome,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(AppImages.logo, fit: BoxFit.cover),
                ),
              ),
            );
          }

          if (showBackButton) {
            return GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    size: 16,
                    color: AppColors.primary,
                  ),
                ),
              ),
            );
          }

          return const SizedBox(width: 36, height: 36);
        }

        Widget leftChild() {
          if (!isRootScreen) {
            return const SizedBox(width: 36, height: 36);
          }

          return Row(
            children: [
              _buildIconButton(
                key: _notificationKey,
                icon: Icons.notifications,
                onTap: () => controller.toggleOverlay(
                  context,
                  AppBarOverlayType.notifications,
                  _notificationKey,
                ),
                badge: Obx(
                  () => controller.unreadNotifications.value > 0
                      ? const Positioned(
                          right: -2,
                          top: -2,
                          child: CircleAvatar(
                            radius: 6,
                            backgroundColor: Colors.red,
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
                isActive: activeOverlay == AppBarOverlayType.notifications,
              ),
              const SizedBox(width: 10),
              _buildIconButton(
                key: _profileKey,
                icon: Icons.person,
                onTap: () => controller.toggleOverlay(
                  context,
                  AppBarOverlayType.profile,
                  _profileKey,
                ),
                isActive: activeOverlay == AppBarOverlayType.profile,
              ),
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            rightChild(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  'دليل المعاملات الحكومية',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            leftChild(),
          ],
        );
      }),
    );
  }

  void _navigateToHome() {
    if (Get.currentRoute == Routes.home) {
      return;
    }

    var didFindHome = false;
    Get.until((route) {
      if (route.settings.name == Routes.home) {
        didFindHome = true;
        return true;
      }
      return false;
    });

    if (!didFindHome) {
      Get.offAllNamed(Routes.home);
    }
  }

  Widget _buildIconButton({
    required Key key,
    required IconData icon,
    required VoidCallback onTap,
    Widget? badge,
    bool isActive = false,
  }) {
    return GestureDetector(
      key: key,
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: isActive
                  ? AppColors.primary.withValues(alpha: 0.12)
                  : AppColors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 14,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: Icon(icon, color: AppColors.primary, size: 24),
          ),
          if (badge != null) badge,
        ],
      ),
    );
  }
}
