import 'package:get/get.dart';
import '../models/scalp_result.dart';
import '../routes/app_routes.dart';

class ResultController extends GetxController {
  final isLoading = true.obs;
  final currentStep = 0.obs;
  final result = Rxn<ScalpResult>();

  final steps = [
    'Gambar diterima',
    'Pre-processing selesai',
    'Deteksi CNN berjalan',
    'Analisis penyebab',
    'Membuat rekomendasi',
  ];

  @override
  void onInit() {
    super.onInit();
    _simulateAIProcessing();
  }

  Future<void> _simulateAIProcessing() async {
    for (int i = 0; i < steps.length; i++) {
      await Future.delayed(const Duration(milliseconds: 900));
      currentStep.value = i + 1;
    }
    await Future.delayed(const Duration(milliseconds: 500));
    result.value = ScalpResult.fromAI();
    isLoading.value = false;
    Get.toNamed(AppRoutes.result, arguments: result.value);
  }
}
