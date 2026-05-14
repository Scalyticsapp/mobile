import 'dart:io';
import 'dart:math';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import '../routes/app_routes.dart';
import 'package:camera/camera.dart';

class ScanController extends GetxController {
  final _picker = ImagePicker();

  final selectedZone = 'Scalp'.obs;
  final isFlashOn = false.obs;
  final isMacroMode = false.obs;
  final isCapturing = false.obs;

  CameraController? cameraController;

  final zones = ['Scalp'];
  final images = <String>[].obs;

  String? userDandruff;
  String? userOil;

  void selectZone(String zone) => selectedZone.value = zone;

  Future<void> toggleFlash() async {
    isFlashOn.value = !isFlashOn.value;
    if (cameraController != null && cameraController!.value.isInitialized) {
      await cameraController!.setFlashMode(
        isFlashOn.value ? FlashMode.torch : FlashMode.off,
      );
    }
  }

  void toggleMacro() => isMacroMode.value = !isMacroMode.value;

  Future<void> captureFromViewfinder() async {
    if (cameraController == null || !cameraController!.value.isInitialized) return;
    if (isCapturing.value) return;

    try {
      isCapturing.value = true;
      if (!isFlashOn.value) {
        await cameraController!.setFlashMode(FlashMode.off);
      }

      final XFile file = await cameraController!.takePicture();
      final processed = await _processImage(file.path);

      images.clear();
      addImage(processed);

      await startAnalysis();
    } catch (e) {
      Get.snackbar('Error', 'Gagal mengambil foto: $e');
    } finally {
      isCapturing.value = false;
    }
  }

  Future<void> pickFromGallery() async {
    final file = await _picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      final processed = await _processImage(file.path);
      images.clear();
      addImage(processed);
      await startAnalysis();
    }
  }

  Future<String> _processImage(String path) async {
    if (isMacroMode.value) return path;
    return await _enhanceImage(path);
  }

  Future<String> _enhanceImage(String path) async {
    final bytes = await File(path).readAsBytes();
    final image = img.decodeImage(bytes);
    if (image == null) return path;

    final cropSize = (image.width * 0.6).toInt();
    final offsetX = ((image.width - cropSize) / 2).toInt();
    final offsetY = ((image.height - cropSize) / 2).toInt();

    img.Image cropped = img.copyCrop(
      image,
      x: offsetX,
      y: offsetY,
      width: cropSize,
      height: cropSize,
    );

    img.Image resized = img.copyResize(cropped, width: 224, height: 224);
    img.adjustColor(resized, contrast: 1.2, saturation: 1.1);

    final newPath = path.replaceAll('.jpg', '_enhanced.jpg');
    File(newPath).writeAsBytesSync(img.encodeJpg(resized));
    return newPath;
  }

  void addImage(String path) => images.add(path);
  void removeImage(int index) => images.removeAt(index);

  // ✅ FIX: startAnalysis sekarang async + pass diseaseKey & confidence
  Future<void> startAnalysis() async {
    if (images.isEmpty) return;

    // Navigasi ke loading dulu
    Get.toNamed(AppRoutes.loading);

    // Simulasi proses CNN (ganti dengan model asli nanti)
    await Future.delayed(const Duration(seconds: 3));

    // TODO: ganti bagian ini dengan output model CNN yang sesungguhnya
    // Contoh output model: {'key': 'seborrheic', 'confidence': 0.87}
    final result = _dummyDetect();

    // Navigasi ke question dengan data penyakit yang terdeteksi
    Get.offNamed(
      AppRoutes.question,
      arguments: {
        'diseaseKey': result['key'],       // 'alopecia' | 'folliculitis' | 'lice' | 'seborrheic' | 'tinea'
        'confidence': result['confidence'], // 0.0 - 1.0
        'imagePath': images.first,
      },
    );
  }

  // ── DUMMY DETECT ─────────────────────────────────────────────
  // Hapus fungsi ini dan ganti dengan CNN asli
  Map<String, dynamic> _dummyDetect() {
  return {
    'key': 'seborrheic',
    'confidence': 0.91,
  };
}
}