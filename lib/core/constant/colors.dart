import 'package:flutter/material.dart';

class AppColors {
  static const Color primarycolor = Color(0xFFB51E22);
  // static const Color red = Color(0xFFCC1E25);
  // static const Color white = Color(0xFFFFFFFF);
  // static const Color darkRed = Color(0xFF6B0F10);
  // static const Color black = Color(0xFF221E1F);
  static const Color cancelButtonColor = Color(0xC909635F);
  //static const Color textColor = Color(0xFF1E8F95);

  static const Color gradientStart = Color(0xFF1E8F95); // غامق Teal
  static const Color gradientEnd = Color(0xFF29B4B9); // لون اللوغو

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [
      Color(0xFF0F4F52), // غامق جدًا
      Color(0xFF1E8F95),
      Color(0xFF29B4B9),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
