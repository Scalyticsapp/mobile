import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import 'app_card.dart';

class ConditionCard
    extends StatelessWidget {
  final String name;
  final String scientific;
  final double percent;
  final String cause;
  final Color color;

  const ConditionCard({
    super.key,
    required this.name,
    required this.scientific,
    required this.percent,
    required this.cause,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:
                MainAxisAlignment
                    .spaceBetween,
            crossAxisAlignment:
                CrossAxisAlignment
                    .start,
            children: [
              Column(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,
                children: [
                  Text(
                    name,
                    style:
                        AppText.body
                            .copyWith(
                      fontWeight:
                          FontWeight
                              .w600,
                    ),
                  ),

                  const SizedBox(
                    height: 2,
                  ),

                  Text(
                    scientific,
                    style:
                        AppText.caption
                            .copyWith(
                      fontSize: 10,
                    ),
                  ),
                ],
              ),

              Text(
                '${percent.toInt()}%',
                style:
                    AppText.heading
                        .copyWith(
                  fontSize: 22,
                  color: color,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          ClipRRect(
            borderRadius:
                BorderRadius.circular(
              4,
            ),
            child:
                LinearProgressIndicator(
              value: percent / 100,
              backgroundColor:
                  const Color(
                0x14FFFFFF,
              ),
              valueColor:
                  AlwaysStoppedAnimation(
                color,
              ),
              minHeight: 5,
            ),
          ),

          const SizedBox(height: 10),

          Container(
            padding:
                const EdgeInsets.only(
              top: 8,
            ),
            decoration:
                const BoxDecoration(
              border: Border(
                top: BorderSide(
                  color:
                      AppColors.border,
                ),
              ),
            ),
            child: Text(
              cause,
              style:
                  AppText.caption
                      .copyWith(
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}