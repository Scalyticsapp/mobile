import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/app_assets.dart';
import '../../core/theme/app_theme.dart';
import '../../routes/app_routes.dart';
import '../../widgets/background_glow.dart';

class SplashView extends StatelessWidget {
  const SplashView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bottomPadding =
        MediaQuery.of(context)
            .padding
            .bottom;

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Stack(
        children: [
          const BackgroundGlow(),

          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child:
                          Transform.translate(
                        offset:
                            const Offset(
                          0,
                          -20,
                        ),
                        child: Column(
                          mainAxisSize:
                              MainAxisSize.min,
                          children: [
                            Image.asset(
                              AppAssets.logo,
                              width: 140,
                            ),

                            const SizedBox(
                              height: 2,
                            ),

                            Text.rich(
                              TextSpan(
                                text: 'Scal',
                                style:
                                    Theme.of(
                                  context,
                                )
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                          fontWeight:
                                              FontWeight
                                                  .w700,
                                          fontSize:
                                              40,
                                        ),
                                children: const [
                                  TextSpan(
                                    text:
                                        'ytics',
                                    style:
                                        TextStyle(
                                      color:
                                          AppColors
                                              .accent,
                                    ),
                                  ),
                                ],
                              ),
                              textAlign:
                                  TextAlign
                                      .center,
                            ),

                            const SizedBox(
                              height: 24,
                            ),

                            Text(
                              'Kulit kepala sehat dimulai dari sini.',
                              textAlign:
                                  TextAlign
                                      .center,
                              style:
                                  AppText
                                      .heading
                                      .copyWith(
                                fontSize: 38,
                                height: 1.3,
                              ),
                            ),

                            const SizedBox(
                              height: 14,
                            ),

                            Text(
                              'Deteksi kondisi, analisis penyebab, dan perawatan yang tepat untukmu.',
                              textAlign:
                                  TextAlign
                                      .center,
                              style:
                                  AppText
                                      .body
                                      .copyWith(
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding:
                      EdgeInsets.fromLTRB(
                    24,
                    0,
                    24,
                    16 + bottomPadding,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        width:
                            double.infinity,
                        child:
                            ElevatedButton(
                          onPressed:
                              () =>
                                  Get.toNamed(
                            AppRoutes
                                .register,
                          ),
                          child: const Text(
                            'Mulai Sekarang',
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 14,
                      ),

                      SizedBox(
                        width:
                            double.infinity,
                        child:
                            ElevatedButton(
                          onPressed:
                              () =>
                                  Get.toNamed(
                            AppRoutes
                                .login,
                          ),

                          style:
                              ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors.black,

                            foregroundColor:
                                AppColors
                                    .textPrimary,

                            minimumSize:
                                const Size(
                              double.infinity,
                              52,
                            ),

                            elevation: 0,

                            shape:
                                RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(
                                14,
                              ),

                              side:
                                  BorderSide(
                                color:
                                    AppColors
                                        .accent
                                        .withOpacity(
                                  0.4,
                                ),
                                width:
                                    1.2,
                              ),
                            ),
                          ),

                          child: const Text(
                            'Masuk ke Akun',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}