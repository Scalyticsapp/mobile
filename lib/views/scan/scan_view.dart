import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/dashboard_controller.dart';
import '../../controllers/scan_controller.dart';

import '../../core/theme/app_theme.dart';

import '../../routes/app_routes.dart';

import '../../widgets/app_header.dart';

class ScanView
    extends StatefulWidget {
  const ScanView({
    super.key,
  });

  @override
  State<ScanView> createState() =>
      _ScanViewState();
}

class _ScanViewState
    extends State<ScanView> {
  static const int _tabIndex = 1;

  late final ScanController
      controller;

  @override
  void initState() {
    super.initState();

    controller =
        Get.find<ScanController>();

    WidgetsBinding.instance
        .addPostFrameCallback(
      (_) {
        if (Get.isRegistered<
            DashboardController>()) {
          Get.find<
                  DashboardController>()
              .selectedTab
              .value = _tabIndex;
        }
      },
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor:
          const Color(0xFF060606),

      appBar: AppHeader(
        title: 'Scan Kulit Kepala',

        actions: [
          Obx(
            () => IconButton(
              onPressed:
                  controller.toggleFlash,

              icon: Icon(
                controller
                        .isFlashOn
                        .value
                    ? Icons
                        .flash_on_rounded
                    : Icons
                        .flash_off_rounded,

                size: 18,

                color: controller
                        .isFlashOn
                        .value
                    ? AppColors.accent
                    : AppColors
                        .textPrimary,
              ),
            ),
          ),
        ],
      ),

      body: const SafeArea(
        child: Column(
          children: [
            Expanded(
              child:
                  _CameraViewfinder(),
            ),

            _BottomControls(),
          ],
        ),
      ),
    );
  }
}

