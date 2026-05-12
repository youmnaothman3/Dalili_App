import 'package:dalili_app/core/constant/app_colors.dart';
import 'package:dalili_app/features/app_bar/model/app_bar_menu_item_model.dart';
import 'package:flutter/material.dart';

class ProfileOverlay extends StatelessWidget {
  final List<AppBarMenuItem> profileMenuItems;

  const ProfileOverlay({super.key, required this.profileMenuItems});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'الحساب الشخصي',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          textAlign: TextAlign.right,
        ),
        const SizedBox(height: 12),
        ...profileMenuItems.map(
          (item) => InkWell(
            onTap: item.action,
            borderRadius: BorderRadius.circular(18),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: AppColors.primary.withOpacity(0.12),
                    child: Icon(item.icon, color: AppColors.primary, size: 20),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      item.title,
                      style: const TextStyle(
                        fontSize: 15,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: AppColors.primary,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
