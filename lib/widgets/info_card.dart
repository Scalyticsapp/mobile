import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';

class InfoCard
    extends StatelessWidget {
  final String title;

  final String value;

  final String subtitle;

  const InfoCard({
    super.key,

    required this.title,

    required this.value,

    required this.subtitle,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      width: double.infinity,

      padding:
          const EdgeInsets.fromLTRB(
        14,
        16,
        16,
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
          Container(
            width: 36,
            height: 4,

            decoration:
                BoxDecoration(
              color:
                  AppColors.accent,

              borderRadius:
                  BorderRadius.circular(
                20,
              ),
            ),
          ),

          const SizedBox(
            height: 12,
          ),

          Text(
            title,

            style:
                AppText.body.copyWith(
              fontWeight:
                  FontWeight.w600,
            ),
          ),

          const SizedBox(
            height: 10,
          ),

          Text(
            value,

            style:
                AppText.caption.copyWith(
              height: 1.5,
            ),
          ),

          const SizedBox(
            height: 6,
          ),

          Text(
            subtitle,

            style:
                AppText.caption.copyWith(
              color:
                  Colors.white54,

              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}