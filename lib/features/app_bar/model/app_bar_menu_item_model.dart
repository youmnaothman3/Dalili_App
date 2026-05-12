import 'package:flutter/material.dart';

class AppBarMenuItem {
  final String title;
  final IconData icon;
  final VoidCallback action;

  AppBarMenuItem({
    required this.title,
    required this.icon,
    required this.action,
  });
}
