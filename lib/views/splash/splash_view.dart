import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/app_assets.dart';

import '../../core/theme/app_theme.dart';

import '../../routes/app_routes.dart';

import '../../widgets/background_glow.dart';

class SplashView
    extends StatelessWidget {
  const SplashView({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    final bottomPadding =
        MediaQuery.of(context)
            .padding
            .bottom;

    return Scaffold(
      backgroundColor:
          AppColors.bg,

      body: Stack(
        children: [
          /// BACKGROUND
          const BackgroundGlow(),

          SafeArea(
            child: Column(
              children: [
                /// CONTENT
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
                            /// LOGO
                            _buildLogo(),

                            const SizedBox(
                              height: 2,
                            ),

                            /// APP NAME
                            _buildAppName(
                              context,
                            ),

                            const SizedBox(
                              height: 24,
                            ),

                            /// HEADLINE
                            _buildHeadline(),

                            const SizedBox(
                              height: 14,
                            ),

                            /// DESCRIPTION
                            _buildDescription(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                /// ACTION BUTTON
                Padding(
                  padding:
                      EdgeInsets.fromLTRB(
                    24,
                    0,
                    24,
                    16 +
                        bottomPadding,
                  ),

                  child: Column(
                    children: [
                      /// REGISTER BUTTON
                      _buildRegisterButton(),

                      const SizedBox(
                        height: 14,
                      ),

                      /// LOGIN BUTTON
                      _buildLoginButton(),
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

  /// LOGO
  Widget _buildLogo() {
    return Image.asset(
      AppAssets.logo,

      width: 140,
    );
  }

  /// APP NAME
  Widget _buildAppName(
    BuildContext context,
  ) {
    return Text.rich(
      TextSpan(
        text: 'Scal',

        style:
            Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(
                  fontWeight:
                      FontWeight.w700,

                  fontSize: 40,
                ),

        children: const [
          TextSpan(
            text: 'ytics',

            style: TextStyle(
              color:
                  AppColors.accent,
            ),
          ),
        ],
      ),

      textAlign:
          TextAlign.center,
    );
  }

  /// HEADLINE
  Widget _buildHeadline() {
    return Text(
      'Kulit kepala sehat dimulai dari sini.',

      textAlign:
          TextAlign.center,

      style:
          AppText.heading.copyWith(
        fontSize: 38,
        height: 1.3,
      ),
    );
  }

  /// DESCRIPTION
  Widget _buildDescription() {
    return Text(
      'Deteksi kondisi, analisis penyebab, dan perawatan yang tepat untukmu.',

      textAlign:
          TextAlign.center,

      style:
          AppText.body.copyWith(
        fontSize: 15,
      ),
    );
  }

  /// REGISTER BUTTON
  Widget _buildRegisterButton() {
    return SizedBox(
      width: double.infinity,

      child: ElevatedButton(
        onPressed: () {
          Get.toNamed(
            AppRoutes.register,
          );
        },

        child: const Text(
          'Mulai Sekarang',
        ),
      ),
    );
  }

  /// LOGIN BUTTON
  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,

      child: ElevatedButton(
        onPressed: () {
          Get.toNamed(
            AppRoutes.login,
          );
        },

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

            side: BorderSide(
              color: AppColors
                  .accent
                  .withOpacity(
                0.4,
              ),

              width: 1.2,
            ),
          ),
        ),

        child: const Text(
          'Masuk ke Akun',
        ),
      ),
    );
  }
}