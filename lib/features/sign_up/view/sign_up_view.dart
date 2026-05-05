import 'package:dalili_app/core/constant/app_colors.dart';
import 'package:dalili_app/core/constant/app_images.dart';
import 'package:dalili_app/core/constant/app_strings.dart';
import 'package:dalili_app/features/sign_up/contrller/sign_up_controller.dart';
import 'package:dalili_app/widgets/custom_button.dart';
import 'package:dalili_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());

    return Scaffold(
      body: Stack(
        children: [
          /// 🌅 الخلفية مع تدرج (حتى تبين الحواف)
          SizedBox.expand(
            child: Stack(
              children: [
                Image.asset(AppImages.background, fit: BoxFit.cover),

                /// Gradient overlay
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withOpacity(0.9),
                        Colors.white.withOpacity(0.6),
                        Colors.transparent,
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// المحتوى
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(20),

                  /// ✨ كرت بمنتصف الشاشة
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),

                  child: Column(
                    children: [
                      /// logo
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(AppImages.logo, height: 80),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        AppStrings.appTitle,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),

                      const SizedBox(height: 5),

                      Text(
                        AppStrings.subtitle,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),

                      const SizedBox(height: 20),

                      CustomTextField(
                        label: AppStrings.fullName,
                        hint: AppStrings.fullNameHint,
                        icon: Icons.person,
                        controller: controller.fullNameController,
                      ),

                      CustomTextField(
                        label: AppStrings.birthDate,
                        hint: AppStrings.birthDateHint,
                        icon: Icons.calendar_today,
                        controller: controller.birthDateController,
                      ),

                      CustomTextField(
                        label: AppStrings.phone,
                        hint: AppStrings.phoneHint,
                        icon: Icons.phone,
                        controller: controller.phoneController,
                      ),

                      CustomTextField(
                        label: AppStrings.password,
                        hint: AppStrings.passwordHint,
                        icon: Icons.lock,
                        controller: controller.passwordController,
                        isPassword: true,
                      ),

                      CustomTextField(
                        label: AppStrings.confirmPassword,
                        hint: AppStrings.confirmPasswordHint,
                        icon: Icons.lock,
                        controller: controller.confirmPasswordController,
                        isPassword: true,
                      ),

                      const SizedBox(height: 20),

                      CustomButton(
                        text: AppStrings.createBtn,
                        onPressed: controller.register,
                        isLoading: controller.isLoading,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
