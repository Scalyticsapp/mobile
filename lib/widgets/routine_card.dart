import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';

class RoutineCard extends StatelessWidget {
  final String title;

  final String subtitle;

  final String time;

  final bool isDone;

  final bool showCheckbox;

  final bool showDivider;

  final bool forceActive;

  final VoidCallback? onTap;

  const RoutineCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.time,
    this.isDone = false,
    this.showCheckbox = true,
    this.showDivider = true,
    this.forceActive = false,
    this.onTap,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 14,
        ),
        decoration: BoxDecoration(
          border: showDivider
              ? const Border(
                  bottom: BorderSide(
                    color: AppColors.border,
                  ),
                )
              : null,
        ),
        child: Row(
          children: [
            /// CHECKBOX
            if (showCheckbox) ...[
              AnimatedContainer(
                duration: const Duration(
                  milliseconds: 200,
                ),
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: isDone ? AppColors.accent : Colors.transparent,
                  borderRadius: BorderRadius.circular(
                    6,
                  ),
                  border: Border.all(
                    color: isDone ? AppColors.accent : AppColors.border,
                    width: 1.5,
                  ),
                ),
                child: isDone
                    ? const Icon(
                        Icons.check_rounded,
                        size: 14,
                        color: Colors.black,
                      )
                    : null,
              ),
              const SizedBox(
                width: 12,
              ),
            ],

            /// TEXT
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppText.body.copyWith(
                      fontSize: 13,
                      color: forceActive
                          ? AppColors.textPrimary
                          : isDone
                              ? AppColors.muted
                              : AppColors.textPrimary,
                      decoration: forceActive
                          ? null
                          : isDone
                              ? TextDecoration.lineThrough
                              : null,
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    subtitle,
                    style: AppText.caption.copyWith(
                      fontSize: 10,
                      color: AppColors.muted2,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(
              width: 12,
            ),

            /// TIME
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 3,
              ),
              decoration: BoxDecoration(
                color: isDone || forceActive
                    ? AppColors.accent.withOpacity(
                        0.12,
                      )
                    : AppColors.s3,
                borderRadius: BorderRadius.circular(
                  6,
                ),
              ),
              child: Text(
                time,
                style: AppText.caption.copyWith(
                  fontSize: 10,
                  color: isDone || forceActive
                      ? AppColors.accent
                      : AppColors.muted,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
