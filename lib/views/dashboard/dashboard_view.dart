import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controllers/dashboard_controller.dart';
import '../../controllers/progress_controller.dart';

import '../../theme/app_theme.dart';
import '../../widgets/shared_widgets.dart';
import '../../routes/app_routes.dart';

class DashboardView extends GetView<DashboardController> {

  DashboardView({super.key});

  final ProgressController progressController =
      Get.put(ProgressController());

  static const _tabIndex = 0;

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.selectedTab.value = _tabIndex;
    });

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [

            Expanded(
              child: Stack(
                children: [

                  const BackgroundGlow(),

                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: 24),

                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [

                        _buildHeader(),

                        const SizedBox(height: 18),

                        _buildHeroCard(),

                        const SizedBox(height: 18),

                        Padding(
                          padding:
                              const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),

                          child:
                              _buildQuickScanBtn(),
                        ),

                        const SizedBox(height: 22),

                        /// DAILY PLAN
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),

                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,

                            children: [

                              _buildDailyPlan(),
                            ],
                          ),
                        ),

                        const SizedBox(height: 22),

                        /// PROGRESS
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),

                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,

                            children: [

                              Text(
                                'PROGRES MINGGUAN',
                                style: AppText.label.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1.1,
                                ),
                              ),

                              const SizedBox(height: 12),

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
                      controller.selectedTab.value,

                  onTap: (i) =>
                      controller.navigateTo(
                    _tabIndex,
                    i,
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
            MainAxisAlignment.spaceBetween,

        children: [

          Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              Text(
                'Halo, Delia',
                style:
                    AppText.heading.copyWith(
                  fontSize: 24,
                ),
              ),

              const SizedBox(height: 4),

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
                      const EdgeInsets.all(11),

                  decoration: BoxDecoration(
                    shape: BoxShape.circle,

                    color: AppColors.accent
                        .withOpacity(0.06),

                    border: Border.all(
                      color: AppColors.accent
                          .withOpacity(0.25),
                    ),
                  ),

                  child: const Icon(
                    Icons
                        .notifications_rounded,
                    size: 22,
                    color: AppColors.accent,
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
                      shape: BoxShape.circle,
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
    margin: const EdgeInsets.symmetric(
      horizontal: 16,
    ),

    padding: const EdgeInsets.all(22),

    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(24),

      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF182500),
          Color(0xFF101A00),
        ],
      ),

      border: Border.all(
        color: AppColors.accent.withOpacity(0.18),
      ),
    ),

    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,

      children: [

        /// TITLE
        Text(
          'Seborrheic Dermatitis',
          style: AppText.headingMd.copyWith(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            height: 1.2,
          ),
        ),

        const SizedBox(height: 4),

        Text(
          'Ketombe',
          style: AppText.caption.copyWith(
            fontSize: 12,
            color: AppColors.accent.withOpacity(0.8),
            fontWeight: FontWeight.w500,
          ),
        ),

        const SizedBox(height: 10),

        /// LABEL
        Text(
          'Scalp Health Score',
          style: AppText.caption.copyWith(
            fontSize: 12,
            color: AppColors.muted,
          ),
        ),

        const SizedBox(height: 12),

        /// SCORE
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [

            Text(
              '78%',
              style: AppText.heading.copyWith(
                fontSize: 42,
                fontWeight: FontWeight.w700,
                color: AppColors.accent,
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
        padding: const EdgeInsets.all(18),

        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(20),

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

              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(
                  16,
                ),

                color: AppColors.accent
                    .withOpacity(0.12),
              ),

              child: const Icon(
                Icons
                    .document_scanner_rounded,
                color: AppColors.accent,
                size: 28,
              ),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

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

                  const SizedBox(height: 3),

                  Text(
                    'Deteksi kondisi scalp dan pantau perkembangannya',
                    style:
                        AppText.caption.copyWith(
                      fontSize: 10.5,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 18,
              color: AppColors.accent,
            ),
          ],
        ),
      ),
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
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(20),

        color: AppColors.s1,

        border: Border.all(
          color: AppColors.border,
        ),
      ),

      child: Row(
        children: [

          Container(
            width: 48,
            height: 48,

            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(
                14,
              ),

              color: AppColors.accent
                  .withOpacity(0.1),
            ),

            child: const Icon(
              Icons.show_chart_rounded,
              color: AppColors.accent,
              size: 24,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Row(
                  children: [

                    Text(
                      '78',
                      style:
                          AppText.headingMd,
                    ),

                    const SizedBox(width: 6),

                    Text(
                      '→ +12%',
                      style:
                          AppText.caption.copyWith(
                        color:
                            AppColors.green,
                        fontWeight:
                            FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 4),

                Text(
                  'Kondisi scalp membaik dibanding scan sebelumnya',
                  style:
                      AppText.caption.copyWith(
                    fontSize: 10.5,
                  ),
                ),
              ],
            ),
          ),

          const Icon(
            Icons.chevron_right_rounded,
            color: AppColors.muted,
          ),
        ],
      ),
    ),
  );
}

