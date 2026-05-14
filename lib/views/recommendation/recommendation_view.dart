import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/app_theme.dart';
import '../../widgets/shared_widgets.dart';
import '../../routes/app_routes.dart';
import '../../models/scalp_result.dart';

class RecommendationView extends StatelessWidget {
  const RecommendationView({super.key});

  static const _dailyReco = [

  _RecoItem(
    '',
    'Keramas dengan sampo antiketombe',
    '5–10 menit',
    'Pagi',
    AppColors.a2,
  ),

  _RecoItem(
    '',
    'Pijat kulit kepala',
    '3–5 menit',
    'Pagi',
    AppColors.a4,
  ),

  _RecoItem(
    '',
    'Hindari produk rambut berminyak',
    'Sepanjang hari',
    'Siang',
    AppColors.a2,
  ),

  _RecoItem(
    '',
    'Minum air putih 8 gelas',
    'Sepanjang hari',
    'Siang',
    AppColors.a4,
  ),

  _RecoItem(
    '',
    'Konsumsi makanan bergizi',
    'Saat makan',
    'Malam',
    AppColors.a2,
  ),

  _RecoItem(
    '',
    'Istirahat cukup (7–8 jam)',
    '7–8 jam',
    'Malam',
    AppColors.a4,
  ),
];

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Hero
          Container(
            padding: EdgeInsets.fromLTRB(18, MediaQuery.of(context).padding.top + 12, 18, 16),
            decoration: BoxDecoration(
  color: const Color(0xFF101A00),

  border: const Border(
    bottom: BorderSide(
      color: AppColors.border,
    ),
  ),

  boxShadow: [
    BoxShadow(
      color:
          AppColors.accent.withOpacity(0.08),

      blurRadius: 30,
    ),
  ],
),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(onTap: Get.back,
                      child: const Icon(Icons.arrow_back_ios_new_rounded, size: 18)),
                  ],
                ),
                const SizedBox(height: 12),
                Column(
  crossAxisAlignment:
      CrossAxisAlignment.start,

  children: [

    Text(
      'Seborrheic Dermatitis',

      style: AppText.headingMd.copyWith(
        fontSize: 24,
      ),
    ),

    const SizedBox(height: 4),

    Text(
      'Perawatan kulit kepala yang direkomendasikan berdasarkan hasil analisis AI.',

      style: AppText.caption.copyWith(
        fontSize: 11,
        height: 1.5,
      ),
    ),
  ],
),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                14,
                14,
                14,
                MediaQuery.of(context).padding.bottom + 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
  'PERAWATAN HARI INI',

  style: AppText.label.copyWith(
    letterSpacing: 1.2,
    fontSize: 14,
    fontWeight: FontWeight.w700,
  ),
),

const SizedBox(height: 10),

                  ..._dailyReco.map(_buildRecoCard),
                  const SizedBox(height: 8),
                  Text(
  'PRODUK REKOMENDASI',

  style: AppText.label.copyWith(
    letterSpacing: 1.2,
    fontSize: 14,
    fontWeight: FontWeight.w700,
  ),
),

const SizedBox(height: 10),

                  AppCard(
  padding: const EdgeInsets.symmetric(
    horizontal: 22,
    vertical: 18,
  ),

  child: Column(
    crossAxisAlignment:
        CrossAxisAlignment.start,

    children: [

      Text(
        '• Sampo antiketombe zinc pyrithione (Head & Shoulders, Selsun)',

        style: AppText.body.copyWith(
          fontSize: 12,
        ),
      ),

      const SizedBox(height: 12),

      Text(
        '• Sampo selenium sulfide',

        style: AppText.body.copyWith(
          fontSize: 12,
        ),
      ),

      const SizedBox(height: 12),

      Text(
        '• Conditioner ringan bebas minyak',

        style: AppText.body.copyWith(
          fontSize: 12,
        ),
      ),

      const SizedBox(height: 12),

      Text(
        '• Sisir bergigi jarang berbahan kayu',

        style: AppText.body.copyWith(
          fontSize: 12,
        ),
      ),
    ],
  ),
),
                  const SizedBox(height: 16),
                  SizedBox(
  width: double.infinity,
  height: 54,

  child: ElevatedButton(
    onPressed:
        () => Get.offAllNamed(
      AppRoutes.dashboard,
    ),

    child: const Text(
      'Mulai Rutinitas Hari Ini',
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

  Widget _buildRecoCard(_RecoItem item) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: AppCard(
      child: Row(
  children: [

    Expanded(
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Text(
            item.name,

            style: AppText.body.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            item.description,

            style: AppText.caption.copyWith(
              fontSize: 10,
              color: AppColors.muted,
            ),
          ),
        ],
      ),
    ),

    const SizedBox(width: 12),

    Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),

      decoration: BoxDecoration(
        color: AppColors.s3,
        borderRadius:
            BorderRadius.circular(8),
      ),

      child: Text(
        item.frequency,

        style: AppText.caption.copyWith(
          color: AppColors.accent,
          fontSize: 10,
        ),
      ),
    ),
  ],
),
    ),
  );

  
}

class _RecoItem {
  final String emoji, name, description, frequency;
  final Color accentColor;
  const _RecoItem(this.emoji, this.name, this.description, this.frequency, this.accentColor);
}

