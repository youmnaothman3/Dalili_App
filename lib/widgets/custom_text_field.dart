import 'package:dalili_app/core/constant/app_strings.dart';
import 'package:dalili_app/features/sign_in/controller/sign_in_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import '../core/constant/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final String label;
  final IconData icon;
  final bool isPassword;
  final TextEditingController controller;

  const CustomTextField({
    super.key,
    required this.hint,
    required this.label,
    required this.icon,
    required this.controller,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // 👈 RTL
        children: [
          /// 🔹 label من اليمين
          Directionality(
            textDirection: TextDirection.rtl,
            child: Text(label, textAlign: TextAlign.right),
          ),

          const SizedBox(height: 6),

          /// 🔹 الحقل
          TextField(
            controller: controller,
            obscureText: isPassword,
            textAlign: TextAlign.right,

            decoration: InputDecoration(
              hintText: hint,
              filled: true,
              fillColor: Colors.grey.shade100,

              /// 👈 الأيقونة داخل الحقل من اليمين
              prefixIcon: Padding(
                padding: EdgeInsets.only(right: 10),
                child: (hint == AppStrings.passwordHint)
                    ? IconButton(
                        onPressed: () {
                          Get.find<SignInController>().changeShowPassword();
                        },
                        icon: Icon(icon, color: AppColors.primary),
                      )
                    : Icon(icon, color: AppColors.primary),
              ),
              prefixIconConstraints: const BoxConstraints(minWidth: 40),

              contentPadding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 10,
              ),

              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(color: AppColors.border),
              ),

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(
                  color: AppColors.primary,
                  width: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
