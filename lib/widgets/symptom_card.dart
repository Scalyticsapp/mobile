import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';

class SymptomCard
    extends StatelessWidget {
  final String title;

  final List<String> symptoms;

  const SymptomCard({
    super.key,

    required this.title,

    required this.symptoms,
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

          ...symptoms.map(
            (symptom) => Padding(
              padding:
                  const EdgeInsets.only(
                bottom: 8,
              ),

              child: Row(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                children: [
                  const Padding(
                    padding:
                        EdgeInsets.only(
                      top: 6,
                    ),

                    child: Icon(
                      Icons.circle,

                      size: 6,

                      color:
                          AppColors
                              .accent,
                    ),
                  ),

                  const SizedBox(
                    width: 8,
                  ),

                  Expanded(
                    child: Text(
                      symptom,

                      style: AppText
                          .caption
                          .copyWith(
                        height: 1.5,
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