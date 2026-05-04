import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/app_theme.dart';
import '../../routes/app_routes.dart';
import '../../controllers/scan_controller.dart';

class QuestionView extends StatefulWidget {
  const QuestionView({super.key});

  @override
  State<QuestionView> createState() => _QuestionViewState();
}

class _QuestionViewState extends State<QuestionView> {
  late String disease;

  int currentIndex = 0;
  int score = 0;

  Map<String, String> answers = {};

  // 🔥 DATA ADAPTIVE QUESTION
  final Map<String, List<Map<String, dynamic>>> diseaseQuestions = {
    "psoriasis": [
      {"q": "Apakah kulit terasa tebal dan bersisik perak?", "w": 3},
      {"q": "Apakah semakin parah saat stres?", "w": 2},
      {"q": "Apakah sisik berdarah saat digaruk?", "w": 4},
    ],
    "alopecia": [
      {"q": "Sudah berapa lama rambut rontok di area ini?", "w": 3},
      {"q": "Apakah area botak berbentuk bulat?", "w": 2},
      {"q": "Apakah ada riwayat keluarga?", "w": 2},
    ],
    "tinea": [
      {"q": "Apakah area terasa gatal?", "w": 3},
      {"q": "Apakah ada keropeng atau bau?", "w": 3},
      {"q": "Apakah sering berbagi sisir/handuk?", "w": 2},
    ],
    "dermatitis": [
      {"q": "Ketombe berminyak atau kering?", "w": 2},
      {"q": "Seberapa sering kamu keramas?", "w": 2},
      {"q": "Apakah memburuk di cuaca tertentu?", "w": 2},
    ],
    "lice": [
      {"q": "Apakah gatal di belakang telinga?", "w": 3},
      {"q": "Apakah kontak dengan penderita kutu?", "w": 3},
      {"q": "Apakah ada bintik putih di rambut?", "w": 3},
    ],
    "folliculitis": [
      {"q": "Apakah benjolan terasa nyeri?", "w": 3},
      {"q": "Apakah ada nanah keluar?", "w": 4},
      {"q": "Apakah pakai produk baru?", "w": 2},
    ],
  };

  List<Map<String, dynamic>> questions = [];

  @override
  void initState() {
    super.initState();

    final args = Get.arguments;
    disease = args?["disease"] ?? "psoriasis";

    questions = diseaseQuestions[disease] ?? diseaseQuestions["psoriasis"]!;
  }

  @override
  Widget build(BuildContext context) {
    final q = questions[currentIndex];

    return Scaffold(
      backgroundColor: const Color(0xFF060606),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// HEADER
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: const Icon(Icons.arrow_back_ios_new_rounded,
                        size: 18, color: AppColors.textPrimary),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Pertanyaan',
                    style: AppText.body.copyWith(fontWeight: FontWeight.w600),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              /// PROGRESS
              LinearProgressIndicator(
                value: (currentIndex + 1) / questions.length,
                color: AppColors.accent,
                backgroundColor: Colors.white10,
              ),

              const SizedBox(height: 24),

              Text(
                "Pertanyaan ${currentIndex + 1}",
                style: AppText.caption,
              ),

              const SizedBox(height: 10),

              Text(
                q["q"],
                style: AppText.headingMd.copyWith(fontSize: 18),
              ),

              const SizedBox(height: 30),

              _option("Ya", "yes"),
              _option("Sedikit", "mild"),
              _option("Tidak", "no"),

              const Spacer(),

              /// NEXT BUTTON
              GestureDetector(
                onTap: () {
                  if (!answers.containsKey("q$currentIndex")) {
                    Get.snackbar("Oops", "Pilih jawaban dulu");
                    return;
                  }

                  if (currentIndex < questions.length - 1) {
                    setState(() => currentIndex++);
                  } else {
                    _finish();
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: AppColors.accent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      'Lanjut',
                      style: TextStyle(
                          fontWeight: FontWeight.w600, color: Colors.black),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _option(String text, String value) {
    final isSelected = answers["q$currentIndex"] == value;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: () {
          setState(() {
            answers["q$currentIndex"] = value;
          });
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.accent.withOpacity(0.2)
                : AppColors.s2,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? AppColors.accent : AppColors.border,
            ),
          ),
          child: Center(child: Text(text)),
        ),
      ),
    );
  }

  void _finish() {
    score = 0;

    for (int i = 0; i < questions.length; i++) {
      final answer = answers["q$i"];
      final int weight = questions[i]["w"] as int;

      int val = 0;
      if (answer == "yes") val = 2;
      if (answer == "mild") val = 1;

      score += val * weight;
    }

    String severity;
    if (score <= 4) {
      severity = "Ringan";
    } else if (score <= 8) {
      severity = "Sedang";
    } else {
      severity = "Berat";
    }

    final controller = Get.find<ScanController>();

    Get.toNamed(AppRoutes.loading, arguments: {
      "disease": disease,
      "score": score,
      "severity": severity,
    });
  }
}