import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/app_theme.dart';
import '../../routes/app_routes.dart';
import '../../widgets/shared_widgets.dart';
import '../../controllers/dashboard_controller.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {

  final controller = Get.find<DashboardController>();

  final name = TextEditingController(text: 'Zahwa Salsabila');
  final email = TextEditingController(text: 'zahwa@email.com');

  static const _tabIndex = 3;

  @override
  Widget build(BuildContext context) {

    /// 🔥 SYNC TAB (INI DOANG FIX NYA)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.selectedTab.value = _tabIndex;
    });

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Column(
          children: [

            // CONTENT
            Expanded(
              child: Stack(
                children: [

                  // BLUR ATAS KIRI
                  Positioned(
                    top: -80,
                    left: -110,
                    child: Container(
                      width: 360,
                      height: 360,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            AppColors.accent.withOpacity(0.15),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),

                  // BLUR BAWAH KANAN
                  Positioned(
                    bottom: -100,
                    right: -60,
                    child: Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            AppColors.accent.withOpacity(0.18),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),

                  /// CONTENT
                  Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [

                          const SizedBox(height: 40),

                          Container(
                            width: double.infinity,
                            constraints: const BoxConstraints(maxWidth: 420),
                            padding: const EdgeInsets.fromLTRB(20, 28, 20, 28),
                            decoration: BoxDecoration(
                              color: AppColors.s1,
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(color: AppColors.border),
                            ),
                            child: Column(
                              children: [

                                /// AVATAR (BALIKIN STYLE)
                                Container(
                                  width: 90,
                                  height: 90,
                                  margin: const EdgeInsets.only(bottom: 14),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                      colors: [AppColors.accent, AppColors.a2],
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      name.text.isNotEmpty
                                          ? name.text[0].toUpperCase()
                                          : 'U',
                                      style: const TextStyle(
                                        color: AppColors.bg,
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 16),

                                _buildInput(
                                  controller: name,
                                  label: "Nama",
                                  icon: Icons.person_outline,
                                ),

                                const SizedBox(height: 14),

                                _buildInput(
                                  controller: email,
                                  label: "Email",
                                  icon: Icons.mail_outline,
                                ),

                                const SizedBox(height: 24),

                                /// FEEDBACK (STYLE ASLI)
                                SizedBox(
                                  width: double.infinity,
                                  child: OutlinedButton(
                                    onPressed: () {},
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      side: BorderSide(
                                        color: AppColors.accent.withOpacity(0.4),
                                      ),
                                      padding: const EdgeInsets.symmetric(vertical: 12),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: const Text('Feedback'),
                                  ),
                                ),

                                const SizedBox(height: 12),

                                /// LOGOUT (STYLE ASLI)
                                SizedBox(
                                  width: double.infinity,
                                  child: OutlinedButton(
                                    onPressed: () =>
                                        Get.offAllNamed(AppRoutes.splash),
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: AppColors.red,
                                      side: BorderSide(
                                        color: AppColors.red.withOpacity(0.5),
                                      ),
                                      padding: const EdgeInsets.symmetric(vertical: 12),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: const Text('Keluar Akun'),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 80),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// 🔥 NAVBAR (SAMA POLA DASHBOARD)
            Obx(() => AppBottomNav(
                  currentIndex: controller.selectedTab.value,
                  onTap: (i) => controller.navigateTo(_tabIndex, i),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildInput({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      style: AppText.body,
      decoration: InputDecoration(
        hintText: label,
        hintStyle: AppText.caption,
        prefixIcon: Icon(icon),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.white.withOpacity(0.6),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.accent,
            width: 1.5,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _blurCircle(double size, double opacity) {
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