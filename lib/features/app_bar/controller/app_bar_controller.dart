import 'package:dalili_app/core/constant/app_strings.dart';
import 'package:dalili_app/features/app_bar/model/app_bar_menu_item_model.dart';
import 'package:dalili_app/features/app_bar/model/app_bar_notification_model.dart';
import 'package:dalili_app/features/app_bar/widgets/notifications_overlay.dart';
import 'package:dalili_app/features/app_bar/widgets/profile_overlay.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum AppBarOverlayType { none, profile, notifications }

class AppBarController extends GetxController {
  // State Management
  final unreadNotifications = 4.obs;
  final activeOverlay = AppBarOverlayType.none.obs;
  OverlayEntry? _overlayEntry;

  // Data
  final profileMenuItems = <AppBarMenuItem>[];
  final notificationItems = <AppBarNotificationItem>[];

  AppBarController() {
    profileMenuItems.addAll([
      AppBarMenuItem(
        title: AppStrings.profile,
        icon: Icons.person,
        action: hideOverlay,
      ),
      AppBarMenuItem(
        title: AppStrings.settings,
        icon: Icons.settings,
        action: hideOverlay,
      ),
      AppBarMenuItem(
        title: AppStrings.help,
        icon: Icons.help_outline,
        action: hideOverlay,
      ),
      AppBarMenuItem(
        title: AppStrings.logout,
        icon: Icons.logout,
        action: hideOverlay,
      ),
    ]);

    notificationItems.addAll([
      AppBarNotificationItem(
        title: 'تم إضافة مرحلة جديدة',
        description: 'إلى معاملة نقل ملكية سيارة',
        time: 'منذ 5 دقائق',
        icon: Icons.directions_car,
      ),
      AppBarNotificationItem(
        title: 'تم الرد على الشكوى الخاصة بك',
        description: 'راجع التفاصيل لمعرفة الخطوات التالية',
        time: 'منذ 30 دقيقة',
        icon: Icons.chat_bubble_outline,
      ),
      AppBarNotificationItem(
        title: 'تحديث في بيانات مؤسسة النقل',
        description: 'تم تحديث المعلومات العامة',
        time: 'منذ ساعة',
        icon: Icons.apartment,
      ),
      AppBarNotificationItem(
        title: 'تم إصدار فاتورة جديدة للدفع',
        description: 'يرجى مراجعة الفاتورة في حسابك',
        time: 'منذ ساعتين',
        icon: Icons.receipt_long,
      ),
    ]);
  }

  void toggleOverlay(
    BuildContext context,
    AppBarOverlayType type,
    GlobalKey key,
  ) {
    if (activeOverlay.value == type) {
      hideOverlay();
      return;
    }

    hideOverlay();
    activeOverlay.value = type;

    final renderBox = key.currentContext?.findRenderObject() as RenderBox?;
    final overlayState = Overlay.of(context);
    if (renderBox == null || overlayState == null) {
      activeOverlay.value = AppBarOverlayType.none;
      return;
    }

    final offset = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (_) => _buildOverlay(context, type, offset, size),
    );

    overlayState.insert(_overlayEntry!);
  }

  void hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    activeOverlay.value = AppBarOverlayType.none;
  }

  Widget _buildOverlay(
    BuildContext context,
    AppBarOverlayType type,
    Offset buttonOffset,
    Size buttonSize,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;
    const overlayWidth = 320.0;
    final left = buttonOffset.dx.clamp(16.0, screenWidth - overlayWidth - 16.0);

    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            onTap: hideOverlay,
            behavior: HitTestBehavior.translucent,
            child: const SizedBox.expand(),
          ),
        ),
        Positioned(
          left: left,
          top: buttonOffset.dy + buttonSize.height + 8,
          width: overlayWidth,
          child: Material(
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 28,
                    offset: Offset(0, 12),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 18,
                  horizontal: 16,
                ),
                child: type == AppBarOverlayType.profile
                    ? ProfileOverlay(profileMenuItems: profileMenuItems)
                    : NotificationsOverlay(
                        notificationItems: notificationItems,
                        unreadNotifications: unreadNotifications,
                        onShowAllNotifications: showAllNotifications,
                      ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void showAllNotifications() {
    hideOverlay();
    Get.snackbar(
      'الإشعارات',
      'عرض كل الإشعارات',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.white,
      colorText: Colors.black87,
      margin: const EdgeInsets.all(16),
      borderRadius: 16,
    );
  }

  @override
  void onClose() {
    hideOverlay();
    super.onClose();
  }
}
