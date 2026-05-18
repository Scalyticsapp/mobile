import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/dashboard_controller.dart';

import '../../core/theme/app_theme.dart';

import '../../routes/app_routes.dart';

import '../../widgets/background_glow.dart';
import '../../widgets/notification_item.dart';

class NotificationView
    extends StatelessWidget {
  const NotificationView({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor:
          const Color(
        0xFF060606,
      ),

      appBar: AppBar(
        backgroundColor:
            const Color(
          0xFF060606,
        ),

        elevation: 0,

        scrolledUnderElevation:
            0,

        automaticallyImplyLeading:
            false,

        leading: GestureDetector(
          onTap: _handleBack,

          child: const Icon(
            Icons
                .arrow_back_ios_new_rounded,

            size: 18,

            color:
                AppColors.textPrimary,
          ),
        ),

        title: Text(
          'Notifikasi',

          style:
              AppText.body.copyWith(
            fontWeight:
                FontWeight.w600,
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
              physics:
                  const BouncingScrollPhysics(),

              padding:
                  const EdgeInsets.fromLTRB(
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
                NotificationItem(
                  isPrimary: true,

                  icon: Icons
                      .document_scanner_rounded,

                  title:
                      'Waktunya scan ulang scalp',

                  desc:
                      'Sudah 7 hari sejak scan terakhir. Pantau kondisi scalp-mu sekarang.',

                  time:
                      'Baru saja',

                  onTap: () {
                    Get.toNamed(
                      AppRoutes.scan,
                    );
                  },
                ),

                /// CHECKLIST
                NotificationItem(
                  icon:
                      Icons.checklist_rounded,

                  title:
                      'Checklist Perawatan',

                  desc:
                      '2 rutinitas scalp belum selesai.',

                  time:
                      '2 jam lalu',

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
                NotificationItem(
                  icon: Icons
                      .document_scanner_rounded,

                  title:
                      'Scan Berhasil',

                  desc:
                      'Hasil analisis scalp berhasil diperbarui.',

                  time:
                      '12 Mei 2026',

                  onTap: () {
                    Get.toNamed(
                      AppRoutes.scan,
                    );
                  },
                ),

                /// OLD CHECKLIST
                NotificationItem(
                  icon:
                      Icons.checklist_rounded,

                  title:
                      'Perawatan Selesai',

                  desc:
                      'Rutinitas scalp malam berhasil diselesaikan.',

                  time:
                      '10 Mei 2026',

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
    if (Get.isRegistered<
        DashboardController>()) {
      Get.find<DashboardController>()
          .selectedTab
          .value = 0;
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
      padding:
          const EdgeInsets.only(
        left: 2,
      ),

      child: Text(
        text,

        style:
            AppText.body.copyWith(
          fontSize: 13,

          fontWeight:
              FontWeight.w500,

          color:
              AppColors.textPrimary,
        ),
      ),
    );
  }
}