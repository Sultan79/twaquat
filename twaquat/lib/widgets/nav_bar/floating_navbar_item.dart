import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/parser.dart';

class FloatingNavbarItem {
  final String? title;
  final String icon;
  final Widget? customWidget;

  FloatingNavbarItem({
    required this.icon,
    this.title,
    this.customWidget,
  }) : assert(icon != null || customWidget != null);
}
