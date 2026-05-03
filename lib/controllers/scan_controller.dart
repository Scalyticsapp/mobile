import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import '../routes/app_routes.dart';
import 'package:camera/camera.dart';

class ScanController extends GetxController {
  final _picker = ImagePicker();

  final selectedZone = 'Puncak'.obs;
  final isFlashOn = false.obs;
  final isMacroMode = false.obs;
  final isCapturing = false.obs; // 🔥 loading state saat capture

  CameraController? cameraController;

  final zones = ['Puncak', 'Sisi Kiri', 'Sisi Kanan', 'Belakang'];
  final images = <String>[].obs;

  // ✅ TAMBAH DI SINI
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

      // Pastikan flash tidak nyala saat capture (kecuali user yang nyalain manual)
      if (!isFlashOn.value) {
        await cameraController!.setFlashMode(FlashMode.off);
      }

      final XFile file = await cameraController!.takePicture();
      final processed = await _processImage(file.path);
      addImage(processed);

      if (images.length >= 4) {
        startAnalysis();
      }
    } catch (e) {
      Get.snackbar('Error', 'Gagal mengambil foto: $e');
    } finally {
      isCapturing.value = false;
    }
  }

  /// 📂 GALLERY (tetap pakai picker)
  Future<void> pickFromGallery() async {
    final file = await _picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      final processed = await _processImage(file.path);
      addImage(processed);
      if (images.length >= 4) startAnalysis();
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
    img.Image resized = img.copyResize(cropped, width: image.width);
    img.adjustColor(resized, contrast: 1.2, saturation: 1.1);

    final newPath = path.replaceAll('.jpg', '_enhanced.jpg');
    File(newPath).writeAsBytesSync(img.encodeJpg(resized));
    return newPath;
  }

  void addImage(String path) => images.add(path);
  void removeImage(int index) => images.removeAt(index);

  void startAnalysis() {
    if (images.length < 4) return;
    Get.toNamed(AppRoutes.question);
  }
}