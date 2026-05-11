import 'package:dalili_app/core/constant/app_colors.dart';
import 'package:dalili_app/core/constant/app_images.dart';
import 'package:dalili_app/core/constant/app_strings.dart';
import 'package:dalili_app/core/routes/route_class.dart';
import 'package:dalili_app/features/sign_in/controller/sign_in_controller.dart';
import 'package:dalili_app/helper/app_helper.dart';
import 'package:dalili_app/widgets/custom_button.dart';
import 'package:dalili_app/widgets/custom_text_field.dart';
import 'package:dalili_app/widgets/wait_dialod.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInView extends GetView<SignInController> {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignInController());

    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: Stack(
              children: [
                Image.asset(AppImages.image_auth, fit: BoxFit.cover),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withOpacity(0.95),
                        Colors.white.withOpacity(0.85),
                        Colors.white.withOpacity(0.5),
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

          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 520),
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.symmetric(
                    vertical: 28,
                    horizontal: 24,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 28,
                        offset: Offset(0, 14),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(AppImages.logo, height: 90),
                      ),

                      const SizedBox(height: 16),

                      Text(
                        AppStrings.appTitle,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        AppStrings.subtitle,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),

                      const SizedBox(height: 22),

                      const Text(
                        'مرحباً بك',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),

                      const SizedBox(height: 6),

                      const Text(
                        'يرجى إدخال بياناتك لتسجيل الدخول',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                        ),
                      ),

                      const SizedBox(height: 26),

                      Obx(
                        () => CustomTextField(
                          // label: AppStrings.phone,
                          label: controller.phoneController.value.text,
                          hint: AppStrings.phoneHint,
                          icon: Icons.phone,
                          controller: controller.phoneController.value,
                        ),
                      ),

                      Obx(
                        () => CustomTextField(
                          label: AppStrings.password,
                          hint: AppStrings.passwordHint,
                          icon: !controller.showPassword.value
                              ? Icons.lock
                              : Icons.lock_open,
                          controller: controller.passwordController.value,
                          isPassword: !controller.showPassword.value,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: const Size(40, 30),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: const Text(
                              'نسيت كلمة السر؟',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Obx(
                            () => Row(
                              children: [
                                Text(
                                  'تذكرني',
                                  style: TextStyle(
                                    color: AppColors.textSecondary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Switch(
                                  value: controller.rememberMe.value,
                                  onChanged: (value) {
                                    controller.rememberMe.value = value;
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      CustomButton(
                        text: 'تسجيل الدخول',
                        // onPressed: () => Get.toNamed(Routes.home),
                        onPressed: () {
                          controller.signIn(context);
                          Get.toNamed(Routes.home);
                        },
                        isLoading: controller.isLoading,
                      ),

                      const SizedBox(height: 18),

                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: AppColors.border,
                              thickness: 1,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              'أو',
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: AppColors.border,
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 14),

                      TextButton(
                        onPressed: () {
                          Get.toNamed(Routes.signup);
                        },
                        child: const Text(
                          'ليس لديك حساب؟ إنشاء حساب جديد',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.shield,
                            size: 16,
                            color: AppColors.textSecondary,
                          ),
                          SizedBox(width: 6),
                          Text(
                            'جميع البيانات محمية وآمنة',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 12,
                            ),
                          ),
                        ],
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
