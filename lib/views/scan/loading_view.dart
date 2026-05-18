import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

import '../../widgets/background_glow.dart';

class LoadingView
    extends StatefulWidget {
  const LoadingView({
    super.key,
  });

  @override
  State<LoadingView>
      createState() =>
          _LoadingViewState();
}

class _LoadingViewState
    extends State<LoadingView>
    with SingleTickerProviderStateMixin {
  late AnimationController
      _controller;

  final List<String> steps = [
    'Gambar diterima',
    'Pre-processing selesai',
    'Deteksi AI berjalan',
    'Analisis kondisi kulit kepala',
    'Membuat rekomendasi',
  ];

  int currentStep = 0;

  @override
  void initState() {
    super.initState();

    _initializeAnimation();

    _runSteps();
  }

  /// INIT ANIMATION
  void _initializeAnimation() {
    _controller =
        AnimationController(
      vsync: this,

      duration:
          const Duration(
        seconds: 2,
      ),
    )..repeat();
  }

  /// RUN STEP ANIMATION
  Future<void> _runSteps() async {
    for (int i = 0;
        i < steps.length;
        i++) {
      await Future.delayed(
        const Duration(
          milliseconds: 600,
        ),
      );

      if (!mounted) return;

      setState(() {
        currentStep = i + 1;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor:
          const Color(
        0xFF080808,
      ),

      body: Stack(
        children: [
          /// BACKGROUND GLOW
          const BackgroundGlow(),

          SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.all(
                28,
              ),

            child: Column(
            mainAxisAlignment:
                MainAxisAlignment
                    .center,

            children: [
              /// SPINNER
              _buildSpinner(),

              const SizedBox(
                height: 24,
              ),

              /// TITLE
              _buildTitle(),

              const SizedBox(
                height: 8,
              ),

              /// DESCRIPTION
              _buildDescription(),

              const SizedBox(
                height: 40,
              ),

              /// STEP LIST
              _buildStepList(),
            ],
          ),
        ),
      ),
    ],
  ),
);
}

  /// SPINNER
  Widget _buildSpinner() {
    return SizedBox(
      width: 110,
      height: 110,

      child: Stack(
        alignment:
            Alignment.center,

        children: [
          RotationTransition(
            turns: _controller,

            child: CustomPaint(
              size: const Size(
                110,
                110,
              ),

              painter:
                  _SpinnerPainter(),
            ),
          ),

          const Icon(
            Icons.auto_awesome_rounded,

            size: 38,

            color: AppColors.accent,
          ),
        ],
      ),
    );
  }

  /// TITLE
  Widget _buildTitle() {
    return RichText(
      textAlign:
          TextAlign.center,

      text: TextSpan(
        style:
            AppText.headingMd,

        children: const [
          TextSpan(
            text:
                'Menganalisis\n',
          ),

          TextSpan(
            text:
                'kulit kepalamu',

            style: TextStyle(
              fontStyle:
                  FontStyle
                      .italic,

              color:
                  AppColors
                      .accent,
            ),
          ),

          TextSpan(
            text: '…',
          ),
        ],
      ),
    );
  }

  /// DESCRIPTION
  Widget _buildDescription() {
    return Text(
      'Model AI sedang memproses gambar.\nHarap tunggu sebentar.',

      textAlign:
          TextAlign.center,

      style:
          AppText.caption.copyWith(
        height: 1.7,
      ),
    );
  }

  /// STEP LIST
  Widget _buildStepList() {
    return Column(
      children: List.generate(
        steps.length,
        (index) {
          final bool done =
              index <
                  currentStep;

          final bool active =
              index ==
                  currentStep;

          return Padding(
            padding:
                const EdgeInsets.only(
              bottom: 14,
            ),

            child: Row(
              children: [
                _buildStepIndicator(
                  done,
                  active,
                ),

                const SizedBox(
                  width: 14,
                ),

                Text(
                  steps[index],

                  style: AppText
                      .body
                      .copyWith(
                    fontSize: 13,

                    color:
                        done
                            ? AppColors
                                .muted
                            : active
                                ? AppColors
                                    .accent
                                : AppColors
                                    .muted2,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// STEP INDICATOR
  Widget _buildStepIndicator(
    bool done,
    bool active,
  ) {
    return AnimatedContainer(
      duration:
          const Duration(
        milliseconds: 300,
      ),

      width: 24,
      height: 24,

      decoration: BoxDecoration(
        shape: BoxShape.circle,

        color: done
            ? AppColors.accent
            : active
                ? AppColors
                    .accent
                    .withOpacity(
                      0.12,
                    )
                : AppColors.s3,

        border: active
            ? Border.all(
                color: AppColors
                    .accent
                    .withOpacity(
                      0.4,
                    ),
              )
            : null,
      ),

      child: Center(
        child:
            done
                ? const Icon(
                    Icons
                        .check_rounded,

                    size: 13,

                    color:
                        AppColors
                            .bg,
                  )
                : active
                    ? const _PulsingDot()
                    : Container(
                        width: 6,
                        height: 6,

                        decoration:
                            const BoxDecoration(
                          color: AppColors
                              .muted2,

                          shape: BoxShape
                              .circle,
                        ),
                      ),
      ),
    );
  }
}

/// SPINNER PAINTER
class _SpinnerPainter
    extends CustomPainter {
  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    final Paint bg =
        Paint()
          ..color = AppColors
              .accent
              .withOpacity(0.08)
          ..style =
              PaintingStyle
                  .stroke
          ..strokeWidth = 5;

    final Paint fg =
        Paint()
          ..color =
              AppColors.accent
          ..style =
              PaintingStyle
                  .stroke
          ..strokeWidth = 5
          ..strokeCap =
              StrokeCap.round;

    final Offset center =
        Offset(
      size.width / 2,
      size.height / 2,
    );

    final double radius =
        (size.width - 5) / 2;

    canvas.drawCircle(
      center,
      radius,
      bg,
    );

    canvas.drawArc(
      Rect.fromCircle(
        center: center,
        radius: radius,
      ),

      -1.57,
      1.2,
      false,
      fg,
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

class _PulsingDot
    extends StatefulWidget {
  const _PulsingDot();

  @override
  State<_PulsingDot>
      createState() =>
          _PulsingDotState();
}

class _PulsingDotState
    extends State<_PulsingDot>
    with SingleTickerProviderStateMixin {
  late AnimationController
      _controller;

  late Animation<double>
      _animation;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(
      vsync: this,

      duration:
          const Duration(
        milliseconds: 800,
      ),
    )..repeat(
            reverse: true,
          );

    _animation = Tween<double>(
      begin: 0.4,
      end: 1.0,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return FadeTransition(
      opacity: _animation,

      child: Container(
        width: 6,
        height: 6,

        decoration:
            const BoxDecoration(
          color:
              AppColors.accent,

          shape:
              BoxShape.circle,
        ),
      ),
    );
  }
}