import 'package:dalili_app/core/constant/app_colors.dart';
import 'package:dalili_app/core/constant/app_images.dart';
import 'package:dalili_app/core/constant/app_strings.dart';
import 'package:dalili_app/core/routes/route_class.dart';
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
          /// 🌅 الخلفية
          SizedBox.expand(
            child: Stack(
              children: [
                Image.asset(AppImages.image_auth, fit: BoxFit.cover),

                /// تدرج خفيف
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
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(20),

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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      /// LOGO
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(AppImages.logo, height: 80),
                      ),

                      const SizedBox(height: 10),

                      /// العنوان (أزرق)
                      Text(
                        AppStrings.appTitle,
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),

                      const SizedBox(height: 5),

                      /// subtitle
                      Text(
                        AppStrings.subtitle,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),

                      const SizedBox(height: 6),

                      /// خط تحت subtitle
                      Container(
                        width: 100,
                        height: 2,
                        color: AppColors.divider,
                      ),

                      const SizedBox(height: 20),

                      /// إنشاء حساب (أزرق)
                      Text(
                        AppStrings.createAccount,
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 5),

                      /// نص خفيف
                      Text(
                        AppStrings.fillData,
                        style: const TextStyle(
                          color: AppColors.lightText,
                          fontSize: 12,
                        ),
                      ),

                      const SizedBox(height: 20),

                      /// الحقول
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

                      /// زر إنشاء الحساب
                      CustomButton(
                        text: AppStrings.createBtn,
                        onPressed: () {
                          controller.register(context);
                        },
                        isLoading: controller.isLoading,
                      ),

                      const SizedBox(height: 20),

                      /// OR Divider
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 1,
                              color: AppColors.divider,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              AppStrings.or,
                              style: const TextStyle(
                                color: AppColors.lightText,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 1,
                              color: AppColors.divider,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      /// زر تسجيل الدخول
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: AppColors.primary),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        onPressed: () {
                          Get.toNamed(Routes.signIn);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.login, color: AppColors.primary),
                            const SizedBox(width: 8),
                            Text(
                              AppStrings.login,
                              style: const TextStyle(color: AppColors.primary),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 15),

                      Text(
                        AppStrings.secure,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.lightText,
                        ),
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
