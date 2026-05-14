// ─────────────────────────────────────────────────────────────
// EXISTING MODELS (tidak diubah)
// ─────────────────────────────────────────────────────────────

class ScalpResult {
  final String disease;
  final double confidence;
  final int healthScore;
  final DateTime scanDate;
  final String description;
  final String recommendation;

  // ✅ TAMBAH: severity dari hasil adaptive questioning
  final String severity; // 'ringan' | 'sedang' | 'berat'

  ScalpResult({
    required this.disease,
    required this.confidence,
    required this.healthScore,
    required this.scanDate,
    required this.description,
    required this.recommendation,
    this.severity = 'ringan',
  });

  String get conditionLabel {
    if (healthScore >= 85) return 'Ringan';
    if (healthScore >= 70) return 'Sedang';
    return 'Perlu Perhatian';
  }

  factory ScalpResult.fromAI() {
    return ScalpResult(
      disease: 'Seborrheic Dermatitis',
      confidence: 0.99,
      healthScore: 78,
      scanDate: DateTime.now(),
      description: 'Terdapat indikasi kulit kepala berminyak disertai ketombe.',
      recommendation:
          'Gunakan sampo anti-ketombe secara rutin dan jaga kebersihan kulit kepala.',
      severity: 'sedang',
    );
  }
}

class Routine {
  final String name;
  final String duration;
  final String time;
  final String icon;
  bool isDone;

  Routine({
    required this.name,
    required this.duration,
    required this.time,
    required this.icon,
    this.isDone = false,
  });
}

class Recommendation {
  final String name;
  final String description;
  final String frequency;
  final String icon;
  final RecommendationType type;
  final String phase;

  const Recommendation({
    required this.name,
    required this.description,
    required this.frequency,
    required this.icon,
    required this.type,
    required this.phase,
  });
}

enum RecommendationType { daily, weekly, product }

class ScanHistory {
  final DateTime date;
  final int score;
  final double confidence;
  final int change;

  const ScanHistory({
    required this.date,
    required this.score,
    required this.confidence,
    required this.change,
  });
}

class HairProfile {
  final String type;
  final String subtype;
  final List<String> tags;
  final String washFreq;
  final String productType;
  final String activity;
  final String hairLength;

  const HairProfile({
    required this.type,
    required this.subtype,
    required this.tags,
    required this.washFreq,
    required this.productType,
    required this.activity,
    required this.hairLength,
  });
}

// ─────────────────────────────────────────────────────────────
// ✅ TAMBAHAN BARU: Adaptive Questioning Models
// ─────────────────────────────────────────────────────────────

class DiseaseQuestion {
  final String id;
  final String question;
  final List<String> options;

  const DiseaseQuestion({
    required this.id,
    required this.question,
    required this.options,
  });
}

class DiseaseAdvice {
  final String severity;       // 'ringan' | 'sedang' | 'berat'
  final String severityLabel;  // 'Ringan' | 'Sedang' | 'Berat'
  final List<String> treatments;
  final String doctorAdvice;

  const DiseaseAdvice({
    required this.severity,
    required this.severityLabel,
    required this.treatments,
    required this.doctorAdvice,
  });
}

class DiseaseInfo {
  final String key;        // sama dengan nama folder dataset
  final String name;       // nama lengkap penyakit
  final String emoji;
  final String description;
  final String cause;
  final List<String> symptoms;
  final List<DiseaseQuestion> questions;
  final Map<String, DiseaseAdvice> adviceByAnswers;

  const DiseaseInfo({
    required this.key,
    required this.name,
    required this.emoji,
    required this.description,
    required this.cause,
    required this.symptoms,
    required this.questions,
    required this.adviceByAnswers,
  });
}

// ─────────────────────────────────────────────────────────────
// ✅ DATA 5 PENYAKIT
// Key sesuai nama folder dataset:
//   alopecia | folliculitis | lice | seborrheic | tinea
// ─────────────────────────────────────────────────────────────

