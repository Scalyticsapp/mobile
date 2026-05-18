import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/dashboard_controller.dart';

import '../../core/theme/app_theme.dart';

import '../../routes/app_routes.dart';

import '../../widgets/background_glow.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor: const Color(
        0xFF060606,
      ),
      appBar: AppBar(
        backgroundColor: const Color(
          0xFF060606,
        ),
        elevation: 0,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: _handleBack,
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
            /// BACKGROUND
            const BackgroundGlow(),

            /// CONTENT
            ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(
                20,
                16,
                20,
                30,
              ),
              children: [
                /// TERBARU
                _sectionLabel(
                  'Terbaru',
                ),

                const SizedBox(
                  height: 14,
                ),

                /// PRIMARY
                _buildNotificationItem(
                  isPrimary: true,
                  icon: Icons.document_scanner_rounded,
                  title: 'Waktunya scan ulang scalp',
                  desc:
                      'Sudah 7 hari sejak scan terakhir. Pantau kondisi scalp-mu sekarang.',
                  time: 'Baru saja',
                  onTap: () {
                    Get.toNamed(
                      AppRoutes.scan,
                    );
                  },
                ),

                /// CHECKLIST
                _buildNotificationItem(
                  icon: Icons.checklist_rounded,
                  title: 'Checklist Perawatan',
                  desc: '2 rutinitas scalp belum selesai.',
                  time: '2 jam lalu',
                  onTap: () {
                    Get.toNamed(
                      AppRoutes.progress,
                    );
                  },
                ),

                const SizedBox(
                  height: 18,
                ),

                /// SEBELUMNYA
                _sectionLabel(
                  'Sebelumnya',
                ),

                const SizedBox(
                  height: 14,
                ),

                /// OLD SCAN
                _buildNotificationItem(
                  icon: Icons.document_scanner_rounded,
                  title: 'Scan Berhasil',
                  desc: 'Hasil analisis scalp berhasil diperbarui.',
                  time: '12 Mei 2026',
                  onTap: () {
                    Get.toNamed(
                      AppRoutes.scan,
                    );
                  },
                ),

                /// OLD CHECKLIST
                _buildNotificationItem(
                  icon: Icons.checklist_rounded,
                  title: 'Perawatan Selesai',
                  desc: 'Rutinitas scalp malam berhasil diselesaikan.',
                  time: '10 Mei 2026',
                  onTap: () {
                    Get.toNamed(
                      AppRoutes.progress,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// HANDLE BACK
  void _handleBack() {
    if (Get.isRegistered<DashboardController>()) {
      Get.find<DashboardController>().selectedTab.value = 0;
    }

    Get.offAllNamed(
      AppRoutes.dashboard,
    );
  }

  /// SECTION LABEL
  Widget _sectionLabel(
    String text,
  ) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 2,
      ),
      child: Text(
        text,
        style: AppText.body.copyWith(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  Widget _buildNotificationItem({
    required IconData icon,
    required String title,
    required String desc,
    required String time,
    required VoidCallback? onTap,
    bool isPrimary = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: isPrimary ? 16 : 14,
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(
            isPrimary ? 18 : 16,
          ),
          decoration: BoxDecoration(
            color: AppColors.s1,
            borderRadius: BorderRadius.circular(
              22,
            ),
            border: Border.all(
              color: AppColors.border,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// ICON
              Container(
                width: isPrimary ? 62 : 56,
                height: isPrimary ? 62 : 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    isPrimary ? 20 : 18,
                  ),
                  color: AppColors.accent.withOpacity(
                    0.12,
                  ),
                ),
                child: Icon(
                  icon,
                  color: AppColors.accent,
                  size: isPrimary ? 30 : 24,
                ),
              ),

              const SizedBox(
                width: 14,
              ),

              /// CONTENT
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: isPrimary ? 2 : 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppText.body.copyWith(
                        fontSize: isPrimary ? 15 : 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: isPrimary ? 8 : 6,
                    ),
                    Text(
                      desc,
                      maxLines: isPrimary ? 3 : 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppText.caption.copyWith(
                        fontSize: isPrimary ? 11.5 : 11,
                        height: 1.6,
                      ),
                    ),
                    if (isPrimary) ...[
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Text(
                            'Mulai Scan AI',
                            style: AppText.body.copyWith(
                              color: AppColors.accent,
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 15,
                            color: AppColors.accent,
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(
                width: 12,
              ),

              /// RIGHT SIDE
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    time,
                    style: AppText.caption.copyWith(
                      fontSize: isPrimary ? 11 : 10.5,
                      color: isPrimary ? AppColors.accent : AppColors.muted2,
                      fontWeight: isPrimary ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: isPrimary ? 4 : 18,
                  ),
                  isPrimary
                      ? Container(
                          width: 7,
                          height: 7,
                          decoration: const BoxDecoration(
                            color: AppColors.accent,
                            shape: BoxShape.circle,
                          ),
                        )
                      : const Icon(
                          Icons.chevron_right_rounded,
                          size: 20,
                          color: AppColors.muted2,
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
