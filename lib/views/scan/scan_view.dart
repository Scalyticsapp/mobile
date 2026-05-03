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
        Get.find<DashboardController>().selectedTab.value = _tabIndex;
      }
    });

    return Scaffold(
      backgroundColor: const Color(0xFF060606),
      appBar: AppBar(
        backgroundColor: const Color(0xFF060606),
        elevation: 0,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () => Get.offAllNamed(AppRoutes.dashboard),
          child: const Icon(Icons.arrow_back_ios_new_rounded,
              size: 18, color: AppColors.textPrimary),
        ),
        title: Text(
          'Scan Scalp',
          style: AppText.body.copyWith(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        actions: [
          Obx(() => GestureDetector(
                onTap: controller.toggleFlash,
                child: Padding(
                  padding: const EdgeInsets.only(right: 18),
                  child: Icon(
                    controller.isFlashOn.value
                        ? Icons.flash_on_rounded
                        : Icons.flash_off_rounded,
                    size: 18,
                    color: controller.isFlashOn.value
                        ? AppColors.accent
                        : AppColors.textPrimary,
                  ),
                ),
              )),
        ],
      ),

      // ── BODY: 2 area fixed, tidak ada scroll ──────────────────
      body: SafeArea(
        child: Column(
          children: [
            // ── AREA ATAS: Kamera mengisi sisa layar ─────────────
            Expanded(
              child: _CameraViewfinder(),
            ),

            // ── AREA BAWAH: Kontrol fixed ─────────────────────────
            _BottomControls(),
          ],
        ),
      ),
    );
  }
}

