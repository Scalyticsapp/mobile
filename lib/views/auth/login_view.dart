import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';

import '../../core/constants/app_assets.dart';
import '../../core/theme/app_theme.dart';

import '../../routes/app_routes.dart';

import '../../widgets/background_glow.dart';

class LoginView extends StatefulWidget {
  const LoginView({
    super.key,
  });

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final AuthController controller = Get.find();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  bool isPasswordVisible = false;

  @override
  void dispose() {
    emailController.dispose();

    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Stack(
        children: [
          /// BACKGROUND
          const BackgroundGlow(),

          /// CONTENT
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: Column(
                children: [
                  /// LOGO
                  const _Logo(),

                  const SizedBox(
                    height: 2,
                  ),

                  /// APP NAME
                  _buildAppName(
                    context,
                  ),

                  const SizedBox(
                    height: 30,
                  ),

                  /// LOGIN CARD
                  _buildLoginCard(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// APP NAME
  Widget _buildAppName(
    BuildContext context,
  ) {
    return Text.rich(
      TextSpan(
        text: 'Scal',
        style: Theme.of(
          context,
        ).textTheme.titleLarge!.copyWith(
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
    );
  }

  /// LOGIN CARD
  Widget _buildLoginCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(
        28,
      ),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.4),
        borderRadius: BorderRadius.circular(
          20,
        ),
        border: Border.all(
          color: AppColors.accent.withOpacity(0.2),
        ),
      ),
      child: Column(
        children: [
          /// TITLE
          const Text(
            'Login',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(
            height: 8,
          ),

          /// REGISTER LINK
          _buildRegisterLink(),

          const SizedBox(
            height: 24,
          ),

          /// EMAIL INPUT
          _buildInput(
            controller: emailController,
            hint: 'Email',
            icon: Icons.mail_outline,
          ),

          const SizedBox(
            height: 16,
          ),

          /// PASSWORD INPUT
          _buildInput(
            controller: passwordController,
            hint: 'Password',
            icon: Icons.lock_outline,
            isPassword: true,
          ),

          const SizedBox(
            height: 24,
          ),

          /// LOGIN BUTTON
          _buildLoginButton(),

          /// DIVIDER
          _buildDivider(),

          /// GOOGLE BUTTON
          _buildGoogleButton(),
        ],
      ),
    );
  }

  /// REGISTER LINK
  Widget _buildRegisterLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Belum punya akun? ',
        ),
        GestureDetector(
          onTap: () => Get.toNamed(
            AppRoutes.register,
          ),
          child: const Text(
            'Daftar',
            style: TextStyle(
              color: AppColors.accent,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  /// LOGIN BUTTON
  Widget _buildLoginButton() {
    return Obx(
      () => SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: controller.isLoading.value ? null : _handleLogin,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.accent,
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                12,
              ),
            ),
          ),
          child: controller.isLoading.value
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.black,
                  ),
                )
              : const Text(
                  'Masuk',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
    );
  }

  /// DIVIDER
  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
      ),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              color: Colors.white.withOpacity(0.2),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Text(
              'Atau',
            ),
          ),
          Expanded(
            child: Divider(
              color: Colors.white.withOpacity(0.2),
            ),
          ),
        ],
      ),
    );
  }

  /// GOOGLE BUTTON
  Widget _buildGoogleButton() {
    return Obx(
      () => SizedBox(
        width: double.infinity,
        height: 50,
        child: OutlinedButton(
          onPressed: controller.isGoogleLoading.value
              ? null
              : controller.loginWithGoogle,
          style: OutlinedButton.styleFrom(
            side: BorderSide(
              color: AppColors.accent.withOpacity(0.3),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                12,
              ),
            ),
          ),
          child: controller.isGoogleLoading.value
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppAssets.google,
                      width: 20,
                      height: 20,
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    const Text(
                      'Login dengan Google',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  /// HANDLE LOGIN
  void _handleLogin() {
    if (emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {
      _showValidationError();

      return;
    }

    controller.login(
      emailController.text.trim(),
      passwordController.text.trim(),
    );
  }

  /// VALIDATION ERROR
  void _showValidationError() {
    Get.snackbar(
      '',
      '',
      titleText: const Text(
        'Login gagal',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      messageText: const Text(
        'Email dan password wajib diisi',
        style: TextStyle(
          color: Colors.white70,
        ),
      ),
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(
        0xFF1E1E1E,
      ),
      borderRadius: 14,
      margin: const EdgeInsets.all(
        16,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 16,
      ),
      duration: const Duration(
        seconds: 2,
      ),
      icon: const Icon(
        Icons.error_outline,
        color: Colors.redAccent,
      ),
    );
  }

  /// INPUT
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
        prefixIcon: Icon(
          icon,
        ),
        suffixIcon: isPassword
            ? IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                icon: Icon(
                  isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    isPasswordVisible = !isPasswordVisible;
                  });
                },
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            12,
          ),
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo();

  @override
  Widget build(
    BuildContext context,
  ) {
    return Image.asset(
      AppAssets.logo,
      width: 100,
      filterQuality: FilterQuality.low,
    );
  }
}
