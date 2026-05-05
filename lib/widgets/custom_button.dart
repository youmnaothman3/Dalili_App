import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/constant/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final RxBool? isLoading;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SizedBox(
        width: double.infinity,
        height: 55,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          onPressed: isLoading?.value == true ? null : onPressed,
          child: isLoading?.value == true
              ? const CircularProgressIndicator(color: Colors.white)
              : Text(text),
        ),
      );
    });
  }
}
