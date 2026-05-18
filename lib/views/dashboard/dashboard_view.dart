import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controllers/dashboard_controller.dart';
import '../../controllers/progress_controller.dart';

import '../../core/theme/app_theme.dart';

import '../../routes/app_routes.dart';

import '../../widgets/app_bottom_nav.dart';
import '../../widgets/app_card.dart';
import '../../widgets/background_glow.dart';
import '../../widgets/section_title.dart';
import '../../widgets/routine_card.dart';

class DashboardView
    extends GetView<DashboardController> {
  DashboardView({
    super.key,
  });

  final ProgressController
      progressController =
      Get.put(
    ProgressController(),
  );

  static const int _tabIndex = 0;

  @override
  Widget build(
    BuildContext context,
  ) {
    WidgetsBinding.instance
        .addPostFrameCallback(
      (_) {
        controller.selectedTab.value =
            _tabIndex;
      },
    );

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  const BackgroundGlow(),

                  SingleChildScrollView(
                    physics:
                        const BouncingScrollPhysics(),

                    padding:
                        const EdgeInsets.only(
                      bottom: 24,
                    ),

                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,

                      children: [
                        _buildHeader(),

                        const SizedBox(
                          height: 18,
                        ),

                        _buildHeroCard(),

                        const SizedBox(
                          height: 18,
                        ),

                        Padding(
                          padding:
                              const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),

                          child:
                              _buildQuickScanBtn(),
                        ),

                        const SizedBox(
                          height: 22,
                        ),

                        /// DAILY PLAN
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),

                          child:
                              _buildDailyPlan(),
                        ),

                        const SizedBox(
                          height: 22,
                        ),

                        /// PROGRESS
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),

                          child:
                              Column(
                            crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,

                            children: [
                              const SectionTitle(
                                'PROGRES MINGGUAN',
                              ),

                              const SizedBox(
                                height: 12,
                              ),

                              _buildProgressCard(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            /// NAVBAR
            Padding(
              padding:
                  const EdgeInsets.only(
                left: 10,
                right: 10,
                bottom: 10,
              ),

              child: Obx(
                () => AppBottomNav(
                  currentIndex:
                      controller
                          .selectedTab
                          .value,

                  onTap: (index) =>
                      controller
                          .navigateTo(
                    _tabIndex,
                    index,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// HEADER
  Widget _buildHeader() {
    return Padding(
      padding:
          const EdgeInsets.fromLTRB(
        18,
        18,
        18,
        0,
      ),

      child: Row(
        mainAxisAlignment:
            MainAxisAlignment
                .spaceBetween,

        children: [
          Column(
            crossAxisAlignment:
                CrossAxisAlignment
                    .start,

            children: [
              Text(
                'Halo, Delia',

                style:
                    AppText.heading.copyWith(
                  fontSize: 24,
                ),
              ),

              const SizedBox(
                height: 4,
              ),

              Text(
                'Pantau kesehatan scalp-mu hari ini',

                style:
                    AppText.caption.copyWith(
                  fontSize: 11,
                ),
              ),
            ],
          ),

          GestureDetector(
            onTap: () =>
                Get.toNamed(
              AppRoutes.notification,
            ),

            child: Stack(
              children: [
                Container(
                  padding:
                      const EdgeInsets.all(
                    11,
                  ),

                  decoration:
                      BoxDecoration(
                    shape:
                        BoxShape.circle,

                    color: AppColors
                        .accent
                        .withOpacity(
                      0.06,
                    ),

                    border: Border.all(
                      color: AppColors
                          .accent
                          .withOpacity(
                        0.25,
                      ),
                    ),
                  ),

                  child: const Icon(
                    Icons
                        .notifications_rounded,

                    size: 22,

                    color:
                        AppColors.accent,
                  ),
                ),

                Positioned(
                  top: 2,
                  right: 2,

                  child: Container(
                    width: 9,
                    height: 9,

                    decoration:
                        const BoxDecoration(
                      shape:
                          BoxShape.circle,

                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// HERO CARD
  Widget _buildHeroCard() {
    return Container(
      margin:
          const EdgeInsets.symmetric(
        horizontal: 16,
      ),

      padding:
          const EdgeInsets.all(
        22,
      ),

      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(
          24,
        ),

        gradient:
            const LinearGradient(
          begin: Alignment.topLeft,
          end:
              Alignment.bottomRight,

          colors: [
            Color(0xFF182500),
            Color(0xFF101A00),
          ],
        ),

        border: Border.all(
          color: AppColors.accent
              .withOpacity(0.18),
        ),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        mainAxisSize:
            MainAxisSize.min,

        children: [
          /// TITLE
          Text(
            'Seborrheic Dermatitis',

            style:
                AppText.headingMd.copyWith(
              fontSize: 22,

              fontWeight:
                  FontWeight.w700,

              height: 1.2,
            ),
          ),

          const SizedBox(
            height: 4,
          ),

          Text(
            'Ketombe',

            style:
                AppText.caption.copyWith(
              fontSize: 12,

              color: AppColors.accent
                  .withOpacity(0.8),

              fontWeight:
                  FontWeight.w500,
            ),
          ),

          const SizedBox(
            height: 10,
          ),

          /// LABEL
          Text(
            'Scalp Health Score',

            style:
                AppText.caption.copyWith(
              fontSize: 12,

              color:
                  AppColors.muted,
            ),
          ),

          const SizedBox(
            height: 12,
          ),

          /// SCORE
          Row(
            crossAxisAlignment:
                CrossAxisAlignment.end,

            children: [
              Text(
                '78%',

                style:
                    AppText.heading.copyWith(
                  fontSize: 42,

                  fontWeight:
                      FontWeight.w700,

                  color:
                      AppColors.accent,

                  height: 1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// QUICK SCAN
  Widget _buildQuickScanBtn() {
    return GestureDetector(
      onTap: () =>
          controller.navigateTo(
        _tabIndex,
        1,
      ),

      child: Container(
        padding:
            const EdgeInsets.all(
          18,
        ),

        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(
            20,
          ),

          gradient: LinearGradient(
            colors: [
              AppColors.accent
                  .withOpacity(0.18),

              AppColors.a2
                  .withOpacity(0.08),
            ],
          ),

          border: Border.all(
            color: AppColors.accent
                .withOpacity(0.25),
          ),
        ),

        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,

              decoration:
                  BoxDecoration(
                borderRadius:
                    BorderRadius.circular(
                  16,
                ),

                color: AppColors
                    .accent
                    .withOpacity(0.12),
              ),

              child: const Icon(
                Icons
                    .document_scanner_rounded,

                color:
                    AppColors.accent,

                size: 28,
              ),
            ),

            const SizedBox(
              width: 14,
            ),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                children: [
                  Text(
                    'Mulai Scan AI',

                    style:
                        AppText.body.copyWith(
                      fontWeight:
                          FontWeight.w700,

                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(
                    height: 3,
                  ),

                  Text(
                    'Deteksi kondisi scalp dan pantau perkembangannya',

                    style:
                        AppText.caption
                            .copyWith(
                      fontSize: 10.5,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(
              Icons
                  .arrow_forward_ios_rounded,

              size: 18,

              color:
                  AppColors.accent,
            ),
          ],
        ),
      ),
    );
  }

  /// DAILY PLAN
  Widget _buildDailyPlan() {
    return Obx(
      () {
        final done =
            progressController
                .dailyTasks
                .where(
                  (task) =>
                      task.isDone,
                )
                .length;

        final total =
            progressController
                .dailyTasks
                .length;

        return Column(
          crossAxisAlignment:
              CrossAxisAlignment
                  .start,

          children: [
            /// HEADER
            Row(
              mainAxisAlignment:
                  MainAxisAlignment
                      .spaceBetween,

              children: [
                const SectionTitle(
                  'PERAWATAN HARI INI',
                ),

                Text(
                  '$done/$total selesai',

                  style: AppText.sectionTitle.copyWith(
                    color: AppColors.accent,
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 10,
            ),

            /// DATE
            Text(
              DateFormat(
                'EEEE, d MMMM yyyy',
                'id',
              ).format(
                DateTime.now(),
              ),

              style: AppText.caption
                  .copyWith(
                color:
                    AppColors.muted,

                fontSize: 13,
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            /// PROGRESS BAR
            ClipRRect(
              borderRadius:
                  BorderRadius.circular(
                4,
              ),

              child:
                  LinearProgressIndicator(
                value: total == 0
                    ? 0
                    : done / total,

                backgroundColor:
                    AppColors.s3,

                valueColor:
                    const AlwaysStoppedAnimation(
                  AppColors.accent,
                ),

                minHeight: 4,
              ),
            ),

            const SizedBox(
              height: 15,
            ),


           /// TASK LIST
            AppCard(
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 4,
              ),

              child: Column(
                children:
                    progressController
                        .dailyTasks
                        .asMap()
                        .entries
                        .map(
                  (entry) {
                    final index =
                        entry.key;

                    final task =
                        entry.value;

                    return RoutineCard(
                      title: task.name,

                      subtitle:
                          task.duration,

                      time: task.time,

                      isDone:
                          task.isDone,

                      showDivider:
                          index !=
                              progressController
                                      .dailyTasks
                                      .length -
                                  1,

                      onTap: () {
                        progressController
                            .toggleTask(
                          index,
                        );
                      },
                    );
                  },
                ).toList(),
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            /// FOOTER
            Center(
              child: Row(
                mainAxisSize:
                    MainAxisSize.min,

                children: [
                  const Icon(
                    Icons
                        .autorenew_rounded,

                    size: 14,

                    color:
                        AppColors.accent,
                  ),

                  const SizedBox(
                    width: 6,
                  ),

                  Text(
                    'Rekomendasi diperbarui berdasarkan hasil scan terbaru',

                    style: AppText
                        .caption
                        .copyWith(
                      fontSize: 10,

                      color:
                          AppColors.muted2,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  /// PROGRESS CARD
  Widget _buildProgressCard() {
    return GestureDetector(
      onTap: () =>
          controller.navigateTo(
        _tabIndex,
        2,
      ),

      child: Container(
        padding:
            const EdgeInsets.all(
          16,
        ),

        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(
            20,
          ),

          color: AppColors.s1,

          border: Border.all(
            color:
                AppColors.border,
          ),
        ),

        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,

              decoration:
                  BoxDecoration(
                borderRadius:
                    BorderRadius.circular(
                  14,
                ),

                color: AppColors
                    .accent
                    .withOpacity(0.1),
              ),

              child: const Icon(
                Icons
                    .show_chart_rounded,

                color:
                    AppColors.accent,

                size: 24,
              ),
            ),

            const SizedBox(
              width: 14,
            ),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                children: [
                  Row(
                    children: [
                      Text(
                        '78',

                        style:
                            AppText.headingMd,
                      ),

                      const SizedBox(
                        width: 6,
                      ),

                      Text(
                        '→ +12%',

                        style: AppText
                            .caption
                            .copyWith(
                          color:
                              AppColors.green,

                          fontWeight:
                              FontWeight
                                  .w600,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 4,
                  ),

                  Text(
                    'Kondisi scalp membaik dibanding scan sebelumnya',

                    style:
                        AppText.caption
                            .copyWith(
                      fontSize: 10.5,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(
              Icons
                  .chevron_right_rounded,

              color:
                  AppColors.muted,
            ),
          ],
        ),
      ),
    );
  }
}