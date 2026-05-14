import 'package:get/get.dart';
import '../models/scalp_result.dart';
import '../routes/app_routes.dart';

class ResultController extends GetxController {
  // Loading steps (dipakai di loading_view)
  final isLoading = true.obs;
  final currentStep = 0.obs;
  final steps = [
    'Gambar diterima',
    'Pre-processing selesai',
    'Deteksi AI berjalan',
    'Analisis kondisi scalp',
    'Membuat rekomendasi',
  ];

  // ✅ Data hasil dari questioning
  late ScalpResult result;
  late DiseaseInfo diseaseInfo;
  late DiseaseAdvice advice;
  late double confidence;
  late String imagePath;

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments as Map<String, dynamic>? ?? {};

    // ✅ Baca semua data dari question_view
    final String diseaseKey   = args['diseaseKey']   ?? 'seborrheic';
    final String diseaseName  = args['diseaseName']  ?? 'Unknown';
    final String severity     = args['severity']     ?? 'ringan';
    confidence                = ((args['confidence'] ?? 0.80) as num).toDouble();
    imagePath                 = args['imagePath']    ?? '';

    diseaseInfo = args['diseaseInfo'] as DiseaseInfo?
        ?? DiseaseData.getDisease(diseaseKey)
        ?? DiseaseData.diseases['seborrheic']!;

    advice = args['advice'] as DiseaseAdvice?
        ?? diseaseInfo.adviceByAnswers[severity]!;

    // ✅ Buat ScalpResult dari data questioning
    result = ScalpResult(
      disease: diseaseName,
      confidence: confidence,
      healthScore: 78,
      scanDate: DateTime.now(),
      description: diseaseInfo.description,
      recommendation: advice.treatments.join(', '),
      severity: severity,
    );

    isLoading.value = false;
  }

  // Untuk loading_view (jika masih dipakai)
  Future<void> simulateSteps() async {
    isLoading.value = true;
    for (int i = 0; i < steps.length; i++) {
      await Future.delayed(const Duration(milliseconds: 700));
      currentStep.value = i + 1;
    }
    isLoading.value = false;
  }

  void goToRecommendation() {
    Get.toNamed(AppRoutes.recommendation, arguments: result);
  }

  void scanAgain() {
    Get.offAllNamed(AppRoutes.scan);
  }

  void goToDashboard() {
    Get.offAllNamed(AppRoutes.dashboard);
  }
}