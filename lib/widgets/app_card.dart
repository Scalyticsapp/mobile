import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';

class AppCard extends StatelessWidget {
  final Widget child;

  final EdgeInsetsGeometry? padding;

  final VoidCallback? onTap;

  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: padding ?? const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppColors.s1,
          borderRadius: BorderRadius.circular(
            22,
          ),
          border: Border.all(
            color: AppColors.border,
          ),
        ),
        child: child,
      ),
    );
  }
}
