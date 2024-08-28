import 'package:flutter/material.dart';

class MoreOption {
  final IconData icon;
  final String text;
  final VoidCallback onTap;
  final String routeName;
  final Widget? child;

  MoreOption({
    required this.icon,
    required this.text,
    required this.onTap,
    required this.routeName,
    this.child,
  });
}
