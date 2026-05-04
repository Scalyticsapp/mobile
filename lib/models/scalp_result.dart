class ScalpResult {
  final double dandruffPct;
  final double oilyPct;
  final double dryPct;
  final int healthScore;
  final DateTime scanDate;
  final String dandruffCause;
  final String oilyCause;
  final String dryCause;

  ScalpResult({
    required this.dandruffPct,
    required this.oilyPct,
    required this.dryPct,
    required this.healthScore,
    required this.scanDate,
    this.dandruffCause = 'Jarang keramas & kelembapan tinggi',
    this.oilyCause = 'Produksi sebum berlebih di area puncak',
    this.dryCause = 'Area sisi dalam kondisi baik',
  });

  String get conditionLabel {
    if (healthScore >= 80) return 'Sangat Baik';
    if (healthScore >= 65) return 'Cukup Baik';
    if (healthScore >= 50) return 'Perlu Perhatian';
    return 'Perlu Penanganan Segera';
  }

  // Simulate AI result - in real app this comes from backend
  factory ScalpResult.fromAI() => ScalpResult(
        dandruffPct: 42,
        oilyPct: 31,
        dryPct: 18,
        healthScore: 75,
        scanDate: DateTime.now(),
      );
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
  final double dandruffPct;
  final int change;

  const ScanHistory({
    required this.date,
    required this.score,
    required this.dandruffPct,
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