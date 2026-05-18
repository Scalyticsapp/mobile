import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/theme/app_theme.dart';

import '../../data/models/scalp_result.dart';

import '../../routes/app_routes.dart';

import '../../widgets/background_glow.dart';
import '../../widgets/app_pill.dart';
import '../../widgets/option_tile.dart';

class QuestionView
    extends StatefulWidget {
  const QuestionView({
    super.key,
  });

  @override
  State<QuestionView>
      createState() =>
          _QuestionViewState();
}

class _QuestionViewState
    extends State<QuestionView> {
  late DiseaseInfo
      diseaseInfo;

  late double confidence;

  late String imagePath;

  int currentIndex = 0;

  List<String> answers = [];

  @override
  void initState() {
    super.initState();

    _initializeArguments();
  }

  /// INIT ARGUMENTS
  void _initializeArguments() {
    final args =
        Get.arguments
                as Map<String,
                    dynamic>? ??
            {};

    final String diseaseKey =
        args['diseaseKey'] ??
            'seborrheic';

    confidence =
        ((args['confidence'] ??
                    0.80)
                as num)
            .toDouble();

    imagePath =
        args['imagePath'] ?? '';

    diseaseInfo =
        DiseaseData.getDisease(
              diseaseKey,
            ) ??
            DiseaseData.diseases[
                'seborrheic']!;

    answers = List.filled(
      diseaseInfo.questions.length,
      '',
    );
  }

  /// GETTERS
  List<DiseaseQuestion>
      get questions =>
          diseaseInfo.questions;

  DiseaseQuestion
      get currentQuestion =>
          questions[currentIndex];

  bool get isLastQuestion =>
      currentIndex ==
      questions.length - 1;

  String get selectedAnswer =>
      answers[currentIndex];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFF060606),

      body: Stack(
        children: [
          const BackgroundGlow(),

          SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.all(
              16,
            ),

            child: Column(
            crossAxisAlignment:
                CrossAxisAlignment
                    .start,

            children: [
              /// HEADER
              _buildHeader(),

              const SizedBox(
                height: 20,
              ),

              /// PROGRESS
              _buildProgressBar(),

              const SizedBox(
                height: 28,
              ),

              /// QUESTION
              _buildQuestion(),

              const SizedBox(
                height: 28,
              ),

              /// OPTIONS
              ...currentQuestion
                  .options
                  .asMap()
                  .entries
                  .map(
                    (entry) =>
                        OptionTile(
                      label:
                          entry.value,

                      index:
                          entry.key,

                      isSelected:
                          selectedAnswer ==
                              entry.value,

                      onTap: () {
                        setState(() {
                          answers[
                                  currentIndex] =
                              entry
                                  .value;
                        });
                      },
                    ),
                  ),

              const Spacer(),

              /// BUTTON
              _buildContinueButton(),

              const SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      ),
    ],
  ),
);
}

  /// HEADER
  Widget _buildHeader() {
    return Row(
      children: [
        GestureDetector(
          onTap: _handleBack,

          child: const Icon(
            Icons
                .arrow_back_ios_new_rounded,

            size: 18,

            color:
                AppColors.textPrimary,
          ),
        ),

        const SizedBox(
          width: 12,
        ),

        Text(
          'Pertanyaan ${currentIndex + 1}/${questions.length}',

          style:
              AppText.body.copyWith(
            fontWeight:
                FontWeight.w600,
          ),
        ),

        const Spacer(),

        AppPill.green(
          diseaseInfo.name,
        ),     
      ],
    );
  }

  /// PROGRESS BAR
  Widget _buildProgressBar() {
    return ClipRRect(
      borderRadius:
          BorderRadius.circular(4),

      child: LinearProgressIndicator(
        value:
            (currentIndex + 1) /
                questions.length,

        color: AppColors.accent,

        backgroundColor:
            Colors.white10,

        minHeight: 4,
      ),
    );
  }

  /// QUESTION
  Widget _buildQuestion() {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,

      children: [
        Text(
          'Pertanyaan ${currentIndex + 1}',

          style: AppText.caption,
        ),

        const SizedBox(
          height: 10,
        ),

        Text(
          currentQuestion.question,

          style:
              AppText.headingMd.copyWith(
            fontSize: 18,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  /// CONTINUE BUTTON
  Widget _buildContinueButton() {
    return GestureDetector(
      onTap: _handleContinue,

      child: AnimatedContainer(
        duration:
            const Duration(
          milliseconds: 200,
        ),

        width: double.infinity,

        padding:
            const EdgeInsets.symmetric(
          vertical: 16,
        ),

        decoration: BoxDecoration(
          color:
              selectedAnswer
                      .isNotEmpty
                  ? AppColors.accent
                  : AppColors.s3,

          borderRadius:
              BorderRadius.circular(
            12,
          ),
        ),

        child: Center(
          child: Text(
            isLastQuestion
                ? 'Lihat Hasil'
                : 'Lanjut',

            style: TextStyle(
              fontWeight:
                  FontWeight.w600,

              color:
                  selectedAnswer
                          .isNotEmpty
                      ? Colors.black
                      : AppColors
                          .muted,
            ),
          ),
        ),
      ),
    );
  }

  /// HANDLE BACK
  void _handleBack() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
      });

      return;
    }

    Get.back();
  }

  /// HANDLE CONTINUE
  void _handleContinue() {
    if (selectedAnswer.isEmpty) {
      Get.snackbar(
        'Oops',
        'Pilih jawaban dulu ya',

        backgroundColor:
            AppColors.s2,

        colorText:
            AppColors.textPrimary,
      );

      return;
    }

    if (!isLastQuestion) {
      setState(() {
        currentIndex++;
      });

      return;
    }

    _finish();
  }

  /// FINISH
  void _finish() {
    final filledAnswers =
        answers
            .where(
              (answer) =>
                  answer.isNotEmpty,
            )
            .toList();

    final severity =
        'ringan';

    final advice =
        diseaseInfo
            .adviceByAnswers[
                severity]!;

    Get.offNamed(
      AppRoutes.result,

      arguments: {
        'diseaseKey':
            diseaseInfo.key,

        'diseaseName':
            diseaseInfo.name,

        'diseaseEmoji':
            diseaseInfo.emoji,

        'confidence': 0.91,

        'imagePath':
            imagePath,

        'severity':
            severity,

        'answers':
            filledAnswers,

        'diseaseInfo':
            diseaseInfo,

        'advice':
            advice,
      },
    );
  }
}