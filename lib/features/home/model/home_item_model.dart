import 'package:flutter/material.dart';

class HomeItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final String? route;

  const HomeItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    this.route,
  });
}
