import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:camera/camera.dart';

import '../../controllers/scan_controller.dart';
import '../../theme/app_theme.dart';
import '../../routes/app_routes.dart';
import '../../controllers/dashboard_controller.dart';

class ScanView extends GetView<ScanController> {
  const ScanView({super.key});

  static const _tabIndex = 1;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Get.isRegistered<DashboardController>()) {
        Get.find<DashboardController>()
            .selectedTab
            .value = _tabIndex;
      }
    });

    return Scaffold(
      backgroundColor: const Color(0xFF060606),

      appBar: AppBar(
  backgroundColor: AppColors.bg,
  elevation: 0,
  scrolledUnderElevation: 0,

  leading: IconButton(
    onPressed: () => Get.offAllNamed(
      AppRoutes.dashboard,
    ),

    icon: const Icon(
      Icons.arrow_back_ios_new_rounded,
      size: 18,
    ),
  ),

  title: Text(
    'Scan Scalp',

    style: AppText.body.copyWith(
      fontWeight: FontWeight.w600,
    ),
  ),

  centerTitle: true,

  actions: [
    Obx(
      () => IconButton(
        onPressed: controller.toggleFlash,

        icon: Icon(
          controller.isFlashOn.value
              ? Icons.flash_on_rounded
              : Icons.flash_off_rounded,

          size: 18,

          color: controller.isFlashOn.value
              ? AppColors.accent
              : AppColors.textPrimary,
        ),
      ),
    ),
  ],
),

      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: _CameraViewfinder(),
            ),

            const _BottomControls(),
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
      color: const Color(0xFF060606),

      padding: const EdgeInsets.fromLTRB(
        18,
        12,
        18,
        20,
      ),

      child: Column(
        mainAxisSize: MainAxisSize.min,

        children: [
          // WARNING FOTO
          Container(
            width: double.infinity,

            padding:
                const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 12,
            ),

            decoration: BoxDecoration(
              color: const Color(
                0xFF1A1A1A,
              ),

              borderRadius:
                  BorderRadius.circular(
                16,
              ),

              border: Border.all(
                color: AppColors.border,
              ),
            ),

            child: Row(
              children: [
                const Text(
                  '📸',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),

                const SizedBox(width: 12),

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

          const SizedBox(height: 14),

          // TIPS
          Row(
            children: [
              Expanded(
                child: _tipCard(
                  '💡',
                  'Cahaya\ncukup',
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: _tipCard(
                  '📏',
                  '5–10 cm',
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: _tipCard(
                  '🎯',
                  'Tetap\nfokus',
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          // BUTTON CAPTURE
          Obx(
            () => SizedBox(
              width: double.infinity,
              height: 54,

              child:
                  ElevatedButton.icon(
                onPressed: controller
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
                          color: Colors.black,
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
                      AppColors.accent
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

          const SizedBox(height: 10),

          // GALLERY
          SizedBox(
            width: double.infinity,
            height: 52,

            child: OutlinedButton.icon(
              onPressed:
                  controller.pickFromGallery,

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
                  color:
                      AppColors.accent.withOpacity(0.3),
                ),

                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(
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
    String emoji,
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
          Text(
            emoji,

            style: const TextStyle(
              fontSize: 18,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            text,

            textAlign:
                TextAlign.center,

            style:
                AppText.caption.copyWith(
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
    extends State<_CameraViewfinder> {
  CameraController? _controller;

  bool _ready = false;

  @override
  void initState() {
    super.initState();

    _init();
  }

  Future<void> _init() async {
    final cams =
        await availableCameras();

    final back = cams.firstWhere(
      (c) =>
          c.lensDirection ==
          CameraLensDirection.back,
    );

    _controller = CameraController(
      back,
      ResolutionPreset.high,
      enableAudio: false,
    );

    await _controller!.initialize();

    Get.find<ScanController>()
        .cameraController = _controller;

    await _controller!.setFocusMode(
      FocusMode.auto,
    );

    if (mounted) {
      setState(() => _ready = true);
    }
  }

  @override
  void dispose() {
    _controller?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,

      children: [
        _ready
            ? FittedBox(
                fit: BoxFit.cover,

                child: SizedBox(
                  width: _controller!
                      .value
                      .previewSize!
                      .height,

                  height: _controller!
                      .value
                      .previewSize!
                      .width,

                  child: CameraPreview(
                    _controller!,
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
          child: _buildFocusFrame(),
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
                const Text(
                  '',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),

                const SizedBox(width: 10),

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

        Positioned(
          bottom: 14,
          left: 16,
          right: 16,

          child: Obx(() {
            final ctrl =
                Get.find<ScanController>();

            if (ctrl.images.isEmpty) {
              return const SizedBox
                  .shrink();
            }

            return Row(
              children: [
                Text(
                  'Preview gambar',

                  style: AppText.caption
                      .copyWith(
                    fontSize: 10,
                  ),
                ),

                const Spacer(),

                Stack(
                  children: [
                    ClipRRect(
                      borderRadius:
                          BorderRadius
                              .circular(8),

                      child: Image.file(
                        File(
                          ctrl.images
                              .first,
                        ),

                        width: 52,
                        height: 52,

                        fit: BoxFit.cover,
                      ),
                    ),

                    Positioned(
                      top: 2,
                      right: 2,

                      child:
                          GestureDetector(
                        onTap: () =>
                            ctrl.removeImage(
                          0,
                        ),

                        child: Container(
                          width: 18,
                          height: 18,

                          decoration:
                              const BoxDecoration(
                            color: Color(
                              0xCC000000,
                            ),

                            shape: BoxShape
                                .circle,
                          ),

                          child: const Icon(
                            Icons.close,
                            size: 11,
                            color:
                                Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }),
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
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(
                18,
              ),

              border: Border.all(
                color: AppColors.accent
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

  Widget _corner() => SizedBox(
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

class _CornerPainter
    extends CustomPainter {
  final double thickness;

  final Color color;

  const _CornerPainter(
    this.thickness,
    this.color,
  );

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = thickness
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

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
  bool shouldRepaint(_) => false;
}