// ----------------------------------------------------------------
// BOTTOM CONTROLS — fixed height, tidak scroll
// ----------------------------------------------------------------
class _BottomControls extends GetView<ScanController> {
  const _BottomControls();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF060606),
      padding: const EdgeInsets.fromLTRB(18, 12, 18, 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── ZONE SELECTOR ──────────────────────────────────────
          SizedBox(
            height: 36,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: controller.zones.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (_, index) {
                final zone = controller.zones[index];
                return Obx(() {
                  final isSelected = controller.selectedZone.value == zone;
                  return GestureDetector(
                    onTap: () => controller.selectZone(zone),
                    child: Container(
                      width: 90,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.accent.withOpacity(0.15)
                            : AppColors.s2,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.accent
                              : AppColors.border,
                        ),
                      ),
                      child: Text(
                        zone,
                        style: TextStyle(
                          fontSize: 12,
                          color: isSelected
                              ? AppColors.accent
                              : AppColors.textPrimary,
                        ),
                      ),
                    ),
                  );
                });
              },
            ),
          ),

          const SizedBox(height: 10),

          // ── TOMBOL CAPTURE ────────────────────────────────────
          Obx(() => SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: controller.isCapturing.value
                      ? null
                      : controller.captureFromViewfinder,
                  icon: controller.isCapturing.value
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.black,
                          ),
                        )
                      : const Icon(Icons.camera_alt_rounded, size: 20),
                  label: Text(
                    controller.isCapturing.value
                        ? 'Mengambil...'
                        : 'Ambil Gambar',
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accent,
                    foregroundColor: Colors.black,
                    disabledBackgroundColor:
                        AppColors.accent.withOpacity(0.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    textStyle:
                        const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              )),

          const SizedBox(height: 8),

          // ── TOMBOL GALERI atau MULAI ANALISIS ─────────────────
          Obx(() {
            final isDone = controller.images.length >= 4;
            return SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: isDone
                    ? controller.startAnalysis
                    : controller.pickFromGallery,
                icon: Icon(
                  isDone
                      ? Icons.analytics_rounded
                      : Icons.photo_library_rounded,
                  size: 20,
                ),
                label: Text(isDone
                    ? 'Mulai Analisis'
                    : 'Pilih dari Galeri'),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isDone ? AppColors.accent : AppColors.s2,
                  foregroundColor:
                      isDone ? Colors.black : AppColors.textPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: isDone
                        ? BorderSide.none
                        : BorderSide(color: AppColors.border),
                  ),
                  textStyle: TextStyle(
                    fontWeight:
                        isDone ? FontWeight.w700 : FontWeight.w500,
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

// ----------------------------------------------------------------
// CAMERA VIEWFINDER — mengisi sisa layar, overlay thumbnail & tips
// ----------------------------------------------------------------
class _CameraViewfinder extends StatefulWidget {
  const _CameraViewfinder();

  @override
  State<_CameraViewfinder> createState() => _CameraViewfinderState();
}

class _CameraViewfinderState extends State<_CameraViewfinder> {
  CameraController? _controller;
  bool _ready = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final cams = await availableCameras();
    final back = cams.firstWhere(
      (c) => c.lensDirection == CameraLensDirection.back,
    );

    _controller = CameraController(
      back,
      ResolutionPreset.high,
      enableAudio: false,
    );

    await _controller!.initialize();
    Get.find<ScanController>().cameraController = _controller;
    await _controller!.setFocusMode(FocusMode.auto);

    if (mounted) setState(() => _ready = true);
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
        // ── PREVIEW KAMERA ──────────────────────────────────────
        _ready
            ? FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _controller!.value.previewSize!.height,
                  height: _controller!.value.previewSize!.width,
                  child: CameraPreview(_controller!),
                ),
              )
            : const Center(
                child: CircularProgressIndicator(
                  color: AppColors.accent,
                ),
              ),

        // ── FOCUS FRAME (tengah) ────────────────────────────────
        Center(child: _buildFocusFrame()),

        // ── OVERLAY ATAS: tip + counter ─────────────────────────
        Positioned(
          top: 12,
          left: 16,
          right: 16,
          child: Row(
            children: [
              // Tip makro
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.55),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Text('🔍',
                          style: TextStyle(fontSize: 12)),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          'Gunakan mode makro untuk hasil tajam',
                          style: AppText.caption
                              .copyWith(fontSize: 10),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Counter foto
              Obx(() => Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.55),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '📸 ${Get.find<ScanController>().images.length}/4',
                      style: AppText.caption.copyWith(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Get.find<ScanController>()
                                    .images
                                    .length >=
                                4
                            ? AppColors.accent
                            : AppColors.textPrimary,
                      ),
                    ),
                  )),
            ],
          ),
        ),

        // ── OVERLAY BAWAH: thumbnail 4 foto ─────────────────────
        Positioned(
          bottom: 12,
          left: 16,
          right: 16,
          child: Obx(() {
            final ctrl = Get.find<ScanController>();
            if (ctrl.images.isEmpty) return const SizedBox.shrink();
            return Row(
              children: [
                Text(
                  'Arahkan ke area berbeda',
                  style: AppText.caption.copyWith(fontSize: 10),
                ),
                const Spacer(),
                // Thumbnail list (max 4)
                Row(
                  children: List.generate(
                    ctrl.images.length,
                    (i) => Padding(
                      padding: const EdgeInsets.only(left: 6),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              File(ctrl.images[i]),
                              width: 44,
                              height: 44,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 2,
                            right: 2,
                            child: GestureDetector(
                              onTap: () => ctrl.removeImage(i),
                              child: Container(
                                width: 16,
                                height: 16,
                                decoration: const BoxDecoration(
                                  color: Color(0xCC000000),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.close,
                                    size: 10, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
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
      width: 160,
      height: 160,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.accent.withOpacity(0.5),
                width: 1,
              ),
            ),
          ),
          Positioned(top: 0, left: 0, child: _corner()),
          Positioned(
              top: 0,
              right: 0,
              child: Transform.scale(scaleX: -1, child: _corner())),
          Positioned(
              bottom: 0,
              left: 0,
              child: Transform.scale(scaleY: -1, child: _corner())),
          Positioned(
              bottom: 0,
              right: 0,
              child: Transform.scale(
                  scaleX: -1, scaleY: -1, child: _corner())),
        ],
      ),
    );
  }

  Widget _corner() => SizedBox(
        width: 20,
        height: 20,
        child: CustomPaint(
          painter: _CornerPainter(2.5, AppColors.accent),
        ),
      );
}

class _CornerPainter extends CustomPainter {
  final double thickness;
  final Color color;
  const _CornerPainter(this.thickness, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = thickness
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(Offset.zero, Offset(size.width, 0), paint);
    canvas.drawLine(Offset.zero, Offset(0, size.height), paint);
  }

  @override
  bool shouldRepaint(_) => false;
}