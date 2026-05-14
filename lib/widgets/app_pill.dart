import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class AppPill extends StatelessWidget {
  final String label;
  final Color color;
  final Color borderColor;
  final Color textColor;

  const AppPill({
    super.key,
    required this.label,
    required this.color,
    required this.borderColor,
    required this.textColor,
  });

  factory AppPill.green(
    String label,
  ) =>
      AppPill(
        label: label,
        color:
            const Color(0x1AC8F064),
        borderColor:
            const Color(0x40C8F064),
        textColor:
            AppColors.accent,
      );

  factory AppPill.yellow(
    String label,
  ) =>
      AppPill(
        label: label,
        color:
            const Color(0x1AF0C96B),
        borderColor:
            const Color(0x4DF0C96B),
        textColor:
            AppColors.yellow,
      );

  factory AppPill.red(
    String label,
  ) =>
      AppPill(
        label: label,
        color:
            const Color(0x1AE8594C),
        borderColor:
            const Color(0x4DE8594C),
        textColor:
            AppColors.red,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius:
            BorderRadius.circular(20),
        border: Border.all(
          color: borderColor,
        ),
      ),
      child: Text(
        label,
        style:
            AppText.caption.copyWith(
          color: textColor,
          fontSize: 10,
        ),
      ),
    );
  }
}