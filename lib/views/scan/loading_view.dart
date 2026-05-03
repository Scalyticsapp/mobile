import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/result_controller.dart';
import '../../theme/app_theme.dart';

class LoadingView extends StatefulWidget {
  const LoadingView({super.key});

  @override
  State<LoadingView> createState() => _LoadingViewState();
}

class _LoadingViewState extends State<LoadingView>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;

  ResultController get controller => Get.find();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF080808),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 110, height: 110,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    RotationTransition(
                      turns: _controller,
                      child: CustomPaint(
                        size: const Size(110, 110),
                        painter: _SpinnerPainter(),
                      ),
                    ),
                    const Text('🧬', style: TextStyle(fontSize: 36)),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: AppText.headingMd,
                  children: const [
                    TextSpan(text: 'Menganalisis\n'),
                    TextSpan(
                      text: 'scalp kamu',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: AppColors.accent,
                      ),
                    ),
                    TextSpan(text: '…'),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Model AI sedang memproses gambar.\nHarap tunggu sebentar.',
                textAlign: TextAlign.center,
                style: AppText.caption.copyWith(height: 1.7),
              ),

              const SizedBox(height: 40),

              Obx(() => Column(
                children: List.generate(controller.steps.length, (i) {
                  final done = i < controller.currentStep.value;
                  final active = i == controller.currentStep.value;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: Row(children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: 24, height: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: done
                              ? AppColors.accent
                              : active
                                  ? AppColors.accent.withOpacity(0.12)
                                  : AppColors.s3,
                          border: active
                              ? Border.all(color: AppColors.accent.withOpacity(0.4))
                              : null,
                        ),
                        child: Center(
                          child: done
                              ? const Icon(Icons.check_rounded, size: 13, color: AppColors.bg)
                              : active
                                  ? _PulsingDot()
                                  : Container(
                                      width: 6, height: 6,
                                      decoration: const BoxDecoration(
                                        color: AppColors.muted2,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Text(
                        controller.steps[i],
                        style: AppText.body.copyWith(
                          fontSize: 13,
                          color: done
                              ? AppColors.muted
                              : active
                                  ? AppColors.accent
                                  : AppColors.muted2,
                        ),
                      ),
                    ]),
                  );
                }),
              )),
            ],
          ),
        ),
      ),
    );
  }
}

class _SpinnerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final bg = Paint()
      ..color = AppColors.accent.withOpacity(0.08)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    final fg = Paint()
      ..color = AppColors.accent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;

    final c = Offset(size.width / 2, size.height / 2);
    final r = (size.width - 5) / 2;

    canvas.drawCircle(c, r, bg);
    canvas.drawArc(Rect.fromCircle(center: c, radius: r), -1.57, 1.2, false, fg);
  }

  @override
  bool shouldRepaint(_) => false;
}

class _PulsingDot extends StatefulWidget {
  @override
  State<_PulsingDot> createState() => _PulsingDotState();
}

class _PulsingDotState extends State<_PulsingDot>
    with SingleTickerProviderStateMixin {

  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    _anim = Tween(begin: 0.4, end: 1.0).animate(_ctrl);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _anim,
      child: Container(
        width: 6, height: 6,
        decoration: const BoxDecoration(
          color: AppColors.accent,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}