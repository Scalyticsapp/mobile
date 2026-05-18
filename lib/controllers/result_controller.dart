import 'package:get/get.dart';

import '../data/models/scalp_result.dart';
import '../routes/app_routes.dart';

class ResultController
    extends GetxController {
  // ✅ LOADING
  final RxBool isLoading =
      true.obs;

  final RxInt currentStep =
      0.obs;

  final List<String> steps = [
    'Gambar diterima',
    'Pre-processing selesai',
    'Deteksi AI berjalan',
    'Analisis kondisi scalp',
    'Membuat rekomendasi',
  ];

  // ✅ RESULT DATA
  late ScalpResult result;

  late DiseaseInfo diseaseInfo;

  late DiseaseAdvice advice;

  late double confidence;

  late String imagePath;

  @override
  void onInit() {
    super.onInit();

    _initializeResult();
  }

  // ✅ INITIALIZE RESULT
  void _initializeResult() {
    final Map<String, dynamic>
        args =
        Get.arguments
                as Map<String,
                    dynamic>? ??
            {};

    final String diseaseKey =
        args['diseaseKey'] ??
            'seborrheic';

    final String diseaseName =
        args['diseaseName'] ??
            'Unknown';

    final String severity =
        args['severity'] ??
            'ringan';

    confidence =
        ((args['confidence'] ??
                    0.80)
                as num)
            .toDouble();

    imagePath =
        args['imagePath'] ?? '';

    diseaseInfo =
        args['diseaseInfo']
                as DiseaseInfo? ??
            DiseaseData.getDisease(
              diseaseKey,
            ) ??
            DiseaseData
                .diseases[
                    'seborrheic']!;

    advice =
        args['advice']
                as DiseaseAdvice? ??
            diseaseInfo
                .adviceByAnswers[
                    severity]!;

    result = ScalpResult(
      disease: diseaseName,
      confidence: confidence,
      healthScore: 78,
      scanDate: DateTime.now(),
      description:
          diseaseInfo.description,
      recommendation:
          advice.treatments.join(
        ', ',
      ),
      severity: severity,
    );

    isLoading.value = false;
  }

  // ✅ SIMULATE LOADING STEP
  Future<void>
      simulateSteps() async {
    isLoading.value = true;

    for (
      int i = 0;
      i < steps.length;
      i++
    ) {
      await Future.delayed(
        const Duration(
          milliseconds: 700,
        ),
      );

      currentStep.value = i + 1;
    }

    isLoading.value = false;
  }

  // ✅ NAVIGATE TO RECOMMENDATION
  void goToRecommendation() {
    Get.toNamed(
      AppRoutes.recommendation,
      arguments: result,
    );
  }

  // ✅ SCAN AGAIN
  void scanAgain() {
    Get.offAllNamed(
      AppRoutes.scan,
    );
  }

  // ✅ GO TO DASHBOARD
  void goToDashboard() {
    Get.offAllNamed(
      AppRoutes.dashboard,
    );
  }
}