class _BottomControls
    extends GetView<ScanController> {
  const _BottomControls();

  @override
  Widget build(BuildContext context) {
    return Container(
      color:
          const Color(0xFF060606),

      padding:
          const EdgeInsets.fromLTRB(
        18,
        12,
        18,
        20,
      ),

      child: Column(
        mainAxisSize:
            MainAxisSize.min,

        children: [
          /// WARNING CARD
          Container(
            width: double.infinity,

            padding:
                const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 12,
            ),

            decoration: BoxDecoration(
              color:
                  const Color(0xFF1A1A1A),

              borderRadius:
                  BorderRadius.circular(
                16,
              ),

              border: Border.all(
                color:
                    AppColors.border,
              ),
            ),

            child: Row(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(
                    bottom: 1,
                  ),

                  child: Icon(
                    Icons.camera_alt_rounded,

                    size: 19,

                    color: AppColors.accent,
                  ),
                ),

                const SizedBox(
                  width: 12,
                ),

                Expanded(
                  child: Text(
                    'Ambil 1 foto pada area kulit kepala yang paling terdampak untuk hasil analisis terbaik.',

                    style:
                        AppText.caption
                            .copyWith(
                      fontSize: 11,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(
            height: 14,
          ),

          /// TIPS
          Row(
            children: [
              Expanded(
                child: _tipCard(
                  Icons.wb_sunny_rounded,
                  'Cahaya\ncukup',
                ),
              ),

              const SizedBox(
                width: 10,
              ),

              Expanded(
                child: _tipCard(
                  Icons.straighten_rounded,
                  '5–10 cm',
                ),
              ),

              const SizedBox(
                width: 10,
              ),

              Expanded(
                child: _tipCard(
                  Icons.center_focus_strong_rounded,
                  'Tetap\nfokus',
                ),
              ),
            ],
          ),

          const SizedBox(
            height: 18,
          ),

          /// CAPTURE BUTTON
          Obx(
            () => SizedBox(
              width: double.infinity,
              height: 54,

              child:
                  ElevatedButton.icon(
                onPressed:
                    controller
                            .isCapturing
                            .value
                        ? null
                        : controller
                            .captureFromViewfinder,

                icon: controller
                        .isCapturing
                        .value
                    ? const SizedBox(
                        width: 18,
                        height: 18,

                        child:
                            CircularProgressIndicator(
                          strokeWidth: 2,

                          color:
                              Colors.black,
                        ),
                      )
                    : const Icon(
                        Icons
                            .camera_alt_rounded,

                        size: 20,
                      ),

                label: Text(
                  controller
                          .isCapturing
                          .value
                      ? 'Mengambil...'
                      : 'Ambil Gambar',
                ),

                style:
                    ElevatedButton.styleFrom(
                  backgroundColor:
                      AppColors.accent,

                  foregroundColor:
                      Colors.black,

                  disabledBackgroundColor:
                      AppColors
                          .accent
                          .withOpacity(
                    0.5,
                  ),

                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius
                            .circular(
                      16,
                    ),
                  ),

                  textStyle:
                      const TextStyle(
                    fontWeight:
                        FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(
            height: 10,
          ),

          /// GALLERY BUTTON
          SizedBox(
            width: double.infinity,
            height: 52,

            child:
                OutlinedButton.icon(
              onPressed: controller
                  .pickFromGallery,

              icon: const Icon(
                Icons
                    .photo_library_rounded,

                size: 20,
              ),

              label: const Text(
                'Pilih dari Galeri',
              ),

              style:
                  OutlinedButton.styleFrom(
                foregroundColor:
                    AppColors.accent,

                side: BorderSide(
                  color: AppColors
                      .accent
                      .withOpacity(
                    0.3,
                  ),
                ),

                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius
                          .circular(
                    16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tipCard(
    IconData icon,
    String text,
  ) {
    return Container(
      height: 74,

      decoration: BoxDecoration(
        color: AppColors.s2,

        borderRadius:
            BorderRadius.circular(
          14,
        ),

        border: Border.all(
          color: AppColors.border,
        ),
      ),

      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center,

        children: [
          Icon(
            icon,

            size: 20,

            color: AppColors.accent,
          ),

          const SizedBox(
            height: 6,
          ),

          Text(
            text,

            textAlign:
                TextAlign.center,

            style:
                AppText.caption
                    .copyWith(
              fontSize: 10,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

class _CameraViewfinder
    extends StatefulWidget {
  const _CameraViewfinder();

  @override
  State<_CameraViewfinder>
      createState() =>
          _CameraViewfinderState();
}

class _CameraViewfinderState
    extends State<
        _CameraViewfinder> {
  CameraController?
      _cameraController;

  late final ScanController
      controller;

  bool _isReady = false;

  @override
  void initState() {
    super.initState();

    controller =
        Get.find<ScanController>();

    _initializeCamera();
  }

  Future<void>
      _initializeCamera() async {
    final cameras =
        await availableCameras();

    final backCamera =
        cameras.firstWhere(
      (camera) =>
          camera.lensDirection ==
          CameraLensDirection.back,
    );

    _cameraController =
        CameraController(
      backCamera,
      ResolutionPreset.high,
      enableAudio: false,
    );

    await _cameraController!
        .initialize();

    controller.cameraController =
        _cameraController;

    await _cameraController!
        .setFocusMode(
      FocusMode.auto,
    );

    if (mounted) {
      setState(() {
        _isReady = true;
      });
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,

      children: [
        _isReady
            ? FittedBox(
                fit: BoxFit.cover,

                child: SizedBox(
                  width:
                      _cameraController!
                          .value
                          .previewSize!
                          .height,

                  height:
                      _cameraController!
                          .value
                          .previewSize!
                          .width,

                  child: CameraPreview(
                    _cameraController!,
                  ),
                ),
              )
            : const Center(
                child:
                    CircularProgressIndicator(
                  color:
                      AppColors.accent,
                ),
              ),

        Center(
          child:
              _buildFocusFrame(),
        ),

        Positioned(
          top: 18,
          left: 18,
          right: 18,

          child: Container(
            padding:
                const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 10,
            ),

            decoration: BoxDecoration(
              color: Colors.black
                  .withOpacity(0.55),

              borderRadius:
                  BorderRadius.circular(
                14,
              ),

              border: Border.all(
                color: Colors.white
                    .withOpacity(0.08),
              ),
            ),

            child: Row(
              children: [
                const SizedBox(
                  width: 10,
                ),

                Expanded(
                  child: Text(
                    'Gunakan kamera makro jika tersedia agar detail kulit kepala terlihat lebih jelas',

                    style:
                        AppText.caption
                            .copyWith(
                      fontSize: 11,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFocusFrame() {
    return SizedBox(
      width: 180,
      height: 180,

      child: Stack(
        children: [
          Container(
            decoration:
                BoxDecoration(
              borderRadius:
                  BorderRadius
                      .circular(18),

              border: Border.all(
                color: AppColors
                    .accent
                    .withOpacity(0.7),

                width: 2,
              ),
            ),
          ),

          Positioned(
            top: 0,
            left: 0,
            child: _corner(),
          ),

          Positioned(
            top: 0,
            right: 0,

            child: Transform.scale(
              scaleX: -1,

              child: _corner(),
            ),
          ),

          Positioned(
            bottom: 0,
            left: 0,

            child: Transform.scale(
              scaleY: -1,

              child: _corner(),
            ),
          ),

          Positioned(
            bottom: 0,
            right: 0,

            child: Transform.scale(
              scaleX: -1,
              scaleY: -1,

              child: _corner(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _corner() {
    return SizedBox(
      width: 24,
      height: 24,

      child: CustomPaint(
        painter: _CornerPainter(
          3,
          AppColors.accent,
        ),
      ),
    );
  }
}

class _CornerPainter
    extends CustomPainter {
  final double thickness;

  final Color color;

  const _CornerPainter(
    this.thickness,
    this.color,
  );

  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    final Paint paint =
        Paint()
          ..color = color
          ..strokeWidth =
              thickness
          ..style =
              PaintingStyle.stroke
          ..strokeCap =
              StrokeCap.round;

    canvas.drawLine(
      Offset.zero,
      Offset(size.width, 0),
      paint,
    );

    canvas.drawLine(
      Offset.zero,
      Offset(0, size.height),
      paint,
    );
  }

  @override
  bool shouldRepaint(
    covariant CustomPainter
        oldDelegate,
  ) {
    return false;
  }
}