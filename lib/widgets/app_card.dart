import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final double radius;
  final Color? color;
  final Color? borderColor;

  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.radius = 14,
    this.color,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          padding ??
          const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color ?? AppColors.s2,
        borderRadius:
            BorderRadius.circular(
          radius,
        ),
        border: Border.all(
          color:
              borderColor ??
              AppColors.border,
          width: 1,
        ),
      ),
      child: child,
    );
  }
}