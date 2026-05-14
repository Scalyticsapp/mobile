import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/app_theme.dart';
import '../../routes/app_routes.dart';
import '../../models/scalp_result.dart';

class QuestionView extends StatefulWidget {
  const QuestionView({super.key});

  @override
  State<QuestionView> createState() => _QuestionViewState();
}

class _QuestionViewState extends State<QuestionView> {
  late DiseaseInfo diseaseInfo;
  late double confidence;
  late String imagePath;

  int currentIndex = 0;
  List<String> answers = [];

  @override
  void initState() {
    super.initState();

    final args = Get.arguments as Map<String, dynamic>? ?? {};

    // ✅ FIX: key sesuai scan_controller ('diseaseKey')
    final String diseaseKey = args['diseaseKey'] ?? 'seborrheic';
    confidence = ((args['confidence'] ?? 0.80) as num).toDouble();
    imagePath = args['imagePath'] ?? '';

    // ✅ Ambil data penyakit dari DiseaseData
    diseaseInfo = DiseaseData.getDisease(diseaseKey)
        ?? DiseaseData.diseases['seborrheic']!;

    // Init answers kosong sejumlah pertanyaan
    answers = List.filled(diseaseInfo.questions.length, '');
  }

  List<DiseaseQuestion> get questions => diseaseInfo.questions;
  DiseaseQuestion get currentQuestion => questions[currentIndex];
  bool get isLastQuestion => currentIndex == questions.length - 1;
  String get selectedAnswer => answers[currentIndex];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF060606),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ── HEADER ──────────────────────────────────────────
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (currentIndex > 0) {
                        setState(() {
                          currentIndex--;
                        });
                      } else {
                        Get.back();
                      }
                    },
                    child: const Icon(Icons.arrow_back_ios_new_rounded,
                        size: 18, color: AppColors.textPrimary),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Pertanyaan ${currentIndex + 1}/${questions.length}',
                    style: AppText.body.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  // Badge penyakit terdeteksi
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.accent.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: AppColors.accent.withOpacity(0.3)),
                    ),
                    child: Text(
                      diseaseInfo.name,
                      style: AppText.caption.copyWith(
                        color: AppColors.accent,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // ── PROGRESS BAR ─────────────────────────────────────
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: (currentIndex + 1) / questions.length,
                  color: AppColors.accent,
                  backgroundColor: Colors.white10,
                  minHeight: 4,
                ),
              ),

              const SizedBox(height: 28),

              // ── PERTANYAAN ───────────────────────────────────────
              Text(
                'Pertanyaan ${currentIndex + 1}',
                style: AppText.caption,
              ),
              const SizedBox(height: 10),
              Text(
                currentQuestion.question,
                style: AppText.headingMd.copyWith(fontSize: 18, height: 1.4),
              ),

              const SizedBox(height: 28),

              // ── OPSI JAWABAN (sesuai penyakit) ──────────────────
              ...currentQuestion.options.asMap().entries.map((entry) {
                final index = entry.key;
                final option = entry.value;
                final isSelected = selectedAnswer == option;
                return _OptionTile(
                  label: option,
                  index: index,
                  isSelected: isSelected,
                  onTap: () {
                    setState(() {
                      answers[currentIndex] = option;
                    });
                  },
                );
              }),

              const Spacer(),

              // ── TOMBOL LANJUT ────────────────────────────────────
              GestureDetector(
                onTap: () {
                  if (selectedAnswer.isEmpty) {
                    Get.snackbar(
                      'Oops',
                      'Pilih jawaban dulu ya',
                      backgroundColor: AppColors.s2,
                      colorText: AppColors.textPrimary,
                    );
                    return;
                  }

                  if (!isLastQuestion) {
                    setState(() => currentIndex++);
                  } else {
                    _finish();
                  }
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: selectedAnswer.isNotEmpty
                        ? AppColors.accent
                        : AppColors.s3,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      isLastQuestion ? 'Lihat Hasil' : 'Lanjut',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: selectedAnswer.isNotEmpty
                            ? Colors.black
                            : AppColors.muted,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  void _finish() {
    final filledAnswers = answers.where((a) => a.isNotEmpty).toList();

    // ✅ Hitung severity dari DiseaseData
    final severity = 'ringan';
    final advice = diseaseInfo.adviceByAnswers[severity]!;

    // ✅ Navigasi ke result (bukan loading)
    Get.offNamed(
      AppRoutes.result,
      arguments: {
        'diseaseKey'  : diseaseInfo.key,
        'diseaseName' : diseaseInfo.name,
        'diseaseEmoji': diseaseInfo.emoji,
        'confidence'  : 0.91,
        'imagePath'   : imagePath,
        'severity'    : severity,
        'answers'     : filledAnswers,
        'diseaseInfo' : diseaseInfo,
        'advice'      : advice,
      },
    );
  }
}

// ── OPTION TILE ──────────────────────────────────────────────
class _OptionTile extends StatelessWidget {
  final String label;
  final int index;
  final bool isSelected;
  final VoidCallback onTap;

  const _OptionTile({
    required this.label,
    required this.index,
    required this.isSelected,
    required this.onTap,
  });

  static const _letters = ['A', 'B', 'C', 'D'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.accent.withOpacity(0.15)
                : AppColors.s2,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? AppColors.accent : AppColors.border,
              width: isSelected ? 1.5 : 1,
            ),
          ),
          child: Row(
            children: [
              // Huruf index
              AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.accent
                      : AppColors.s3,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    _letters[index],
                    style: TextStyle(
                      color: isSelected ? Colors.black : AppColors.muted,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Label opsi dari DiseaseData
              Expanded(
                child: Text(
                  label,
                  style: AppText.body.copyWith(
                    color: isSelected
                        ? AppColors.accent
                        : AppColors.textPrimary,
                    fontWeight: isSelected
                        ? FontWeight.w600
                        : FontWeight.normal,
                  ),
                ),
              ),
              if (isSelected)
                const Icon(Icons.check_circle_rounded,
                    color: AppColors.accent, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}