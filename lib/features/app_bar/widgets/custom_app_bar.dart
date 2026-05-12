import 'package:dalili_app/core/constant/app_colors.dart';
import 'package:dalili_app/core/constant/app_images.dart';
import 'package:dalili_app/features/app_bar/controller/app_bar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends GetView<AppBarController> {
  final String title;
  final GlobalKey _profileKey = GlobalKey();
  final GlobalKey _notificationKey = GlobalKey();

  CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 14,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Obx(() {
            final activeOverlay = controller.activeOverlay.value;
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(AppImages.logo, fit: BoxFit.cover),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Row(
                  children: [
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
                    const SizedBox(width: 12),
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
                      isActive:
                          activeOverlay == AppBarOverlayType.notifications,
                    ),
                  ],
                ),
              ],
            );
          }),
        ],
      ),
    );
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
                  ? AppColors.primary.withOpacity(0.12)
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
