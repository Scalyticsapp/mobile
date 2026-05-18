import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';

class OptionTile
    extends StatelessWidget {
  final String label;

  final int index;

  final bool isSelected;

  final VoidCallback onTap;

  const OptionTile({
    super.key,

    required this.label,

    required this.index,

    required this.isSelected,

    required this.onTap,
  });

  static const _letters = [
    'A',
    'B',
    'C',
  ];

  @override
  Widget build(
    BuildContext context,
  ) {
    return Padding(
      padding:
          const EdgeInsets.only(
        bottom: 10,
      ),

      child: GestureDetector(
        onTap: onTap,

        child: AnimatedContainer(
          duration:
              const Duration(
            milliseconds: 180,
          ),

          width: double.infinity,

          padding:
              const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 16,
          ),

          decoration: BoxDecoration(
            color:
                isSelected
                    ? AppColors
                        .accent
                        .withOpacity(
                          0.14,
                        )
                    : AppColors.s2,

            borderRadius:
                BorderRadius.circular(
              16,
            ),

            border: Border.all(
              color:
                  isSelected
                      ? AppColors
                          .accent
                      : AppColors
                          .border,

              width:
                  isSelected
                      ? 1.5
                      : 1,
            ),
          ),

          child: Row(
            children: [
              /// LETTER BOX
              AnimatedContainer(
                duration:
                    const Duration(
                  milliseconds:
                      180,
                ),

                width: 30,
                height: 30,

                decoration:
                    BoxDecoration(
                  color:
                      isSelected
                          ? AppColors
                              .accent
                          : AppColors
                              .s3,

                  borderRadius:
                      BorderRadius
                          .circular(
                    10,
                  ),
                ),

                child: Center(
                  child: Text(
                    _letters[index],

                    style: TextStyle(
                      color:
                          isSelected
                              ? Colors
                                  .black
                              : AppColors
                                  .muted,

                      fontWeight:
                          FontWeight
                              .bold,

                      fontSize: 12,
                    ),
                  ),
                ),
              ),

              const SizedBox(
                width: 12,
              ),

              /// LABEL
              Expanded(
                child: Text(
                  label,

                  style: AppText
                      .body
                      .copyWith(
                    fontSize: 13,

                    color:
                        isSelected
                            ? AppColors
                                .accent
                            : AppColors
                                .textPrimary,

                    fontWeight:
                        isSelected
                            ? FontWeight
                                .w600
                            : FontWeight
                                .normal,
                  ),
                ),
              ),

              /// CHECK ICON
              AnimatedOpacity(
                duration:
                    const Duration(
                  milliseconds:
                      180,
                ),

                opacity:
                    isSelected
                        ? 1
                        : 0,

                child: const Icon(
                  Icons
                      .check_circle_rounded,

                  color:
                      AppColors.accent,

                  size: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}