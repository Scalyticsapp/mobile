import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controllers/result_controller.dart';

import '../../core/constants/app_assets.dart';
import '../../core/theme/app_theme.dart';

import '../../widgets/background_glow.dart';
import '../../widgets/app_pill.dart';
import '../../widgets/app_header.dart';

class ResultView extends StatelessWidget {
  const ResultView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ResultController>();

    return Scaffold(
      backgroundColor: const Color(0xFF060606),
      appBar: const AppHeader(
        title: 'Hasil Analisis',
      ),
      body: Stack(
        children: [
          const BackgroundGlow(),
          SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
              16,
              16,
              16,
              MediaQuery.of(context).padding.bottom + 40,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// HERO CARD
                _buildHeroCard(
                  controller,
                ),

                const SizedBox(height: 16),

                ClipRRect(
                  borderRadius: BorderRadius.circular(
                    18,
                  ),
                  child: Image.asset(
                    AppAssets.scalpSample,
                    width: double.infinity,
                    height: 220,
                    fit: BoxFit.cover,
                  ),
                ),

                const SizedBox(height: 16),

                /// FACTOR CARD
                _buildFactorCard(),

                const SizedBox(height: 16),

                /// INFO CARD
                _buildInfoCard(controller),

                const SizedBox(height: 16),

                /// SYMPTOM CARD
                _buildSymptomCard(controller),

                const SizedBox(height: 16),

                /// DISCLAIMER
                _buildDisclaimer(),

                const SizedBox(height: 16),

                /// BUTTON REKOMENDASI
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: controller.goToRecommendation,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accent,
                      foregroundColor: Colors.black,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          14,
                        ),
                      ),
                    ),
                    child: const Text(
                      'Lihat Rekomendasi',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                /// BUTTON SCAN ULANG
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: OutlinedButton(
                    onPressed: controller.scanAgain,
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: AppColors.accent.withOpacity(
                          0.3,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          14,
                        ),
                      ),
                    ),
                    child: const Text(
                      'Scan Ulang',
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
  Widget _buildHeroCard(
    ResultController controller,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(
        18,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF151A08),
            Color(0xFF0F1207),
          ],
        ),
        borderRadius: BorderRadius.circular(
          24,
        ),
        border: Border.all(
          color: AppColors.accent.withOpacity(0.18),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.accent.withOpacity(0.06),
            blurRadius: 30,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppPill.green(
            'Ringan',
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.result.disease,
                      style: AppText.headingMd.copyWith(
                        fontSize: 24,
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      DateFormat(
                        'EEEE, d MMMM yyyy · HH:mm',
                        'id',
                      ).format(
                        controller.result.scanDate,
                      ),
                      style: AppText.caption.copyWith(
                        color: Colors.white54,
                      ),
                    ),
                  ],
                ),
              ),
              Transform.translate(
                offset: const Offset(
                  -25,
                  -10,
                ),
                child: Text(
                  '${controller.result.healthScore}%',
                  style: AppText.heading.copyWith(
                    color: AppColors.accent,
                    fontSize: 42,
                    fontWeight: FontWeight.w700,
                    height: 1,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 18,
          ),
          Container(
            padding: const EdgeInsets.all(
              14,
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
            child: Row(
              children: [
                const Icon(
                  Icons.auto_awesome_rounded,
                  color: AppColors.accent,
                  size: 18,
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    'AI mendeteksi kondisi scalp dengan keyakinan ${(controller.confidence * 100).toStringAsFixed(1)}%.',
                    style: AppText.caption.copyWith(
                      height: 1.5,
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

  Widget _buildFactorCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.s2,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Faktor Deteksi',
            style: AppText.body.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          ...[
            'Produksi minyak ringan',
            'Ketombe tipis terdeteksi',
            'Tidak ditemukan inflamasi berat',
            'Area iritasi masih kecil',
          ].map(
            (factor) => Padding(
              padding: const EdgeInsets.only(
                bottom: 8,
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.check_circle_rounded,
                    size: 16,
                    color: AppColors.accent,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      factor,
                      style: AppText.caption.copyWith(
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

  Widget _buildInfoCard(
    ResultController controller,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        14,
        16,
        16,
        16,
      ),
      decoration: BoxDecoration(
        color: AppColors.s2,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.accent,
              borderRadius: BorderRadius.circular(
                20,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Tentang ${controller.result.disease}',
            style: AppText.body.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            controller.diseaseInfo.description,
            style: AppText.caption.copyWith(
              height: 1.5,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Penyebab: ${controller.diseaseInfo.cause}',
            style: AppText.caption.copyWith(
              color: Colors.white54,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSymptomCard(
    ResultController controller,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.s2,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Gejala Umum',
            style: AppText.body.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          ...controller.diseaseInfo.symptoms.map(
            (symptom) => Padding(
              padding: const EdgeInsets.only(
                bottom: 8,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                      top: 6,
                    ),
                    child: Icon(
                      Icons.circle,
                      size: 6,
                      color: AppColors.accent,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      symptom,
                      style: AppText.caption.copyWith(
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

  Widget _buildDisclaimer() {
    return Container(
      padding: const EdgeInsets.all(
        12,
      ),
      decoration: BoxDecoration(
        color: Colors.orange.withOpacity(0.08),
        borderRadius: BorderRadius.circular(
          12,
        ),
        border: Border.all(
          color: Colors.orange.withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.info_outline_rounded,
            color: Colors.orange,
            size: 16,
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Text(
              'Hasil ini bukan diagnosis medis resmi. Selalu konsultasikan dengan dokter.',
              style: AppText.caption.copyWith(
                color: Colors.orange,
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
