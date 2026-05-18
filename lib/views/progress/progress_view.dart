import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controllers/dashboard_controller.dart';
import '../../controllers/progress_controller.dart';

import '../../core/theme/app_theme.dart';

import '../../data/models/scalp_result.dart';

import '../../routes/app_routes.dart';

import '../../widgets/app_bottom_nav.dart';
import '../../widgets/app_card.dart';
import '../../widgets/background_glow.dart';
import '../../widgets/section_title.dart';
import '../../widgets/app_header.dart';
import '../../widgets/routine_card.dart';

class ProgressView extends StatefulWidget {
  const ProgressView({
    super.key,
  });

  @override
  State<ProgressView> createState() => _ProgressViewState();
}

class _ProgressViewState extends State<ProgressView> {
  static const int _tabIndex = 2;

  late final ProgressController controller;

  @override
  void initState() {
    super.initState();

    controller = Get.find<ProgressController>();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        if (Get.isRegistered<DashboardController>()) {
          Get.find<DashboardController>().selectedTab.value = _tabIndex;
        }
      },
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: const AppHeader(
        title: 'Progress',
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  const BackgroundGlow(),
                  SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(
                      16,
                      16,
                      16,
                      MediaQuery.of(
                            context,
                          ).padding.bottom +
                          14,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildScanReminder(),
                        const SizedBox(
                          height: 16,
                        ),
                        _buildTrackingCard(),
                        const SizedBox(
                          height: 16,
                        ),
                        _buildDailyPlan(),
                        const SizedBox(
                          height: 16,
                        ),
                        _buildHistory(),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            /// NAVBAR
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                bottom: 10,
              ),
              child: Obx(
                () => AppBottomNav(
                  currentIndex:
                      Get.find<DashboardController>().selectedTab.value,
                  onTap: (index) {
                    Get.find<DashboardController>().navigateTo(
                      _tabIndex,
                      index,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// TRACKING CARD
  Widget _buildTrackingCard() {
    final history = controller.scanHistory;

    final lastScore = history.isNotEmpty ? history.first.score : 0;

    final lastConfidence = history.isNotEmpty ? history.first.confidence : 0.0;

    final lastDate = history.isNotEmpty ? history.first.date : DateTime.now();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(
        18,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF101A00),
        borderRadius: BorderRadius.circular(
          18,
        ),
        border: Border.all(
          color: AppColors.accent.withOpacity(0.18),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(
                  10,
                ),
                decoration: BoxDecoration(
                  color: AppColors.accent.withOpacity(
                    0.15,
                  ),
                  borderRadius: BorderRadius.circular(
                    12,
                  ),
                ),
                child: const Icon(
                  Icons.analytics_rounded,
                  color: AppColors.accent,
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Progress Tracking',
                      style: AppText.body.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      'Scan rutin untuk melihat perkembangan scalp kamu.',
                      style: AppText.caption.copyWith(
                        fontSize: 11,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 18,
          ),
          Row(
            children: [
              Expanded(
                child: _buildMiniStat(
                  'Health',
                  '$lastScore',
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: _buildMiniStat(
                  'Confidence',
                  '${(lastConfidence * 100).toInt()}%',
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: _buildMiniStat(
                  'Terakhir',
                  DateFormat(
                    'd MMM',
                    'id',
                  ).format(
                    lastDate,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 18,
          ),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                Get.toNamed(
                  AppRoutes.scan,
                  arguments: {
                    'isProgressScan': true,
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    12,
                  ),
                ),
              ),
              child: const Text(
                'Mulai Scan Progress',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Gunakan scan progress secara rutin pada area scalp yang sama agar hasil tracking lebih akurat.',
            style: AppText.caption.copyWith(
              fontSize: 10,
              height: 1.5,
              color: Colors.white60,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMiniStat(
    String title,
    String value,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.04),
        borderRadius: BorderRadius.circular(
          14,
        ),
        border: Border.all(
          color: Colors.white.withOpacity(0.05),
        ),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: AppText.body.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.accent,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            title,
            style: AppText.caption.copyWith(
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  /// SCAN REMINDER
  Widget _buildScanReminder() {
    final history = controller.scanHistory;

    final lastScan = history.isNotEmpty ? history.first.date : null;

    if (lastScan == null) {
      return _reminderBanner(
        emoji: '📷',
        text: 'Kamu belum pernah scan. Yuk mulai scan pertama kamu!',
        color: AppColors.red,
        buttonLabel: 'Scan Sekarang',
        onTap: () {
          Get.toNamed(
            AppRoutes.scan,
          );
        },
      );
    }

    final daysSince = DateTime.now().difference(lastScan).inDays;

    final daysUntilNext = 7 - daysSince;

    if (daysSince >= 7) {
      return _reminderBanner(
        emoji: '⏰',
        text: 'Sudah waktunya scan minggu ini!',
        color: AppColors.red,
        buttonLabel: 'Scan Sekarang',
        onTap: () {
          Get.toNamed(
            AppRoutes.scan,
          );
        },
      );
    }

    if (daysUntilNext <= 5) {
      return _reminderBanner(
        emoji: '🔔',
        text: '$daysUntilNext hari lagi waktunya scan.',
        color: AppColors.yellow,
        buttonLabel: null,
        onTap: null,
      );
    }

    return const SizedBox.shrink();
  }

  Widget _reminderBanner({
    required String emoji,
    required String text,
    required Color color,
    required String? buttonLabel,
    required VoidCallback? onTap,
  }) {
    return Container(
      padding: const EdgeInsets.all(
        14,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.07),
        borderRadius: BorderRadius.circular(
          14,
        ),
        border: Border.all(
          color: color.withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          Text(
            emoji,
            style: const TextStyle(
              fontSize: 22,
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Text(
              text,
              style: AppText.caption.copyWith(
                fontSize: 12,
                height: 1.5,
              ),
            ),
          ),
          if (buttonLabel != null && onTap != null) ...[
            const SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: onTap,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                ),
                child: Text(
                  buttonLabel,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// DAILY PLAN
  Widget _buildDailyPlan() {
    return Obx(
      () {
        final done = controller.dailyTasks
            .where(
              (task) => task.isDone,
            )
            .length;

        final total = controller.dailyTasks.length;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// HEADER
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              style: AppText.caption.copyWith(
                color: AppColors.muted,
                fontSize: 13,
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            /// PROGRESS BAR
            ClipRRect(
              borderRadius: BorderRadius.circular(
                4,
              ),
              child: LinearProgressIndicator(
                value: total == 0 ? 0 : done / total,
                backgroundColor: AppColors.s3,
                valueColor: const AlwaysStoppedAnimation(
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
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 4,
              ),
              child: Column(
                children: controller.dailyTasks.asMap().entries.map(
                  (entry) {
                    final index = entry.key;

                    final task = entry.value;

                    return RoutineCard(
                      title: task.name,
                      subtitle: task.duration,
                      time: task.time,
                      isDone: task.isDone,
                      showDivider: index != controller.dailyTasks.length - 1,
                      onTap: () {
                        controller.toggleTask(
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
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.autorenew_rounded,
                    size: 14,
                    color: AppColors.accent,
                  ),
                  const SizedBox(
                    width: 6,
                  ),
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
      },
    );
  }

  /// HISTORY
  Widget _buildHistory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(
          'RIWAYAT SCAN',
        ),
        const SizedBox(
          height: 10,
        ),
        Obx(() {
          final history = controller.scanHistory.take(4).toList();

          return AppCard(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 4,
            ),
            child: Column(
              children: history.map((h) {
                final isGood = h.change > 0;

                final isNeutral = h.change == 0;

                final color = isGood
                    ? AppColors.accent
                    : isNeutral
                        ? AppColors.yellow
                        : AppColors.red;

                final label = isGood
                    ? 'Rendah'
                    : isNeutral
                        ? 'Sedang'
                        : 'Tinggi';

                return GestureDetector(
                  onTap: () {
                    final result = ScalpResult(
                      disease: 'Seborrheic Dermatitis',
                      confidence: h.confidence,
                      healthScore: h.score,
                      scanDate: h.date,
                      description:
                          'Terdapat indikasi kulit kepala berminyak disertai ketombe.',
                      recommendation:
                          'Gunakan sampo anti-ketombe secara rutin.',
                    );

                    Get.toNamed(
                      AppRoutes.scanDetail,
                      arguments: {
                        'title': result.disease,
                        'date': DateFormat(
                          'd MMMM yyyy',
                          'id',
                        ).format(
                          h.date,
                        ),
                        'score': h.score.toString(),
                        'status': label,
                      },
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 13,
                    ),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: AppColors.border,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                DateFormat(
                                  'd MMMM yyyy',
                                  'id',
                                ).format(
                                  h.date,
                                ),
                                style: AppText.body.copyWith(
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(
                                'Confidence ${(h.confidence * 100).toInt()}%',
                                style: AppText.caption.copyWith(
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: color.withOpacity(
                              0.12,
                            ),
                            borderRadius: BorderRadius.circular(
                              8,
                            ),
                          ),
                          child: Text(
                            label,
                            style: AppText.caption.copyWith(
                              color: color,
                              fontSize: 10,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        const Icon(
                          Icons.chevron_right_rounded,
                          size: 16,
                          color: AppColors.muted,
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        }),
      ],
    );
  }
}
