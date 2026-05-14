import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/app_theme.dart';
import '../../routes/app_routes.dart';
import '../../widgets/shared_widgets.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Stack(
        children: [

          const BackgroundGlow(),

          /// CONTENT
          SafeArea(
            child: Column(
              children: [

                Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Transform.translate(
                        offset: const Offset(0, -20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [

                            Image.asset(
                              'assets/images/logo.png',
                              width: 140,
                            ),

                            const SizedBox(height: 2),

                            Text.rich(
                              TextSpan(
                                text: 'Scal',
                                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 40,
                                    ),
                                children: const [
                                  TextSpan(
                                    text: 'ytics',
                                    style: TextStyle(color: AppColors.accent),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),

                            const SizedBox(height: 24),

                            Text(
                              'Kulit kepala sehat dimulai dari sini.',
                              textAlign: TextAlign.center,
                              style: AppText.heading.copyWith(
                                fontSize: 38,
                                height: 1.3,
                              ),
                            ),

                            const SizedBox(height: 14),

                            Text(
                              'Deteksi kondisi, analisis penyebab, dan perawatan yang tepat untukmu.',
                              textAlign: TextAlign.center,
                              style: AppText.body.copyWith(
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                /// BUTTON AREA
                Column(
                  children: [

                    const SizedBox(height: 20),

                    Padding(
                      padding: EdgeInsets.fromLTRB(
                        24,
                        0,
                        24,
                        16 + MediaQuery.of(context).padding.bottom,
                      ),
                      child: Column(
                        children: [

                          /// BUTTON UTAMA
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () => Get.toNamed(AppRoutes.register),
                              child: const Text('Mulai Sekarang'),
                            ),
                          ),

                          const SizedBox(height: 14),

                          /// 🔥 BUTTON MASUK (SUDAH SOLID & FIX ERROR)
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () => Get.toNamed(AppRoutes.login),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black, // 🔥 hitam pekat
                                foregroundColor: AppColors.textPrimary,
                                minimumSize: const Size(double.infinity, 52),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  side: BorderSide(
                                    color: AppColors.accent.withOpacity(0.4), // 🔥 outline
                                    width: 1.2,
                                  ),
                                ),
                                elevation: 0, // biar flat
                              ),
                              child: const Text('Masuk ke Akun'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}