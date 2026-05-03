import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/app_theme.dart';
import '../../widgets/shared_widgets.dart';
import '../../routes/app_routes.dart';
import '../../models/scalp_result.dart';

class RecommendationView extends StatelessWidget {
  const RecommendationView({super.key});

  static const _dailyReco = [
    _RecoItem('🌿', 'Sampo Anti-Dandruff', 'Gunakan sampo mengandung zinc pyrithione atau selenium sulfide untuk atasi ketombe 42%', '3× seminggu · Pagi', AppColors.a2),
    _RecoItem('💧', 'Kondisioner Ringan', 'Hindari ujung rambut, fokus pada batang untuk kurangi produksi sebum berlebih', 'Setiap keramas · Sore', AppColors.a4),
  ];

  static const _weeklyReco = [
    _RecoItem('🍯', 'Masker Lidah Buaya', 'Aplikasikan selama 20 menit untuk hidrasi dan atasi inflamasi pada scalp', '1× seminggu · Malam', AppColors.yellow),
    _RecoItem('🫒', 'Pijat Minyak Zaitun', 'Stimulasi sirkulasi darah dan lembutkan kulit kepala yang kering', '2× seminggu · Malam', AppColors.a3),
  ];

  static const _products = [
    _ProductItem('🧴', 'Head & Shoulders Clinical', 'Anti-Dandruff Shampoo', 94),
    _ProductItem('🌿', 'The Body Shop Ginger', 'Scalp Care Treatment', 88),
    _ProductItem('💊', 'Selsun Blue', 'Selenium Sulfide Shampoo', 81),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Hero
          Container(
            padding: EdgeInsets.fromLTRB(18, MediaQuery.of(context).padding.top + 12, 18, 16),
            decoration: const BoxDecoration(
              color: Color(0xFF0A100A),
              border: Border(bottom: BorderSide(color: AppColors.border)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(onTap: Get.back,
                      child: const Icon(Icons.arrow_back_ios_new_rounded, size: 18)),
                    const Icon(Icons.ios_share_rounded, size: 18, color: AppColors.muted),
                  ],
                ),
                const SizedBox(height: 12),
                AppPill.green('🌿  Personal Plan'),
                const SizedBox(height: 10),
                Text('Rencana Perawatan\nScalp Kamu', style: AppText.headingMd),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionTitle('Perawatan Harian'),
                  ..._dailyReco.map(_buildRecoCard),
                  const SizedBox(height: 8),
                  const SectionTitle('Perawatan Mingguan'),
                  ..._weeklyReco.map(_buildRecoCard),
                  const SizedBox(height: 8),
                  const SectionTitle('Produk Rekomendasi'),
                  ..._products.map(_buildProductCard),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => Get.offAllNamed(AppRoutes.dashboard),
                    child: const Text('Mulai Rutinitas Hari Ini'),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38, height: 38,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: item.accentColor.withOpacity(0.1),
              border: Border.all(color: item.accentColor.withOpacity(0.2)),
            ),
            child: Center(child: Text(item.emoji, style: const TextStyle(fontSize: 18))),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name, style: AppText.body.copyWith(fontWeight: FontWeight.w600, fontSize: 13)),
                const SizedBox(height: 3),
                Text(item.description, style: AppText.caption.copyWith(height: 1.5)),
                const SizedBox(height: 5),
                Text(item.frequency,
                  style: AppText.caption.copyWith(color: AppColors.accent, fontSize: 10, letterSpacing: 0.3)),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  Widget _buildProductCard(_ProductItem p) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: AppCard(
      child: Row(
        children: [
          Container(
            width: 42, height: 42,
            decoration: BoxDecoration(color: AppColors.s3, borderRadius: BorderRadius.circular(10)),
            child: Center(child: Text(p.emoji, style: const TextStyle(fontSize: 22))),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(p.name, style: AppText.body.copyWith(fontWeight: FontWeight.w600, fontSize: 12)),
                Text(p.brand, style: AppText.caption.copyWith(fontSize: 10)),
                const SizedBox(height: 3),
                Text('✓  ${p.matchPct}% cocok untuk kondisimu',
                  style: AppText.caption.copyWith(color: AppColors.a2, fontSize: 10)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded, color: AppColors.muted2),
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

class _ProductItem {
  final String emoji, name, brand;
  final int matchPct;
  const _ProductItem(this.emoji, this.name, this.brand, this.matchPct);
}
