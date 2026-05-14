import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../routes/app_routes.dart';
import '../../core/theme/app_theme.dart';
import '../../core/constants/app_assets.dart';
import '../../widgets/background_glow.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

  final AuthController c = Get.find<AuthController>();

  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();

  bool isPasswordVisible = false;

  @override
  void dispose() {
    name.dispose();
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

          /// 🔥 BACKGROUND 
          const BackgroundGlow(),

          /// 🔥 CONTENT
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [

                  /// LOGO (optimized)
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
                          "Daftar Akun",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Sudah punya akun? "),
                            GestureDetector(
                              onTap: () => Get.toNamed(AppRoutes.login),
                              child: const Text(
                                "Masuk",
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
                          controller: name,
                          hint: "Nama",
                          icon: Icons.person_outline,
                        ),

                        const SizedBox(height: 16),

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

                        /// 🔥 BUTTON + LOADING
                        Obx(() => SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: c.isLoading.value
                                  ? null
                                  : () {

                                      if (name.text.trim().isEmpty ||
                                          email.text.trim().isEmpty ||
                                          password.text.trim().isEmpty) {

                                        Get.snackbar(
                                          "",
                                          "",
                                          titleText: const Text(
                                            "Register gagal",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                          messageText: const Text(
                                            "Nama, email, dan password wajib diisi",
                                            style: TextStyle(
                                              color: Colors.white70,
                                            ),
                                          ),
                                          snackPosition: SnackPosition.TOP,
                                          backgroundColor: Color(0xFF1E1E1E),
                                          borderRadius: 14,
                                          margin: EdgeInsets.all(16),
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 20,
                                            vertical: 16,
                                          ),
                                          duration: Duration(seconds: 2),
                                          icon: Icon(
                                            Icons.error_outline,
                                            color: Colors.redAccent,
                                          ),
                                        );

                                        return;
                                      }

                                      c.register(
                                        name.text.trim(),
                                        email.text.trim(),
                                        password.text.trim(),
                                      );
                                    },
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
                                        "Daftar",
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

                        Obx(() => SizedBox(
                          width: double.infinity,
                          height: 50,

                          child: OutlinedButton(
                            onPressed:
                                c.isGoogleLoading.value
                                    ? null
                                    : () => c.loginWithGoogle(),

                            style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                color: AppColors.accent
                                    .withOpacity(0.3),
                              ),

                              shape:
                                  RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(
                                  12,
                                ),
                              ),
                            ),

                            child:
                                c.isGoogleLoading.value
                                    ? const SizedBox(
                                        height: 20,
                                        width: 20,

                                        child:
                                            CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,

                                        children: [
                                          Image.asset(
                                            AppAssets.google,

                                            width: 20,
                                            height: 20,
                                          ),

                                          const SizedBox(
                                              width: 6),

                                          const Text(
                                            "Daftar dengan Google",

                                            style: TextStyle(
                                              fontWeight:
                                                  FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                          ),
                        ))
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

/// 🔥 LOGO OPTIMIZED
class _Logo extends StatelessWidget {
  const _Logo();

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/logo.png',
      width: 100,
      filterQuality: FilterQuality.low,
    );
  }
}