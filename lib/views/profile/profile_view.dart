import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../data/services/auth_service.dart';

import '../../controllers/dashboard_controller.dart';
import '../../controllers/auth_controller.dart';

import '../../core/theme/app_theme.dart';

import '../../routes/app_routes.dart';

import '../../widgets/app_bottom_nav.dart';
import '../../widgets/background_glow.dart';

class ProfileView
    extends StatefulWidget {
  const ProfileView({
    super.key,
  });

  @override
  State<ProfileView>
      createState() =>
          _ProfileViewState();
}

class _ProfileViewState
    extends State<ProfileView> {
  final DashboardController
      controller =
      Get.find<DashboardController>();

  final AuthController
    authController =
    Get.find<AuthController>();

  final user =
      Supabase.instance.client.auth.currentUser;

  final bool isGoogleUser =
      Supabase.instance.client.auth
              .currentSession
              ?.user
              .appMetadata['provider'] ==
          'google';

  late final TextEditingController
      nameController;

  late final TextEditingController
      emailController;

  final TextEditingController
      passwordController =
      TextEditingController();

  bool obscurePassword =
      true;

  static const int _tabIndex =
      3;

  @override
  void initState() {
    super.initState();

    _initializeControllers();

  }

  void _initializeControllers() {

    nameController =
      TextEditingController(
    text:
        authController.user['name']
            ?.toString() ??
        '',
  );

  emailController =
      TextEditingController(
    text:
        authController.user['email']
            ?.toString() ??
        '',
  );
}

  @override
  void dispose() {
    nameController.dispose();

    emailController.dispose();

    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    _syncTab();

    return Scaffold(
      backgroundColor:
          AppColors.bg,

      body: SafeArea(
        child: Column(
        
          children: [
            /// CONTENT
            Expanded(
              child: Stack(
                children: [
                  const BackgroundGlow(),

                  Center(
                    child:
                        SingleChildScrollView(
                      padding:
                          const EdgeInsets.all(
                        24,
                      ),

                      child: Column(
                        children: [
                          const SizedBox(
                            height: 80,
                          ),

                          _buildProfileCard(
                            context,
                          ),

                          const SizedBox(
                            height: 90,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// NAVBAR
            Padding(
              padding:
                  const EdgeInsets.only(
                left: 10,
                right: 10,
                bottom: 10,
              ),

              child: Obx(
                () => AppBottomNav(
                  currentIndex:
                      controller
                          .selectedTab
                          .value,

                  onTap: (index) {
                    controller.navigateTo(
                      _tabIndex,
                      index,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// SYNC TAB
  void _syncTab() {
    WidgetsBinding.instance
        .addPostFrameCallback(
      (_) {
        controller.selectedTab
            .value = _tabIndex;
      },
    );
  }

  /// PROFILE CARD
  Widget _buildProfileCard(
    BuildContext context,
  ) {
    return Container(
      width: double.infinity,

      constraints:
          const BoxConstraints(
        maxWidth: 420,
      ),

      padding:
          const EdgeInsets.fromLTRB(
        20,
        28,
        20,
        28,
      ),

      decoration: BoxDecoration(
        color: AppColors.s1,

        borderRadius:
            BorderRadius.circular(
          24,
        ),

        border: Border.all(
          color: AppColors.border,
        ),
      ),

      child: Column(
        children: [
          /// AVATAR
          _buildAvatar(),

          const SizedBox(
            height: 16,
          ),

          /// TITLE
          Text(
            'Profil Pengguna',

            style:
                AppText.headingMd,
          ),

          const SizedBox(
            height: 6,
          ),

          /// SUBTITLE
          Text(
            'Kelola informasi akun kamu',

            textAlign:
                TextAlign.center,

            style:
                AppText.caption.copyWith(
              fontSize: 11,
            ),
          ),

          const SizedBox(
            height: 24,
          ),

          /// NAME
          _buildInput(
            controller:
                nameController,

            label: 'Nama',

            icon:
                Icons.person_outline,
          ),

          const SizedBox(
            height: 14,
          ),

          /// EMAIL
          _buildInput(
            controller:
                emailController,

            label: 'Email',

            icon:
                Icons.mail_outline,

            enabled: false,
          ),

          if (!isGoogleUser) ...[
            const SizedBox(
              height: 14,
            ),

            /// PASSWORD
            _buildPasswordInput(),
          ],

          const SizedBox(
            height: 24,
          ),

          /// SAVE BUTTON
          _buildSaveButton(
            context,
          ),

          const SizedBox(
            height: 12,
          ),

          /// LOGOUT BUTTON
          _buildLogoutButton(),
        ],
      ),
    );
  }

  /// AVATAR
  Widget _buildAvatar() {
    return Container(
      width: 90,
      height: 90,

      margin:
          const EdgeInsets.only(
        bottom: 14,
      ),

      decoration:
          const BoxDecoration(
        shape: BoxShape.circle,

        gradient:
            LinearGradient(
          colors: [
            AppColors.accent,
            AppColors.a2,
          ],
        ),
      ),

      child: Center(
        child: Text(
          authController.user['name'] !=
        null
              ? nameController.text[0]
                  .toUpperCase()
              : 'U',

          style: const TextStyle(
            color: AppColors.bg,

            fontSize: 32,

            fontWeight:
                FontWeight.bold,
          ),
        ),
      ),
    );
  }

  /// PASSWORD INPUT
  Widget _buildPasswordInput() {
    return TextField(
      controller:
          passwordController,

      obscureText:
          obscurePassword,

      style: AppText.body,

      decoration: InputDecoration(
        hintText: 'Password',

        hintStyle:
            AppText.caption,

        prefixIcon: const Icon(
          Icons.lock_outline,
        ),

        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              obscurePassword =
                  !obscurePassword;
            });
          },

          icon: Icon(
            obscurePassword
                ? Icons
                    .visibility_off_outlined
                : Icons
                    .visibility_outlined,
          ),
        ),

        enabledBorder:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(
            12,
          ),

          borderSide: BorderSide(
            color: Colors.white
                .withOpacity(0.06),
          ),
        ),

        focusedBorder:
            const OutlineInputBorder(
          borderSide: BorderSide(
            color:
                AppColors.accent,

            width: 1.5,
          ),
        ),

        border:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(
            12,
          ),
        ),
      ),
    );
  }

  /// SAVE BUTTON
  Widget _buildSaveButton(
    BuildContext context,
  ) {
    return SizedBox(
      width: double.infinity,

      child: ElevatedButton(
        onPressed: () async {
          await _updateProfile(
            context,
          );
        },

        style:
            ElevatedButton.styleFrom(
          backgroundColor:
              AppColors.accent,

          foregroundColor:
              Colors.black,

          padding:
              const EdgeInsets.symmetric(
            vertical: 14,
          ),

          shape:
              RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(
              12,
            ),
          ),
        ),

        child: const Text(
          'Simpan Perubahan',

          style: TextStyle(
            fontWeight:
                FontWeight.w700,
          ),
        ),
      ),
    );
  }

  /// LOGOUT BUTTON
  Widget _buildLogoutButton() {
    return SizedBox(
      width: double.infinity,

      child: OutlinedButton(
        onPressed: () async {
          await AuthService().logout();

          final storage =
              FlutterSecureStorage();

          final token =
              await storage.read(
            key: 'token',
          );

          print(
            'TOKEN SETELAH LOGOUT: $token',
          );

          Get.offAllNamed(
            AppRoutes.splash,
          );
        },
        style:
            OutlinedButton.styleFrom(
          minimumSize:
              const Size.fromHeight(
            52,
          ),

          foregroundColor:
              AppColors.red,

          side: BorderSide(
            color: AppColors.red
                .withOpacity(0.5),
          ),

          padding:
              const EdgeInsets.symmetric(
            vertical: 14,
          ),

          shape:
              RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(
              12,
            ),
          ),
        ),

        child: const Text(
          'Keluar Akun',

          style: TextStyle(
            fontWeight:
                FontWeight.w700,
          ),
        ),
      ),
    );
  }

  /// UPDATE PROFILE
  Future<void> _updateProfile(
    BuildContext context,
  ) async {
    try {
      final storage =
    FlutterSecureStorage();

final token =
    await storage.read(
  key: 'token',
);

if (token == null) return;

final response =
    await AuthService()
        .updateProfile(
  token,
  nameController.text.trim(),
);

if (response.containsKey(
  'user',
)) {

  authController.user['name'] =
    nameController.text.trim();

    FocusScope.of(context)
    .unfocus();

} else {
  Get.snackbar(
    'Gagal',
    response['message'] ??
        'Update gagal',

    snackPosition:
        SnackPosition.TOP,

    backgroundColor:
        AppColors.red,

    colorText:
        Colors.white,
  );
}

      Get.snackbar(
        'Berhasil',
        'Profil berhasil diperbarui',

        snackPosition:
            SnackPosition.TOP,

        backgroundColor:
            AppColors.accent,

        colorText:
            Colors.black,
      );
    } catch (e) {
      Get.snackbar(
        'Gagal',
        'Tidak dapat memperbarui profil',

        snackPosition:
            SnackPosition.TOP,

        backgroundColor:
            AppColors.red,

        colorText:
            Colors.white,
      );
    }
  }

  /// INPUT
  Widget _buildInput({
    required TextEditingController
        controller,

    required String label,

    required IconData icon,

    bool enabled = true,
  }) {
    return TextField(
      controller: controller,

      enabled: enabled,

      style: AppText.body,

      decoration: InputDecoration(
        hintText: label,

        hintStyle:
            AppText.caption,

        prefixIcon: Icon(
          icon,
        ),

        enabledBorder:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(
            12,
          ),

          borderSide: BorderSide(
            color: Colors.white
                .withOpacity(0.06),
          ),
        ),

        focusedBorder:
            const OutlineInputBorder(
          borderSide: BorderSide(
            color:
                AppColors.accent,

            width: 1.5,
          ),
        ),

        border:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(
            12,
          ),
        ),
      ),
    );
  }
}