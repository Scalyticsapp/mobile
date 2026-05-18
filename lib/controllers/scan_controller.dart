import 'dart:io';

import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';

import '../routes/app_routes.dart';

class ScanController extends GetxController {
  final ImagePicker _picker = ImagePicker();

  final RxString selectedZone = 'Scalp'.obs;

  final RxBool isFlashOn = false.obs;

  final RxBool isMacroMode = false.obs;

  final RxBool isCapturing = false.obs;

  final RxList<String> images = <String>[].obs;

  final List<String> zones = [
    'Scalp',
  ];

  CameraController? cameraController;

  String? userDandruff;
  String? userOil;

  // SELECT ZONE
  void selectZone(String zone) {
    selectedZone.value = zone;
  }

  // TOGGLE FLASH
  Future<void> toggleFlash() async {
    isFlashOn.value = !isFlashOn.value;

    if (cameraController == null || !cameraController!.value.isInitialized) {
      return;
    }

    await cameraController!.setFlashMode(
      isFlashOn.value ? FlashMode.torch : FlashMode.off,
    );
  }

  // TOGGLE MACRO
  void toggleMacro() {
    isMacroMode.value = !isMacroMode.value;
  }

  // CAMERA CAPTURE
  Future<void> captureFromViewfinder() async {
    if (cameraController == null || !cameraController!.value.isInitialized) {
      return;
    }

    if (isCapturing.value) {
      return;
    }

    try {
      isCapturing.value = true;

      if (!isFlashOn.value) {
        await cameraController!.setFlashMode(
          FlashMode.off,
        );
      }

      final XFile file = await cameraController!.takePicture();

      final String processedPath = await _processImage(
        file.path,
      );

      images.clear();

      addImage(processedPath);

      await startAnalysis();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal mengambil foto',
      );
    } finally {
      isCapturing.value = false;
    }
  }

  // PICK FROM GALLERY
  Future<void> pickFromGallery() async {
    final XFile? file = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    if (file == null) {
      return;
    }

    final String processedPath = await _processImage(
      file.path,
    );

    images.clear();

    addImage(processedPath);

    await startAnalysis();
  }

  // PROCESS IMAGE
  Future<String> _processImage(
    String path,
  ) async {
    if (isMacroMode.value) {
      return path;
    }

    return await _enhanceImage(
      path,
    );
  }

  // ENHANCE IMAGE
  Future<String> _enhanceImage(
    String path,
  ) async {
    final bytes = await File(path).readAsBytes();

    final image = img.decodeImage(bytes);

    if (image == null) {
      return path;
    }

    final int cropSize = (image.width * 0.6).toInt();

    final int offsetX = ((image.width - cropSize) / 2).toInt();

    final int offsetY = ((image.height - cropSize) / 2).toInt();

    final img.Image cropped = img.copyCrop(
      image,
      x: offsetX,
      y: offsetY,
      width: cropSize,
      height: cropSize,
    );

    final img.Image resized = img.copyResize(
      cropped,
      width: 224,
      height: 224,
    );

    img.adjustColor(
      resized,
      contrast: 1.2,
      saturation: 1.1,
    );

    final String newPath = path.replaceAll(
      '.jpg',
      '_enhanced.jpg',
    );

    File(newPath).writeAsBytesSync(
      img.encodeJpg(resized),
    );

    return newPath;
  }

  // ADD IMAGE
  void addImage(String path) {
    images.add(path);
  }

  // REMOVE IMAGE
  void removeImage(int index) {
    images.removeAt(index);
  }

  // START ANALYSIS
  Future<void> startAnalysis() async {
    if (images.isEmpty) {
      return;
    }

    Get.toNamed(
      AppRoutes.loading,
    );

    // Simulasi AI Process
    await Future.delayed(
      const Duration(seconds: 3),
    );

    final result = _dummyDetect();

    Get.offNamed(
      AppRoutes.question,
      arguments: {
        'diseaseKey': result['key'],
        'confidence': result['confidence'],
        'imagePath': images.first,
      },
    );
  }

  // DUMMY AI DETECT
  Map<String, dynamic> _dummyDetect() {
    return {
      'key': 'seborrheic',
      'confidence': 0.91,
    };
  }
}