Widget _buildDailyPlan() {
  return Obx(() {

    final done = progressController
        .dailyTasks
        .where((t) => t.isDone)
        .length;

    final total =
        progressController.dailyTasks.length;

    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,

      children: [

        Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween,

          children: [

            Text(
              'PERAWATAN HARI INI',
              style: AppText.label.copyWith(
                letterSpacing: 1.2,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),

            Text(
              '$done/$total selesai',
              style:
                  AppText.caption.copyWith(
                color: AppColors.accent,
                fontSize: 14,
              ),
            ),
          ],
        ),

        const SizedBox(height: 5),

        Text(
          DateFormat(
            'EEEE, d MMMM yyyy',
            'id',
          ).format(DateTime.now()),

          style:
              AppText.caption.copyWith(
            color: AppColors.muted,
            fontSize: 13,
          ),
        ),

        const SizedBox(height: 10),

        ClipRRect(
          borderRadius:
              BorderRadius.circular(4),

          child: LinearProgressIndicator(
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

        const SizedBox(height: 15),

        AppCard(
          padding:
              const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 4,
          ),

          child: Column(
            children: progressController
                .dailyTasks
                .asMap()
                .entries
                .map((entry) {

              final index = entry.key;
              final task = entry.value;

              final isLast =
                  index ==
                      progressController
                              .dailyTasks
                              .length -
                          1;

              return GestureDetector(
                onTap: () =>
                    progressController
                        .toggleTask(index),

                child: Container(
                  padding:
                      const EdgeInsets.symmetric(
                    vertical: 14,
                  ),

                  decoration: BoxDecoration(
                    border: isLast
                        ? null
                        : const Border(
                            bottom:
                                BorderSide(
                              color:
                                  AppColors.border,
                            ),
                          ),
                  ),

                  child: Row(
                    children: [

                      AnimatedContainer(
                        duration:
                            const Duration(
                          milliseconds: 200,
                        ),

                        width: 22,
                        height: 22,

                        decoration:
                            BoxDecoration(
                          color: task.isDone
                              ? AppColors.accent
                              : Colors.transparent,

                          borderRadius:
                              BorderRadius.circular(
                            6,
                          ),

                          border: Border.all(
                            color: task.isDone
                                ? AppColors.accent
                                : AppColors.border,

                            width: 1.5,
                          ),
                        ),

                        child: task.isDone
                            ? const Icon(
                                Icons.check_rounded,
                                size: 14,
                                color: Colors.black,
                              )
                            : null,
                      ),

                      const SizedBox(width: 12),


                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,

                          children: [

                            Text(
                              task.name,
                              style:
                                  AppText.body.copyWith(
                                fontSize: 13,

                                color: task.isDone
                                    ? AppColors
                                        .muted
                                    : AppColors
                                        .textPrimary,

                                decoration:
                                    task.isDone
                                        ? TextDecoration
                                            .lineThrough
                                        : null,
                              ),
                            ),

                            const SizedBox(
                                height: 2),

                            Text(
                              task.duration,
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

                      Container(
                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),

                        decoration:
                            BoxDecoration(
                          color: task.isDone
                              ? AppColors.accent
                                  .withOpacity(0.12)
                              : AppColors.s3,

                          borderRadius:
                              BorderRadius.circular(
                            6,
                          ),
                        ),

                        child: Text(
                          task.time,
                          style: AppText.caption
                              .copyWith(
                            fontSize: 10,

                            color: task.isDone
                                ? AppColors.accent
                                : AppColors.muted,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),

        const SizedBox(height: 10),

        Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [

              Icon(
                Icons.autorenew_rounded,
                size: 14,
                color: AppColors.accent,
              ),

              const SizedBox(width: 6),

              Text(
                'Rekomendasi diperbarui berdasarkan hasil scan terbaru',
                style: AppText.caption.copyWith(
                  fontSize: 10,
                  color: AppColors.muted2,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  });
}

}