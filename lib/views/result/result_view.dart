import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../models/scalp_result.dart';
import '../../theme/app_theme.dart';
import '../../widgets/shared_widgets.dart';
import '../../routes/app_routes.dart';

class ResultView extends StatelessWidget {
  const ResultView({super.key});

  @override
  Widget build(BuildContext context) {
    final result = Get.arguments as ScalpResult? ?? ScalpResult.fromAI();

    return Scaffold(
      body: Column(
        children: [
          // Hero header
          Container(
            padding: EdgeInsets.fromLTRB(18, MediaQuery.of(context).padding.top + 12, 18, 18),
            decoration: const BoxDecoration(
              color: Color(0xFF0F1100),
              border: Border(bottom: BorderSide(color: AppColors.border)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: Get.back,
                      child: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
                    ),
                    Row(children: [
                      _circleBtn(Icons.ios_share_rounded),
                      const SizedBox(width: 8),
                      _circleBtn(Icons.more_horiz_rounded),
                    ]),
                  ],
                ),
                const SizedBox(height: 14),
                AppPill.yellow('⚠  Perlu Perhatian'),
                const SizedBox(height: 10),
                Text('Hasil Analisis Scalp', style: AppText.headingMd),
                const SizedBox(height: 3),
                Text(
                  DateFormat('EEEE, d MMMM yyyy · HH:mm', 'id').format(result.scanDate),
                  style: AppText.caption,
                ),
                const SizedBox(height: 14),
                _ScoreRow(score: result.healthScore),
              ],
            ),
          ),

          // Scrollable body
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(14),
              child: Column(
                children: [
                  ConditionCard(
                    name: 'Ketombe',
                    scientific: 'Malassezia furfur',
                    percent: result.dandruffPct,
                    cause: '⚠  ${result.dandruffCause}',
                    color: AppColors.red,
                  ),
                  const SizedBox(height: 8),
                  ConditionCard(
                    name: 'Kulit Berminyak',
                    scientific: 'Sebum overproduction',
                    percent: result.oilyPct,
                    cause: '⚡  ${result.oilyCause}',
                    color: AppColors.yellow,
                  ),
                  const SizedBox(height: 8),
                  ConditionCard(
                    name: 'Kulit Kering',
                    scientific: 'Moisture deficiency',
                    percent: result.dryPct,
                    cause: '✓  ${result.dryCause}',
                    color: AppColors.a2,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => Get.toNamed(
                      AppRoutes.recommendation,
                      arguments: result,
                    ),
                    child: const Text('Lihat Rekomendasi →'),
                  ),
                  const SizedBox(height: 8),
                  OutlinedButton(
                    onPressed: () => Get.toNamed(AppRoutes.scan),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 52),
                      side: const BorderSide(color: AppColors.border2),
                      foregroundColor: AppColors.textPrimary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    child: const Text('Scan Ulang'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _circleBtn(IconData icon) => Container(
    width: 30, height: 30,
    decoration: BoxDecoration(
      color: AppColors.s2,
      shape: BoxShape.circle,
      border: Border.all(color: AppColors.border),
    ),
    child: Icon(icon, size: 14),
  );
}

class _ScoreRow extends StatelessWidget {
  final int score;
  const _ScoreRow({required this.score});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 70, height: 70,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CircularProgressIndicator(
                value: score / 100,
                backgroundColor: AppColors.border,
                valueColor: const AlwaysStoppedAnimation(AppColors.accent),
                strokeWidth: 5,
                strokeCap: StrokeCap.round,
              ),
              Text(
                '$score',
                style: AppText.heading.copyWith(fontSize: 18, color: AppColors.accent),
              ),
            ],
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Skor Kesehatan Scalp', style: AppText.body.copyWith(fontWeight: FontWeight.w600, fontSize: 13)),
              const SizedBox(height: 4),
              Text(
                'Kondisi cukup baik. Ada beberapa area yang perlu perhatian lebih.',
                style: AppText.caption.copyWith(height: 1.5),
              ),
            ],
          ),
        ),
      ],
    );
  }
}