import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';

class FactorCard
    extends StatelessWidget {
  final List<String> factors;

  const FactorCard({
    super.key,
    required this.factors,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      width: double.infinity,

      padding:
          const EdgeInsets.all(
        16,
      ),

      decoration: BoxDecoration(
        color: AppColors.s2,

        borderRadius:
            BorderRadius.circular(
          16,
        ),

        border: Border.all(
          color: AppColors.border,
        ),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          Text(
            'Faktor Deteksi',

            style:
                AppText.body.copyWith(
              fontWeight:
                  FontWeight.w600,
            ),
          ),

          const SizedBox(
            height: 12,
          ),

          ...factors.map(
            (factor) => Padding(
              padding:
                  const EdgeInsets.only(
                bottom: 8,
              ),

              child: Row(
                children: [
                  const Icon(
                    Icons
                        .check_circle_rounded,

                    size: 16,

                    color:
                        AppColors
                            .accent,
                  ),

                  const SizedBox(
                    width: 8,
                  ),

                  Expanded(
                    child: Text(
                      factor,

                      style: AppText
                          .caption
                          .copyWith(
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}