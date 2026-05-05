import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../routes/app_routes.dart';
import '../../theme/app_theme.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final AuthController c = Get.find();

  final email = TextEditingController();
  final password = TextEditingController();

  bool isPasswordVisible = false;

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Stack(
        children: [

          /// 🔥 BACKGROUND (DI-OPTIMASI TANPA NGUBAH UI)
          const _BackgroundDecor(),

          /// 🔥 CONTENT
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [

                  /// LOGO (cache biar ringan)
                  const _Logo(),

                  const SizedBox(height: 2),

                  /// APP NAME
                  Text.rich(
                    TextSpan(
                      text: 'Scal',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 30,
                          ),
                      children: const [
                        TextSpan(
                          text: 'ytics',
                          style: TextStyle(
                            color: AppColors.accent,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 30),

                  /// CARD
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppColors.accent.withOpacity(0.2),
                      ),
                    ),
                    child: Column(
                      children: [

                        const Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Belum punya akun? "),
                            GestureDetector(
                              onTap: () =>
                                  Get.toNamed(AppRoutes.register),
                              child: const Text(
                                "Daftar",
                                style: TextStyle(
                                  color: AppColors.accent,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        _buildInput(
                          controller: email,
                          hint: "Email",
                          icon: Icons.mail_outline,
                        ),

                        const SizedBox(height: 16),

                        _buildInput(
                          controller: password,
                          hint: "Password",
                          icon: Icons.lock_outline,
                          isPassword: true,
                        ),

                        const SizedBox(height: 24),

                        /// 🔥 BUTTON + LOADING (FIX LAG UX)
                        Obx(() => SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: c.isLoading.value
                                    ? null
                                    : () => c.login(
                                          email.text,
                                          password.text,
                                        ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.accent,
                                  foregroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: c.isLoading.value
                                    ? const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.black,
                                        ),
                                      )
                                    : const Text(
                                        "Masuk",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                              ),
                            )),

                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  color: Colors.white.withOpacity(0.2),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text("Atau"),
                              ),
                              Expanded(
                                child: Divider(
                                  color: Colors.white.withOpacity(0.2),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: OutlinedButton(
                            onPressed: () => c.loginWithGoogle(),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                color: AppColors.accent.withOpacity(0.3),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/google.png',
                                  width: 20,
                                  height: 20,
                                ),
                                const SizedBox(width: 6),
                                const Text(
                                  "Login dengan Google",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🔥 INPUT (TIDAK DIUBAH UI)
  Widget _buildInput({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool isPassword = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword && !isPasswordVisible,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon),
        suffixIcon: isPassword
            ? IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                icon: Icon(
                  isPasswordVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    isPasswordVisible = !isPasswordVisible;
                  });
                },
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}

/// 🔥 BACKGROUND DIPISAH + REPAINT OPTIMIZED
class _BackgroundDecor extends StatelessWidget {
  const _BackgroundDecor();

  @override
  Widget build(BuildContext context) {
    return const RepaintBoundary(
      child: Stack(
        children: [
          Positioned(
            top: -80,
            left: -110,
            child: _CircleDecor(size: 360, opacity: 0.15),
          ),
          Positioned(
            bottom: -40,
            right: -60,
            child: _CircleDecor(size: 300, opacity: 0.18),
          ),
        ],
      ),
    );
  }
}

class _CircleDecor extends StatelessWidget {
  final double size;
  final double opacity;

  const _CircleDecor({
    required this.size,
    required this.opacity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            AppColors.accent.withOpacity(opacity),
            Colors.transparent,
          ],
        ),
      ),
    );
  }
}

/// 🔥 LOGO CACHE BIAR RINGAN
class _Logo extends StatelessWidget {
  const _Logo();

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/logo.png',
      width: 100,
      filterQuality: FilterQuality.low, // penting buat performa
    );
  }
}