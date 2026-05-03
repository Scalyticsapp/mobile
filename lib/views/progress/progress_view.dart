import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../controllers/progress_controller.dart';
import '../../controllers/dashboard_controller.dart';
import '../../models/scalp_result.dart';
import '../../theme/app_theme.dart';
import '../../widgets/shared_widgets.dart';
import '../../routes/app_routes.dart';

class ProgressView extends GetView<ProgressController> {
  const ProgressView({super.key});

  static const _tabIndex = 2;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Get.isRegistered<DashboardController>()) {
        Get.find<DashboardController>().selectedTab.value = _tabIndex;
      }
    });

    return Scaffold(
      backgroundColor: const Color(0xFF060606),

      // ✅ TOP BAR — hitam tanpa border, fixed saat scroll
      appBar: AppBar(
        backgroundColor: const Color(0xFF060606),
        elevation: 0,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'Progres Scalp',
          style: AppText.body.copyWith(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),

      body: SafeArea(
        top: false,
        child: Stack(
          children: [
            // BLUR ATAS KIRI
            Positioned(
              top: -120,
              left: -110,
              child: Container(
                width: 360,
                height: 360,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.accent.withOpacity(0.15),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            // BLUR BAWAH KANAN
            Positioned(
              bottom: -50,
              right: -60,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.accent.withOpacity(0.18),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            // CONTENT
            Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildScanReminder(),
                        const SizedBox(height: 16),
                        _buildCalendar(),
                        const SizedBox(height: 16),
                        _buildDailyRoutine(),
                        const SizedBox(height: 16),
                        _buildHistory(),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
                if (Get.isRegistered<DashboardController>())
                  Obx(() => AppBottomNav(
                        currentIndex:
                            Get.find<DashboardController>().selectedTab.value,
                        onTap: (i) => Get.find<DashboardController>()
                            .navigateTo(_tabIndex, i),
                      ))
                else
                  AppBottomNav(currentIndex: _tabIndex, onTap: (_) {}),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ─── SECTION 1: PERINGATAN SCAN ───────────────────────────────────────────
  Widget _buildScanReminder() {
    final history = controller.scanHistory;
    final lastScan = history.isNotEmpty ? history.first.date : null;

    if (lastScan == null) {
      return _reminderBanner(
        emoji: '📷',
        text: 'Kamu belum pernah scan. Yuk mulai scan pertama kamu!',
        color: AppColors.red,
        buttonLabel: 'Scan Sekarang',
        onTap: () => Get.toNamed(AppRoutes.scan),
      );
    }

    final now = DateTime.now();
    final daysSince = now.difference(lastScan).inDays;
    final daysUntilNext = 7 - daysSince;

    if (daysSince >= 7) {
      return _reminderBanner(
        emoji: '⏰',
        text: 'Sudah waktunya scan minggu ini! Pantau kondisi scalp kamu sekarang.',
        color: AppColors.red,
        buttonLabel: 'Scan Sekarang',
        onTap: () => Get.toNamed(AppRoutes.scan),
      );
    }

    if (daysUntilNext <= 5) {
      return _reminderBanner(
        emoji: '🔔',
        text: '$daysUntilNext hari lagi waktunya scan. Siapkan diri kamu!',
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
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withOpacity(0.07),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 22)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: AppText.caption.copyWith(fontSize: 12, height: 1.5),
            ),
          ),
          if (buttonLabel != null && onTap != null) ...[
            const SizedBox(width: 10),
            GestureDetector(
              onTap: onTap,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(10),
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

  // ─── SECTION 2: KALENDER ──────────────────────────────────────────────────
  Widget _buildCalendar() {
    final now = DateTime.now();
    final firstDay = DateTime(now.year, now.month, 1);
    final daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    final startWeekday = firstDay.weekday % 7;

    final scanDates = controller.scanHistory
        .where((h) => h.date.year == now.year && h.date.month == now.month)
        .map((h) => h.date.day)
        .toSet();

    final lastScan = controller.scanHistory.isNotEmpty
        ? controller.scanHistory.first.date
        : null;
    final nextScanDate =
        lastScan != null ? lastScan.add(const Duration(days: 7)) : null;
    final nextScanDay = (nextScanDate != null &&
            nextScanDate.year == now.year &&
            nextScanDate.month == now.month)
        ? nextScanDate.day
        : null;

    final monthLabel = DateFormat('MMMM yyyy', 'id').format(now);

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(monthLabel,
              style: AppText.body.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 14),

          // Label hari
          Row(
            children: ['Min', 'Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab']
                .map((d) => Expanded(
                      child: Text(d,
                          textAlign: TextAlign.center,
                          style: AppText.caption.copyWith(fontSize: 10)),
                    ))
                .toList(),
          ),
          const SizedBox(height: 8),

          // Grid tanggal
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              childAspectRatio: 1,
            ),
            itemCount: startWeekday + daysInMonth,
            itemBuilder: (_, index) {
              if (index < startWeekday) return const SizedBox();

              final day = index - startWeekday + 1;
              final isToday = day == now.day;
              final isScanDay = scanDates.contains(day);
              final isNextScan = day == nextScanDay;

              Color? bgColor;
              Color? borderColor;
              Color textColor = AppColors.muted;

              if (isScanDay) {
                bgColor = AppColors.accent.withOpacity(0.15);
                borderColor = AppColors.accent;
                textColor = AppColors.accent;
              }
              if (isToday && !isScanDay) {
                bgColor = Colors.white.withOpacity(0.05);
                borderColor = AppColors.muted;
                textColor = AppColors.textPrimary;
              }
              if (isToday && isScanDay) {
                bgColor = AppColors.accent.withOpacity(0.25);
                borderColor = AppColors.accent;
                textColor = AppColors.accent;
              }
              if (isNextScan) {
                bgColor = AppColors.red.withOpacity(0.12);
                borderColor = AppColors.red;
                textColor = AppColors.red;
              }

              return Container(
                decoration: BoxDecoration(
                  color: bgColor,
                  shape: BoxShape.circle,
                  border: borderColor != null
                      ? Border.all(color: borderColor, width: 1.5)
                      : null,
                ),
                child: Center(
                  child: Text(
                    '$day',
                    style: TextStyle(
                      fontSize: 11,
                      color: textColor,
                      fontWeight: isToday || isScanDay || isNextScan
                          ? FontWeight.w700
                          : FontWeight.w400,
                    ),
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 10),
          const Divider(color: AppColors.border, height: 1),
          const SizedBox(height: 10),

          Row(children: [
            _calLegend(AppColors.accent, 'Hari scan'),
            const SizedBox(width: 16),
            _calLegend(AppColors.red, 'Scan berikutnya'),
            const SizedBox(width: 16),
            _calLegend(AppColors.muted, 'Hari ini'),
          ]),
        ],
      ),
    );
  }

  Widget _calLegend(Color color, String label) => Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: color, width: 1.5),
              color: color.withOpacity(0.15),
            ),
          ),
          const SizedBox(width: 6),
          Text(label, style: AppText.caption.copyWith(fontSize: 10)),
        ],
      );

  // ─── SECTION 3: PERAWATAN HARIAN ──────────────────────────────────────────
  Widget _buildDailyRoutine() {
    final routines = [
      _RoutineItem(emoji: '🌿', title: 'Masker Lidah Buaya', desc: '15 menit · Pagi', isDone: true),
      _RoutineItem(emoji: '💧', title: 'Sampo Anti-Dandruff', desc: '5 menit · Siang', isDone: true),
      _RoutineItem(emoji: '🍯', title: 'Kondisioner Deep Care', desc: '10 menit · Malam', isDone: false),
    ];

    final colors = [AppColors.a2, AppColors.accent, AppColors.a3];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('PERAWATAN HARI INI',
            style: AppText.label.copyWith(letterSpacing: 1.2)),
        const SizedBox(height: 10),
        Column(
          children: List.generate(routines.length, (i) {
            final r = routines[i];
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: AppCard(
                padding: const EdgeInsets.all(12),
                child: Row(children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9),
                      color: colors[i].withOpacity(0.1),
                    ),
                    child: Center(
                      child: Text(r.emoji,
                          style: const TextStyle(fontSize: 16)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(r.title,
                            style: AppText.body.copyWith(
                                fontSize: 12, fontWeight: FontWeight.w600)),
                        Text(r.desc,
                            style: AppText.caption.copyWith(fontSize: 10)),
                      ],
                    ),
                  ),
                  Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: r.isDone
                          ? AppColors.accent.withOpacity(0.15)
                          : Colors.transparent,
                      border: Border.all(
                        color: r.isDone ? AppColors.accent : AppColors.border,
                        width: 1.5,
                      ),
                    ),
                    child: r.isDone
                        ? const Icon(Icons.check_rounded,
                            size: 13, color: AppColors.accent)
                        : null,
                  ),
                ]),
              ),
            );
          }),
        ),
      ],
    );
  }

  // ─── SECTION 4: RIWAYAT SCAN ──────────────────────────────────────────────
  Widget _buildHistory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('RIWAYAT SCAN',
            style: AppText.label.copyWith(letterSpacing: 1.2)),
        const SizedBox(height: 10),
        Obx(() {
          final history = controller.scanHistory.take(4).toList();
          return AppCard(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
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
                    ? 'Membaik'
                    : isNeutral
                        ? 'Stabil'
                        : 'Perlu Perhatian';

                return GestureDetector(
                  onTap: () {
                    final result = ScalpResult(
                      dandruffPct: h.dandruffPct,
                      oilyPct: 30,
                      dryPct: 15,
                      healthScore: h.score,
                      scanDate: h.date,
                    );
                    Get.toNamed(AppRoutes.result, arguments: result);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    decoration: const BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: AppColors.border)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration:
                              BoxDecoration(color: color, shape: BoxShape.circle),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                DateFormat('d MMMM yyyy', 'id').format(h.date),
                                style: AppText.body.copyWith(fontSize: 12),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Ketombe ${h.dandruffPct.toInt()}%',
                                style: AppText.caption.copyWith(fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            label,
                            style: AppText.caption
                                .copyWith(color: color, fontSize: 10),
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Icon(Icons.chevron_right_rounded,
                            size: 16, color: AppColors.muted),
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

// ─── HELPER MODEL ─────────────────────────────────────────────────────────────
class _RoutineItem {
  final String emoji;
  final String title;
  final String desc;
  final bool isDone;

  const _RoutineItem({
    required this.emoji,
    required this.title,
    required this.desc,
    required this.isDone,
  });
}