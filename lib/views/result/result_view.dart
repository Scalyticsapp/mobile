import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../models/scalp_result.dart';
import '../../theme/app_theme.dart';
import '../../routes/app_routes.dart';
import '../../controllers/result_controller.dart';
import '../../core/constants/app_assets.dart';

class ResultView extends StatelessWidget {
  const ResultView({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<ResultController>();

    return Scaffold(
      backgroundColor: const Color(0xFF060606),

appBar: AppBar(
  backgroundColor: AppColors.bg,
  elevation: 0,
  scrolledUnderElevation: 0,

  automaticallyImplyLeading: false,

  title: Text(
    'Hasil Analisis',
    style: AppText.body.copyWith(
      fontWeight: FontWeight.w600,
    ),
  ),

  centerTitle: true,
),

body: SingleChildScrollView(
  padding: EdgeInsets.fromLTRB(
    16,
    16,
    16,
    MediaQuery.of(context)
            .padding
            .bottom +
        40,
  ),

  child: Column(
    crossAxisAlignment:
        CrossAxisAlignment.start,

    children: [

      /// HERO CARD
_buildHeroCard(c),

const SizedBox(height: 16),

Text(
  'Foto Scan',

  style: AppText.label.copyWith(
    letterSpacing: 1.2,
    fontSize: 14,
    fontWeight: FontWeight.w700,
  ),
),

const SizedBox(height: 10),

ClipRRect(
  borderRadius:
      BorderRadius.circular(18),

  child: Image.asset(
    AppAssets.scalpSample,

    width: double.infinity,
    height: 220,
    fit: BoxFit.cover,
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

_InfoCard(
        title:
            'Tentang ${c.result.disease}',

        value:
            c.diseaseInfo.description,

        subtitle:
            'Penyebab: ${c.diseaseInfo.cause}',
      ),

      const SizedBox(height: 12),

      _SymptomCard(
        symptoms:
            c.diseaseInfo.symptoms,
      ),

      const SizedBox(height: 12),

      /// DISCLAIMER
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

      

      const SizedBox(height: 20),

      SizedBox(
        width: double.infinity,
        height: 54,

        child: ElevatedButton(
          onPressed:
              c.goToRecommendation,

          style:
              ElevatedButton.styleFrom(
            backgroundColor:
                AppColors.accent,

            foregroundColor:
                Colors.black,

            elevation: 0,

            shape:
                RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(
                14,
              ),
            ),
          ),

          child: const Text(
            'Lihat Rekomendasi',

            style: TextStyle(
              fontWeight:
                  FontWeight.bold,
            ),
          ),
        ),
      ),

      const SizedBox(height: 10),

      SizedBox(
        width: double.infinity,
        height: 54,

        child: OutlinedButton(
          onPressed: c.scanAgain,

          style:
              OutlinedButton.styleFrom(
            side: BorderSide(
              color: AppColors.accent
                  .withOpacity(0.3),
            ),

            shape:
                RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(
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
          
    );
  }

  /// HERO CARD
  Widget _buildHeroCard(
    ResultController c,
  ) {
    return Container(
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

        boxShadow: [
          BoxShadow(
            color: AppColors.accent
                .withOpacity(0.06),

            blurRadius: 30,
            spreadRadius: 1,
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          _SeverityPill(
            severity:
                c.result.severity,
          ),

          const SizedBox(height: 16),

          Row(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,

                  children: [

                    Text(
                      c.result.disease,

                      style: AppText
                        .headingMd
                        .copyWith(
                      fontSize: 24,
                      height: 1.25,
                    ),
                    ),

                    const SizedBox(
                        height: 6),

                    Text(
                      DateFormat(
                        'EEEE, d MMMM yyyy · HH:mm',
                        'id',
                      ).format(
                        c.result.scanDate,
                      ),

                      style: AppText
                          .caption
                          .copyWith(
                        color:
                            Colors.white54,
                      ),
                    ),
                  ],
                ),
              ),
 Transform.translate(
  offset: const Offset(-25, -10),

  child: Text(
    '${c.result.healthScore}%',

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

          const SizedBox(height: 18),

          Container(
            padding:
                const EdgeInsets.all(
              14,
            ),

            decoration: BoxDecoration(
              color: Colors.white
                  .withOpacity(0.04),

              borderRadius:
                  BorderRadius.circular(
                14,
              ),

              border: Border.all(
                color: Colors.white
                    .withOpacity(
                  0.05,
                ),
              ),
            ),

            child: Row(
              children: [

                const Icon(
                  Icons
                      .auto_awesome_rounded,
                  color:
                      AppColors.accent,
                  size: 18,
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: Text(
                    'AI mendeteksi kondisi scalp dengan keyakinan ${(c.confidence * 100).toStringAsFixed(1)}%.',

                    style: AppText
                        .caption
                        .copyWith(
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
}

/// SEVERITY
class _SeverityPill
    extends StatelessWidget {
  final String severity;

  const _SeverityPill({
    required this.severity,
  });

  @override
  Widget build(BuildContext context) {
    Color color;
    String label;

    switch (severity) {
      case 'ringan':
        color = const Color(
          0xFF4CAF50,
        );
        label = 'Ringan';
        break;

      case 'sedang':
        color = const Color(
          0xFFFFC107,
        );
        label = 'Sedang';
        break;

      case 'berat':
        color = const Color(
          0xFFF44336,
        );
        label = 'Berat';
        break;

      default:
        color = const Color(
          0xFFFFC107,
        );
        label = 'Sedang';
    }

    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 5,
      ),

      decoration: BoxDecoration(
        color:
            color.withOpacity(0.15),

        borderRadius:
            BorderRadius.circular(
          20,
        ),

        border: Border.all(
          color:
              color.withOpacity(0.5),
        ),
      ),

      child: Text(
        label,

        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight:
              FontWeight.w600,
        ),
      ),
    );
  }
}

/// GEJALA
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
