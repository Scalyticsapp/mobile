import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../theme/app_theme.dart';
import '../../widgets/shared_widgets.dart';
import '../../core/constants/app_assets.dart';

class ScanDetailView extends StatelessWidget {
  const ScanDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final data = Get.arguments ?? {};

    return Scaffold(
  backgroundColor: AppColors.bg,

  appBar: AppBar(
    backgroundColor: AppColors.bg,
    elevation: 0,
    scrolledUnderElevation: 0,

    leading: IconButton(
      onPressed: Get.back,

      icon: const Icon(
        Icons.arrow_back_ios_new_rounded,
        size: 18,
      ),
    ),

    title: Text(
      'Detail Riwayat',

      style: AppText.body.copyWith(
        fontWeight: FontWeight.w600,
      ),
    ),

    centerTitle: true,
  ),

  body: Column(
        children: [

          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
  14,
  14,
  14,
  MediaQuery.of(context)
          .padding
          .bottom +
      40,
),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Container(
  width: double.infinity,
  padding: const EdgeInsets.all(18),

  decoration: BoxDecoration(
    gradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,

      colors: [
        Color(0xFF151A08),
        Color(0xFF0F1207),
      ],
    ),

    borderRadius:
        BorderRadius.circular(24),

    border: Border.all(
      color: AppColors.accent
          .withOpacity(0.18),
    ),
  ),

  child: Column(
    crossAxisAlignment:
        CrossAxisAlignment.start,

    children: [

      Container(
        padding:
            const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 5,
        ),

        decoration: BoxDecoration(
          color: AppColors.accent
              .withOpacity(0.15),

          borderRadius:
              BorderRadius.circular(20),
        ),

        child: Text(
          data['status'] ?? 'Ringan',

          style: const TextStyle(
            color: AppColors.accent,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      const SizedBox(height: 16),

      Row(
        children: [

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(
                  data['title'] ??
                      'Seborrheic Dermatitis',

                  style:
                      AppText.headingMd
                          .copyWith(
                    fontSize: 24,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  data['date'] ??
                      '9 Mei 2026',

                  style:
                      AppText.caption
                          .copyWith(
                    color: Colors.white54,
                  ),
                ),
              ],
            ),
          ),

          Text(
            '${data['score'] ?? '91'}%',

            style:
                AppText.heading
                    .copyWith(
              color: AppColors.accent,
              fontSize: 42,
              fontWeight:
                  FontWeight.w700,
            ),
          ),
        ],
      ),

      const SizedBox(height: 22),

Container(
  width: double.infinity,

  padding: const EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 14,
  ),

  decoration: BoxDecoration(
    color: Colors.white.withOpacity(0.04),

    borderRadius:
        BorderRadius.circular(18),

    border: Border.all(
      color: Colors.white
          .withOpacity(0.05),
    ),
  ),

  child: Row(
    children: [

      const Icon(
        Icons.auto_awesome_rounded,
        color: AppColors.accent,
        size: 18,
      ),

      const SizedBox(width: 10),

      Expanded(
        child: Text(
          'AI mendeteksi kondisi scalp dengan keyakinan 91.0%.',

          style:
              AppText.caption.copyWith(
            color: Colors.white70,
            height: 1.4,
          ),
        ),
      ),
    ],
  ),
),
    ],
  ),
),

                  const SizedBox(height: 14),

