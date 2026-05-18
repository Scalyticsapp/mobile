import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';

import 'app_card.dart';

class NotificationItem
    extends StatelessWidget {
  final IconData icon;

  final String title;

  final String desc;

  final String time;

  final VoidCallback? onTap;

  final bool isPrimary;

  const NotificationItem({
    super.key,

    required this.icon,

    required this.title,

    required this.desc,

    required this.time,

    required this.onTap,

    this.isPrimary = false,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Padding(
      padding:
          EdgeInsets.only(
        bottom:
            isPrimary ? 16 : 14,
      ),

      child: AppCard(
        onTap: onTap,

        padding:
            EdgeInsets.all(
          isPrimary ? 18 : 16,
        ),

        child: Row(
          crossAxisAlignment:
              CrossAxisAlignment
                  .start,

          children: [
            /// ICON
            Container(
              width:
                  isPrimary ? 62 : 56,

              height:
                  isPrimary ? 62 : 56,

              decoration:
                  BoxDecoration(
                borderRadius:
                    BorderRadius
                        .circular(
                  isPrimary ? 20 : 18,
                ),

                color: AppColors
                    .accent
                    .withOpacity(
                  0.12,
                ),
              ),

              child: Icon(
                icon,

                color:
                    AppColors.accent,

                size:
                    isPrimary ? 30 : 24,
              ),
            ),

            const SizedBox(
              width: 14,
            ),

            /// CONTENT
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                children: [
                  Text(
                    title,

                    maxLines:
                        isPrimary ? 2 : 1,

                    overflow:
                        TextOverflow
                            .ellipsis,

                    style: AppText
                        .body
                        .copyWith(
                      fontSize:
                          isPrimary ? 15 : 14,

                      fontWeight:
                          FontWeight.w600,
                    ),
                  ),

                  SizedBox(
                    height:
                        isPrimary ? 8 : 6,
                  ),

                  Text(
                    desc,

                    maxLines:
                        isPrimary ? 3 : 2,

                    overflow:
                        TextOverflow
                            .ellipsis,

                    style: AppText
                        .caption
                        .copyWith(
                      fontSize:
                          isPrimary
                              ? 11.5
                              : 11,

                      height:
                          1.6,
                    ),
                  ),

                  if (isPrimary) ...[
                    const SizedBox(
                      height: 16,
                    ),

                    Row(
                      children: [
                        Text(
                          'Mulai Scan AI',

                          style: AppText
                              .body
                              .copyWith(
                            color:
                                AppColors
                                    .accent,

                            fontWeight:
                                FontWeight
                                    .w600,

                            fontSize:
                                13,
                          ),
                        ),

                        const SizedBox(
                          width: 6,
                        ),

                        const Icon(
                          Icons
                              .arrow_forward_ios_rounded,

                          size: 15,

                          color:
                              AppColors
                                  .accent,
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(
              width: 12,
            ),

            /// RIGHT SIDE
            Column(
              crossAxisAlignment:
                  CrossAxisAlignment
                      .end,

              children: [
                Text(
                  time,

                  style: AppText
                      .caption
                      .copyWith(
                    fontSize:
                        isPrimary
                            ? 11
                            : 10.5,

                    color:
                        isPrimary
                            ? AppColors
                                .accent
                            : AppColors
                                .muted2,

                    fontWeight:
                        isPrimary
                            ? FontWeight
                                .w600
                            : FontWeight
                                .w400,
                  ),
                ),

                SizedBox(
                  height:
                      isPrimary ? 4 : 18,
                ),

                isPrimary
                    ? Container(
                        width: 7,
                        height: 7,

                        decoration:
                            const BoxDecoration(
                          color:
                              AppColors
                                  .accent,

                          shape:
                              BoxShape
                                  .circle,
                        ),
                      )
                    : const Icon(
                        Icons
                            .chevron_right_rounded,

                        size: 20,

                        color:
                            AppColors
                                .muted2,
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}