import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../theme/app_theme.dart';
import '../../widgets/shared_widgets.dart';
import '../../controllers/dashboard_controller.dart';
import '../../routes/app_routes.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
 Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF060606),

      appBar: AppBar(
        backgroundColor: const Color(0xFF060606),
        elevation: 0,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,

        leading: GestureDetector(
          onTap: () {
            if (Get.isRegistered<DashboardController>()) {
              Get.find<DashboardController>()
                  .selectedTab
                  .value = 0;
            }

            Get.offAllNamed(AppRoutes.dashboard);
          },

          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 18,
            color: AppColors.textPrimary,
          ),
        ),

        title: Text(
          'Notifikasi',
          style: AppText.body.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),

        centerTitle: true,
      ),

      body: SafeArea(
        top: false,

        child: Stack(
          children: [

            /// BLUR TOP
            Positioned(
              top: -100,
              left: -120,

              child: Container(
                width: 360,
                height: 360,

                decoration: BoxDecoration(
                  shape: BoxShape.circle,

                  gradient: RadialGradient(
                    colors: [
                      AppColors.accent
                          .withOpacity(0.15),

                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            /// BLUR BOTTOM
            Positioned(
              bottom: -120,
              right: -80,

              child: Container(
                width: 320,
                height: 320,

                decoration: BoxDecoration(
                  shape: BoxShape.circle,

                  gradient: RadialGradient(
                    colors: [
                      AppColors.a2
                          .withOpacity(0.12),

                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            /// CONTENT
            ListView(
              physics:
                  const BouncingScrollPhysics(),

              padding: const EdgeInsets.fromLTRB(
                16,
                12,
                16,
                30,
              ),

              children: [

                /// HEADER
                Text(
                  'Aktivitas scalp terbaru',
                  style: AppText.caption.copyWith(
                    fontSize: 12,
                  ),
                ),

                const SizedBox(height: 18),

                /// HERO NOTIFICATION
                _buildHeroReminder(),

                const SizedBox(height: 24),

                /// ACTIVITY
                _sectionTitle(
                  'Aktivitas Terbaru',
                ),

                const SizedBox(height: 10),

                /// PROGRESS
                _notifItem(
                  icon:
                      Icons.check_circle_rounded,

                  color: AppColors.green,

                  title:
                      'Progress meningkat',

                  desc:
                      'Scalp Health Score naik +12 dibanding scan sebelumnya.',

                  time: 'Hari ini',

                  onTap: () =>
                      Get.toNamed(
                        AppRoutes.progress,
                      ),
                ),

                /// ROUTINE
                _notifItem(
                  icon:
                      Icons.notifications_active_rounded,

                  color: AppColors.yellow,

                  title:
                      'Reminder perawatan',

                  desc:
                      'Jangan lupa gunakan sampo anti ketombe malam ini.',

                  time: '2 jam lalu',

                  onTap: null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// HERO REMINDER
  Widget _buildHeroReminder() {
    return GestureDetector(
      onTap: () =>
          Get.toNamed(AppRoutes.scan),

      child: Container(
        padding: const EdgeInsets.all(18),

        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(24),

          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,

            colors: [
              const Color(0xFF182500),
              const Color(0xFF101A00),
            ],
          ),

          border: Border.all(
            color:
                AppColors.accent.withOpacity(
              0.22,
            ),
          ),

          boxShadow: [
            BoxShadow(
              color: AppColors.accent
                  .withOpacity(0.08),

              blurRadius: 30,
              spreadRadius: 1,
            ),
          ],
        ),

        child: Row(
          children: [

            /// ICON
            Container(
              width: 56,
              height: 56,

              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(
                  18,
                ),

                color: AppColors.accent
                    .withOpacity(0.12),
              ),

              child: const Icon(
                Icons.document_scanner_rounded,
                color: AppColors.accent,
                size: 30,
              ),
            ),

            const SizedBox(width: 16),

            /// TEXT
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Text(
                    'Waktunya scan ulang scalp',
                    style:
                        AppText.headingSm.copyWith(
                      fontWeight:
                          FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    'Sudah 7 hari sejak scan terakhir. Pantau perkembangan kondisi scalp-mu sekarang.',
                    style:
                        AppText.caption.copyWith(
                      fontSize: 11,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [

                      Text(
                        'Mulai Scan AI',
                        style:
                            AppText.body.copyWith(
                          color:
                              AppColors.accent,

                          fontWeight:
                              FontWeight.w600,

                          fontSize: 12,
                        ),
                      ),

                      const SizedBox(width: 4),

                      const Icon(
                        Icons
                            .arrow_forward_ios_rounded,

                        size: 14,
                        color:
                            AppColors.accent,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// SECTION TITLE
  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: AppText.body.copyWith(
        fontSize: 13,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  /// NOTIFICATION ITEM
  Widget _notifItem({
    required IconData icon,
    required Color color,
    required String title,
    required String desc,
    required String time,
    required VoidCallback? onTap,
  }) {
    return Padding(
      padding:
          const EdgeInsets.only(bottom: 10),

      child: GestureDetector(
        onTap: onTap,

        child: AppCard(
          padding: const EdgeInsets.all(14),

          child: Row(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              /// ICON
              Container(
                width: 42,
                height: 42,

                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(
                    12,
                  ),

                  color:
                      color.withOpacity(0.12),
                ),

                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),

              const SizedBox(width: 12),

              /// TEXT
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,

                  children: [

                    Row(
                      children: [

                        Expanded(
                          child: Text(
                            title,
                            style:
                                AppText.body.copyWith(
                              fontSize: 12.5,
                              fontWeight:
                                  FontWeight
                                      .w600,
                            ),
                          ),
                        ),

                        Text(
                          time,
                          style:
                              AppText.caption.copyWith(
                            fontSize: 10.5,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 5),

                    Text(
                      desc,
                      style:
                          AppText.caption.copyWith(
                        fontSize: 10.5,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),

              if (onTap != null) ...[
                const SizedBox(width: 8),

                const Padding(
                  padding:
                      EdgeInsets.only(top: 8),

                  child: Icon(
                    Icons
                        .chevron_right_rounded,

                    size: 18,
                    color: AppColors.muted,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}