                  const Text(
  'FOTO SCAN',

  style: TextStyle(
    letterSpacing: 1.2,
    fontSize: 14,
    fontWeight: FontWeight.w700,
  ),
),

const SizedBox(height: 10),

ClipRRect(
  borderRadius:
      BorderRadius.circular(18),

  child: Container(
    width: double.infinity,
    height: 220,

    decoration: BoxDecoration(
      border: Border.all(
        color: AppColors.border,
      ),
    ),

    child: Image.asset(
      AppAssets.scalpSample,

      fit: BoxFit.cover,
    ),
  ),
),


                  
const SizedBox(height: 12),

Container(
  width: double.infinity,

  padding: const EdgeInsets.all(16),

  decoration: BoxDecoration(
    color: AppColors.s2,

    borderRadius:
        BorderRadius.circular(16),

    border: Border.all(
      color: AppColors.border,
    ),
  ),

  child: Column(
    crossAxisAlignment:
        CrossAxisAlignment.start,

    children: [

      Text(
        'Faktor Deteksi',

        style: AppText.body.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),

      const SizedBox(height: 12),

      _factorItem(
        'Produksi minyak ringan',
      ),

      _factorItem(
        'Ketombe tipis terdeteksi',
      ),

      _factorItem(
        'Tidak ditemukan inflamasi berat',
      ),

      _factorItem(
        'Area iritasi masih kecil',
      ),
    ],
  ),
),

const SizedBox(height: 16),

const _InfoCard(
  title:
      'Tentang Seborrheic Dermatitis',

  value:
      'Peradangan kulit kepala akibat pertumbuhan berlebih jamur Malassezia yang hidup secara alami di kulit.',

  subtitle:
      'Penyebab: Produksi minyak berlebih, stres, perubahan hormon, dan penumpukan jamur pada kulit kepala.',
),

const SizedBox(height: 12),

const _SymptomCard(
  symptoms: [

    'Ketombe berminyak berwarna kuning atau putih',

    'Kulit kepala kemerahan dan terasa gatal',

    'Sisik menempel di rambut dan bahu',

    'Bisa disertai rasa perih atau sensasi terbakar ringan',
  ],
),

const SizedBox(height: 12),

Container(
  padding:
      const EdgeInsets.all(12),

  decoration: BoxDecoration(
    color: Colors.orange
        .withOpacity(0.08),

    borderRadius:
        BorderRadius.circular(12),

    border: Border.all(
      color: Colors.orange
          .withOpacity(0.3),
    ),
  ),

  child: Row(
    children: [

      const Icon(
        Icons.info_outline_rounded,
        color: Colors.orange,
        size: 16,
      ),

      const SizedBox(width: 8),

      Expanded(
        child: Text(
          'Hasil ini bukan diagnosis medis resmi. Selalu konsultasikan dengan dokter.',

          style: AppText.caption
              .copyWith(
            color: Colors.orange,
            fontSize: 11,
          ),
        ),
      ),
    ],
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
}

class _SymptomCard
    extends StatelessWidget {
  final List<String> symptoms;

  const _SymptomCard({
    required this.symptoms,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(
        16,
      ),

      decoration: BoxDecoration(
        color: AppColors.s2,

        borderRadius:
            BorderRadius.circular(
          16,
        ),

        border: Border.all(
          color: AppColors.border,
        ),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Text(
            'Gejala Umum',

            style: AppText.body
                .copyWith(
              fontWeight:
                  FontWeight.w600,
            ),
          ),

          const SizedBox(height: 10),

          ...symptoms.map(
            (s) => Padding(
              padding:
                  const EdgeInsets.only(
                bottom: 6,
              ),

              child: Row(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                children: [

                  const Icon(
                    Icons.circle,
                    size: 6,
                    color:
                        AppColors.accent,
                  ),

                  const SizedBox(
                      width: 8),

                  Expanded(
                    child: Text(
                      s,

                      style: AppText
                          .caption
                          .copyWith(
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
}

/// INFO CARD
class _InfoCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;

  const _InfoCard({
    required this.title,
    required this.value,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
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

  borderRadius:
      BorderRadius.circular(16),

  border: Border.all(
    color: AppColors.border,
  ),

        
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Container(
  width: 36,
  height: 4,

  decoration: BoxDecoration(
    color: AppColors.accent,
    borderRadius: BorderRadius.circular(20),
  ),
),

const SizedBox(height: 12),

          Text(
            title,

            style: AppText.body.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            value,

            style: AppText.caption.copyWith(
              height: 1.5,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            subtitle,

            style: AppText.caption.copyWith(
              color: Colors.white54,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  
}

Widget _factorItem(String text) {
  return Padding(
    padding:
        const EdgeInsets.only(
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
            text,

            style:
                AppText.caption.copyWith(
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}