class DiseaseData {
  static const Map<String, DiseaseInfo> diseases = {

    // 1. ALOPECIA AREATA
    'alopecia': DiseaseInfo(
      key: 'alopecia',
      name: 'Alopecia Areata',
      emoji: '',
      description:
          'Kondisi autoimun di mana sistem imun menyerang folikel rambut sendiri, menyebabkan kerontokan mendadak berbentuk bulat atau oval.',
      cause: 'Gangguan autoimun, faktor genetik, dan stres.',
      symptoms: [
        'Kebotakan berbentuk bulat atau oval',
        'Rambut rontok mendadak',
        'Kulit kepala halus di area botak',
      ],
      questions: [
        DiseaseQuestion(
          id: 'duration',
          question: 'Sudah berapa lama rambut rontok di area ini?',
          options: ['Baru (< 1 minggu)', 'Beberapa minggu', 'Lebih dari 1 bulan'],
        ),
        DiseaseQuestion(
          id: 'spread',
          question: 'Bagaimana bentuk area yang botak?',
          options: ['Bulat kecil (< 2 cm)', 'Bulat besar atau meluas', 'Menyebar tidak beraturan'],
        ),
        DiseaseQuestion(
          id: 'family',
          question: 'Apakah ada anggota keluarga dengan kondisi serupa?',
          options: ['Tidak ada', 'Ada 1 orang', 'Ada beberapa orang'],
        ),
      ],
      adviceByAnswers: {
        'ringan': DiseaseAdvice(
          severity: 'ringan',
          severityLabel: 'Ringan',
          treatments: [
            'Hindari stres berlebih',
            'Konsumsi makanan bergizi (protein, zinc, biotin)',
            'Gunakan sampo lembut bebas sulfat',
            'Pijat kulit kepala secara rutin',
          ],
          doctorAdvice:
              'Pantau selama 4 minggu. Jika tidak membaik, segera konsultasi ke dokter kulit.',
        ),
        'sedang': DiseaseAdvice(
          severity: 'sedang',
          severityLabel: 'Sedang',
          treatments: [
            'Konsumsi suplemen biotin dan zinc',
            'Hindari styling rambut agresif',
            'Kelola stres dengan olahraga ringan',
          ],
          doctorAdvice:
              'Disarankan konsultasi ke dokter kulit dalam 1-2 minggu.',
        ),
        'berat': DiseaseAdvice(
          severity: 'berat',
          severityLabel: 'Berat',
          treatments: [
            'Hentikan penggunaan produk rambut keras',
            'Hindari paparan panas berlebih',
          ],
          doctorAdvice:
              'Segera ke dokter kulit. Kemungkinan diperlukan terapi kortikosteroid.',
        ),
      },
    ),

    // 2. FOLLICULITIS
    'folliculitis': DiseaseInfo(
      key: 'folliculitis',
      name: 'Folliculitis',
      emoji: '',
      description:
          'Peradangan atau infeksi pada folikel rambut yang menghasilkan benjolan merah kecil atau pustul berisi nanah di kulit kepala.',
      cause: 'Infeksi bakteri Staphylococcus, keringat berlebih, atau produk rambut yang menyumbat pori.',
      symptoms: [
        'Benjolan merah kecil di sekitar folikel',
        'Pustul berisi cairan atau nanah',
        'Rasa nyeri atau gatal',
      ],
      questions: [
        DiseaseQuestion(
          id: 'pain',
          question: 'Apakah benjolan terasa nyeri saat disentuh?',
          options: ['Tidak nyeri', 'Sedikit nyeri', 'Sangat nyeri'],
        ),
        DiseaseQuestion(
          id: 'pus',
          question: 'Apakah ada cairan atau nanah keluar dari benjolan?',
          options: ['Tidak ada', 'Sedikit cairan bening', 'Nanah kuning atau hijau'],
        ),
        DiseaseQuestion(
          id: 'product',
          question: 'Apakah baru-baru ini memakai produk rambut baru?',
          options: ['Tidak ada produk baru', 'Tidak yakin', 'Ya, baru memakai produk baru'],
        ),
      ],
      adviceByAnswers: {
        'ringan': DiseaseAdvice(
          severity: 'ringan',
          severityLabel: 'Ringan',
          treatments: [
            'Kompres hangat area yang meradang 10-15 menit',
            'Gunakan sampo antibakteri ringan',
            'Hindari produk rambut yang menyumbat pori',
          ],
          doctorAdvice:
              'Pantau 1-2 minggu. Jika tidak membaik atau menyebar, segera ke dokter.',
        ),
        'sedang': DiseaseAdvice(
          severity: 'sedang',
          severityLabel: 'Sedang',
          treatments: [
            'Kompres hangat 2x sehari',
            'Jangan memencet atau memecahkan benjolan',
            'Ganti produk rambut yang menjadi pemicu',
          ],
          doctorAdvice:
              'Konsultasi ke dokter untuk mendapatkan krim antibiotik topikal.',
        ),
        'berat': DiseaseAdvice(
          severity: 'berat',
          severityLabel: 'Berat',
          treatments: [
            'Jangan memencet benjolan bernanah',
            'Jaga area tetap bersih dan kering',
          ],
          doctorAdvice:
              'Segera ke dokter. Diperlukan antibiotik oral dengan resep dokter.',
        ),
      },
    ),

    // 3. HEAD LICE
    'lice': DiseaseInfo(
      key: 'lice',
      name: 'Head Lice',
      emoji: '',
      description:
          'Parasit serangga kecil yang hidup di kulit kepala dan menghisap darah, menyebabkan gatal hebat. Sangat menular lewat kontak langsung.',
      cause: 'Penularan melalui kontak kepala langsung atau berbagi sisir, topi, dan handuk.',
      symptoms: [
        'Gatal hebat terutama di belakang telinga dan tengkuk',
        'Kutu dewasa terlihat di rambut',
        'Telur kutu (nits) menempel di batang rambut',
      ],
      questions: [
        DiseaseQuestion(
          id: 'itch_location',
          question: 'Di mana rasa gatal paling terasa?',
          options: [
            'Seluruh kepala merata',
            'Terutama belakang telinga dan tengkuk',
            'Tidak terlalu gatal',
          ],
        ),
        DiseaseQuestion(
          id: 'contact',
          question: 'Apakah baru-baru ini kontak dengan penderita kutu?',
          options: [
            'Tidak ada kontak',
            'Mungkin ada kontak tidak langsung',
            'Ya, ada kontak kepala langsung',
          ],
        ),
        DiseaseQuestion(
          id: 'nits',
          question: 'Apakah terlihat bintik putih menempel di batang rambut?',
          options: ['Tidak terlihat', 'Ada sedikit', 'Banyak dan tersebar'],
        ),
      ],
      adviceByAnswers: {
        'ringan': DiseaseAdvice(
          severity: 'ringan',
          severityLabel: 'Ringan',
          treatments: [
            'Sisir rambut dengan sisir serit setiap hari',
            'Cuci semua perlengkapan kepala dengan air panas',
            'Periksa anggota keluarga lain',
          ],
          doctorAdvice:
              'Gunakan sisir serit rutin selama 2 minggu. Pantau perkembangannya.',
        ),
        'sedang': DiseaseAdvice(
          severity: 'sedang',
          severityLabel: 'Sedang',
          treatments: [
            'Gunakan sampo antiparasit (permethrin)',
            'Sisir dengan sisir serit setelah pemakaian',
            'Cuci semua kain yang bersentuhan dengan kepala',
          ],
          doctorAdvice:
              'Gunakan produk antiparasit dari apotek sesuai petunjuk.',
        ),
        'berat': DiseaseAdvice(
          severity: 'berat',
          severityLabel: 'Berat',
          treatments: [
            'Gunakan sampo antiparasit untuk seluruh keluarga',
            'Cuci semua bantal, topi, dan handuk dengan air panas',
          ],
          doctorAdvice:
              'Konsultasi ke dokter jika produk apotek tidak efektif setelah 2 kali pemakaian.',
        ),
      },
    ),

    // 4. SEBORRHEIC DERMATITIS
    'seborrheic': DiseaseInfo(
      key: 'seborrheic',
      name: 'Seborrheic Dermatitis',
      emoji: '',
      description:
          'Peradangan kulit kepala akibat pertumbuhan berlebih jamur Malassezia yang hidup secara alami di kulit. Ini adalah penyebab ketombe paling umum. Bersifat kronis tapi bisa dikendalikan dengan perawatan rutin.',
      cause: 'Pertumbuhan berlebih jamur Malassezia yang memecah sebum menjadi asam lemak iritatif. Diperparah oleh produksi minyak berlebih, perubahan hormonal, stres, cuaca dingin, dan sistem imun yang lemah.',
      symptoms: [
        'Ketombe berminyak berwarna kuning atau putih',
        'Kulit kepala kemerahan dan terasa gatal',
        'Sisik menempel di rambut dan bahu',
        'Bisa disertai rasa perih atau sensasi terbakar ringan'
      ],
      questions: [
        DiseaseQuestion(
          id: 'dandruff_type',
          question: 'Bagaimana kondisi ketombe yang kamu alami?',
          options: [
            'Ketombe kering dan halus',
            'Ketombe berminyak kuning',
            'Ketombe tebal menempel di kulit kepala',
          ],
        ),
        DiseaseQuestion(
          id: 'wash',
          question: 'Seberapa sering kamu keramas?',
          options: [
            'Setiap hari',
            '2-3 kali seminggu',
            'Seminggu sekali atau lebih jarang',
          ],
        ),
        DiseaseQuestion(
          id: 'trigger',
          question: 'Apakah kondisi memburuk dalam situasi tertentu?',
          options: [
            'Tidak ada perubahan',
            'Memburuk saat cuaca dingin atau kering',
            'Memburuk saat stres atau kelelahan',
          ],
        ),
      ],
      adviceByAnswers: {
        'ringan': DiseaseAdvice(
          severity: 'ringan',
          severityLabel: 'Ringan',
          treatments: [
            'Keramas lebih sering dengan sampo antiketombe',
            'Gunakan sampo zinc pyrithione atau selenium sulfide',
            'Hindari produk rambut berbahan minyak berat',
          ],
          doctorAdvice:
              'Coba sampo antiketombe 4 minggu. Konsultasi jika tidak ada perbaikan.',
        ),
        'sedang': DiseaseAdvice(
          severity: 'sedang',
          severityLabel: 'Sedang',
          treatments: [
            'Gunakan sampo antijamur (ketoconazole) secara rutin',
            'Hindari stres berlebih',
            'Konsumsi makanan bergizi seimbang',
          ],
          doctorAdvice:
              'Konsultasi ke dokter untuk sampo atau krim medis yang tepat.',
        ),
        'berat': DiseaseAdvice(
          severity: 'berat',
          severityLabel: 'Berat',
          treatments: [
            'Hentikan produk rambut berminyak',
            'Jaga kebersihan kulit kepala setiap hari',
          ],
          doctorAdvice:
              'Segera ke dokter. Mungkin diperlukan krim antijamur atau antiinflamasi.',
        ),
      },
    ),

    // 5. TINEA CAPITIS
    'tinea': DiseaseInfo(
      key: 'tinea',
      name: 'Tinea Capitis',
      emoji: '',
      description:
          'Infeksi jamur (ringworm) pada kulit kepala dan rambut yang sangat umum, terutama pada anak-anak. Sangat menular lewat kontak langsung.',
      cause: 'Infeksi jamur dermatofita, menular melalui kontak langsung atau berbagi alat rambut.',
      symptoms: [
        'Bercak botak bersisik',
        'Kemerahan dan gatal',
        'Rambut mudah patah di dekat kulit kepala',
      ],
      questions: [
        DiseaseQuestion(
          id: 'itch',
          question: 'Apakah area tersebut terasa gatal?',
          options: ['Tidak gatal', 'Sedikit gatal', 'Sangat gatal'],
        ),
        DiseaseQuestion(
          id: 'crust',
          question: 'Apakah ada keropeng, sisik tebal, atau bau tidak sedap?',
          options: ['Tidak ada', 'Ada sedikit sisik', 'Ada keropeng dan bau'],
        ),
        DiseaseQuestion(
          id: 'contact',
          question: 'Apakah sering berbagi sisir, handuk, atau topi?',
          options: ['Tidak pernah', 'Jarang', 'Sering'],
        ),
      ],
      adviceByAnswers: {
        'ringan': DiseaseAdvice(
          severity: 'ringan',
          severityLabel: 'Ringan',
          treatments: [
            'Gunakan sampo antijamur (ketoconazole atau selenium sulfide)',
            'Jangan berbagi sisir, handuk, atau topi',
            'Cuci bantal dan topi secara rutin',
          ],
          doctorAdvice:
              'Gunakan sampo antijamur 2-4 minggu. Jika tidak membaik, konsultasi ke dokter.',
        ),
        'sedang': DiseaseAdvice(
          severity: 'sedang',
          severityLabel: 'Sedang',
          treatments: [
            'Gunakan sampo antijamur setiap keramas',
            'Hindari berbagi semua alat rambut',
          ],
          doctorAdvice:
              'Konsultasi ke dokter untuk obat antijamur oral yang tepat.',
        ),
        'berat': DiseaseAdvice(
          severity: 'berat',
          severityLabel: 'Berat',
          treatments: [
            'Cuci semua perlengkapan kepala dengan air panas',
            'Hindari kontak rambut dengan orang lain',
          ],
          doctorAdvice:
              'Segera ke dokter. Diperlukan antijamur oral (griseofulvin) dengan resep.',
        ),
      },
    ),
  };

  static DiseaseInfo? getDisease(String key) => diseases[key];

  /// Hitung severity dari jawaban user
  static String calculateSeverity(List<String> answers) {
    int score = 0;
    for (final a in answers) {
      final lower = a.toLowerCase();
      if (lower.contains('sangat') ||
          lower.contains('sering') ||
          lower.contains('banyak') ||
          lower.contains('hijau') ||
          lower.contains('langsung') ||
          lower.contains('beberapa') ||
          lower.contains('lebih dari') ||
          lower.contains('tebal') ||
          lower.contains('keras')) {
        score += 2;
      } else if (lower.contains('sedikit') ||
          lower.contains('kadang') ||
          lower.contains('mungkin') ||
          lower.contains('jarang') ||
          lower.contains('bening') ||
          lower.contains('baru') ||
          lower.contains('berminyak')) {
        score += 1;
      }
    }
    if (score <= 2) return 'ringan';
    if (score <= 4) return 'sedang';
    return 'berat';
  }

  /// Konversi severity ke healthScore (untuk kompatibilitas ScalpResult)
  static int severityToHealthScore(String severity) {
    switch (severity) {
      case 'ringan': return 85;
      case 'sedang': return 72;
      case 'berat':  return 55;
      default:       return 72;
    }
  }
}