import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/theme/app_theme.dart';
import '../../routes/app_routes.dart';
import '../../widgets/app_bottom_nav.dart';
import '../../controllers/dashboard_controller.dart';
import '../../widgets/background_glow.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() =>
      _ProfileViewState();
}

class _ProfileViewState
    extends State<ProfileView> {

  final controller =
      Get.find<DashboardController>();

  final user =
    Supabase.instance.client.auth.currentUser;

final isGoogleUser =
    Supabase.instance.client.auth.currentSession
        ?.user
        .appMetadata['provider'] ==
    'google';

    late final TextEditingController name;

    late final TextEditingController email;

  final password =
      TextEditingController();

  bool obscurePassword = true;

  static const _tabIndex = 3;

  @override
void initState() {
  super.initState();

  name = TextEditingController(
    text:
        user?.userMetadata?['full_name'] ??
        user?.userMetadata?['name'] ??
        user?.email
                ?.split('@')
                .first ??
        'User',
  );

  email = TextEditingController(
    text: user?.email ?? '',
  );
}

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance
        .addPostFrameCallback((_) {
      controller.selectedTab.value =
          _tabIndex;
    });

    return Scaffold(
      backgroundColor: AppColors.bg,

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
                              height: 80),

                          /// CARD
                          Container(
                            width:
                                double.infinity,

                            constraints:
                                const BoxConstraints(
                              maxWidth: 420,
                            ),

                            padding:
                                const EdgeInsets
                                    .fromLTRB(
                              20,
                              28,
                              20,
                              28,
                            ),

                            decoration:
                                BoxDecoration(
                              color:
                                  AppColors.s1,

                              borderRadius:
                                  BorderRadius
                                      .circular(
                                24,
                              ),

                              border:
                                  Border.all(
                                color: AppColors
                                    .border,
                              ),
                            ),

                            child: Column(
                              children: [

                                /// AVATAR
                                /// AVATAR
Transform.translate(
  offset: const Offset(0, 0),

  child: Container(
    width: 90,
    height: 90,

                                  margin:
                                      const EdgeInsets
                                          .only(
                                    bottom: 14,
                                  ),

                                  decoration:
                                      const BoxDecoration(
                                    shape:
                                        BoxShape
                                            .circle,

                                    gradient:
                                        LinearGradient(
                                      colors: [
                                        AppColors
                                            .accent,
                                        AppColors
                                            .a2,
                                      ],
                                    ),
                                  ),

                                  child: Center(
                                    child: Text(
                                      name.text
                                              .isNotEmpty
                                          ? name
                                              .text[0]
                                              .toUpperCase()
                                          : 'U',

                                      style:
                                          const TextStyle(
                                        color:
                                            AppColors
                                                .bg,

                                        fontSize:
                                            32,

                                        fontWeight:
                                            FontWeight
                                                .bold,
                                      ),
                                    ),
                                  ),
                                ),
),

                                const SizedBox(
                                    height: 16),

                                Text(
                                  'Profil Pengguna',
                                  style: AppText
                                      .headingMd,
                                ),

                                const SizedBox(
                                    height: 6),

                                Text(
                                  'Kelola informasi akun kamu',
                                  textAlign:
                                      TextAlign
                                          .center,

                                  style: AppText
                                      .caption
                                      .copyWith(
                                    fontSize: 11,
                                  ),
                                ),

                                const SizedBox(
                                    height: 24),

                                /// NAMA
                                _buildInput(
                                  controller:
                                      name,
                                  label:
                                      "Nama",
                                  icon: Icons
                                      .person_outline,
                                ),

                                const SizedBox(
                                    height: 14),

                                /// EMAIL
                                _buildInput(
  controller: email,
  label: "Email",
  icon: Icons.mail_outline,
  enabled: false,
),

                                const SizedBox(
                                    height: 14),

                  if (!isGoogleUser) ...[

  const SizedBox(height: 14),

  TextField(
    controller: password,
    obscureText: obscurePassword,
    style: AppText.body,

    decoration: InputDecoration(
      hintText: 'Password',

      hintStyle: AppText.caption,

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
              ? Icons.visibility_off_outlined
              : Icons.visibility_outlined,
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
          color: AppColors.accent,
          width: 1.5,
        ),
      ),

      border: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(
          12,
        ),
      ),
    ),
  ),
],

                                const SizedBox(
                                    height: 24),

                                /// SIMPAN
                                SizedBox(
                                  width:
                                      double
                                          .infinity,

                                  child:
                                      ElevatedButton(
                                    onPressed: () async {

  try {

    await Supabase.instance.client.auth
    .updateUser(
  UserAttributes(
    data: {
      'name': name.text.trim(),
    },
  ),
);

await Supabase.instance.client.auth
    .refreshSession();

FocusScope.of(context).unfocus();


setState(() {});

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
},


                                    style:
                                        ElevatedButton.styleFrom(
                                      backgroundColor:
                                          AppColors
                                              .accent,

                                      foregroundColor:
                                          Colors
                                              .black,

                                      padding:
                                          const EdgeInsets.symmetric(
                                        vertical:
                                            14,
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
                                        const Text(
                                      'Simpan Perubahan',
                                      style:
                                          TextStyle(
                                        fontWeight:
                                            FontWeight
                                                .w700,
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(
                                    height: 12),

                                /// LOGOUT
                                SizedBox(
                                  width:
                                      double
                                          .infinity,

                                  child:
                                      OutlinedButton(
                                    onPressed:
                                        () =>
                                            Get.offAllNamed(
                                      AppRoutes
                                          .splash,
                                    ),

                                        style: OutlinedButton.styleFrom(
                                            minimumSize:
                                                const Size.fromHeight(52),

                                            foregroundColor:
                                                AppColors.red,

                                      side:
                                          BorderSide(
                                        color:
                                            AppColors
                                                .red
                                                .withOpacity(
                                          0.5,
                                        ),
                                      ),

                                      padding:
                                          const EdgeInsets.symmetric(
                                        vertical:
                                            14,
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
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(
                              height: 90),
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

                  onTap: (i) =>
                      controller
                          .navigateTo(
                    _tabIndex,
                    i,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInput({
  required TextEditingController controller,
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

        prefixIcon: Icon(icon),

        enabledBorder:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(
            12,
          ),

          borderSide:
              BorderSide(
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