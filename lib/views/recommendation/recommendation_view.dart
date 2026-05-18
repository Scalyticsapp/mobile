import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/theme/app_theme.dart';

import '../../routes/app_routes.dart';

import '../../widgets/app_card.dart';
import '../../widgets/section_title.dart';
import '../../widgets/routine_card.dart';

class RecommendationView extends StatelessWidget {
  const RecommendationView({
    super.key,
  });

  static const List<_RecoItem> _dailyReco = [
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
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      body: Column(
        children: [
          /// HERO
          _buildHeroSection(
            context,
          ),

          /// CONTENT
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                14,
                14,
                14,
                MediaQuery.of(
                      context,
                    ).padding.bottom +
                    24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// TITLE
                  const SectionTitle(
                    'PERAWATAN HARI INI',
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  /// RECOMMENDATION LIST
                  _buildRecoCard(),

                  const SizedBox(
                    height: 8,
                  ),

                  /// PRODUCT TITLE
                  const SectionTitle(
                    'REKOMENDASI PRODUK',
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  /// PRODUCT CARD
                  _buildProductCard(),

                  const SizedBox(
                    height: 16,
                  ),

                  /// BUTTON
                  _buildActionButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// HERO SECTION
  Widget _buildHeroSection(
    BuildContext context,
  ) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        18,
        MediaQuery.of(context).padding.top + 12,
        18,
        16,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF101A00),
        border: const Border(
          bottom: BorderSide(
            color: AppColors.border,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.accent.withOpacity(0.08),
            blurRadius: 30,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// BACK BUTTON
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: Get.back,
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 18,
                ),
              ),
            ],
          ),

          const SizedBox(
            height: 12,
          ),

          /// TITLE
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Seborrheic Dermatitis',
                style: AppText.headingMd.copyWith(
                  fontSize: 24,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
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
    );
  }

  /// PRODUCT CARD
  Widget _buildProductCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(
        16,
      ),
      decoration: BoxDecoration(
        color: AppColors.s2,
        borderRadius: BorderRadius.circular(
          16,
        ),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Produk Rekomendasi',
            style: AppText.body.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ...[
            'Sampo antiketombe zinc pyrithione (Head & Shoulders, Selsun)',
            'Sampo selenium sulfide',
            'Conditioner ringan bebas minyak',
            'Sisir bergigi jarang berbahan kayu',
          ].map(
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
                  const SizedBox(
                    width: 8,
                  ),
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

  /// ACTION BUTTON
  Widget _buildActionButton() {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: () => Get.offAllNamed(
          AppRoutes.dashboard,
        ),
        child: const Text(
          'Mulai Rutinitas Hari Ini',
        ),
      ),
    );
  }

  /// RECOMMENDATION CARD
  Widget _buildRecoCard() {
    return AppCard(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 4,
      ),
      child: Column(
        children: _dailyReco.asMap().entries.map(
          (entry) {
            final index = entry.key;

            final item = entry.value;

            return RoutineCard(
              title: item.name,
              subtitle: item.description,
              time: item.frequency,
              showCheckbox: false,
              forceActive: true,
              showDivider: index != _dailyReco.length - 1,
            );
          },
        ).toList(),
      ),
    );
  }
}

class _RecoItem {
  final String emoji;
  final String name;
  final String description;
  final String frequency;
  final Color accentColor;

  const _RecoItem(
    this.emoji,
    this.name,
    this.description,
    this.frequency,
    this.accentColor,
  );
}
