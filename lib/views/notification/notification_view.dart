import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/app_theme.dart';
import '../../widgets/shared_widgets.dart';
import '../../controllers/dashboard_controller.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF060606),

      // ✅ Sama persis seperti progress
      appBar: AppBar(
        backgroundColor: const Color(0xFF060606),
        elevation: 0,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            if (Get.isRegistered<DashboardController>()) {
              Get.find<DashboardController>().selectedTab.value = 0;
            }
            Get.offAllNamed('/dashboard');
          },
          child: const Icon(Icons.arrow_back_ios_new_rounded,
              size: 18, color: AppColors.textPrimary),
        ),
        title: Text(
          'Notifikasi',
          style: AppText.body.copyWith(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),

      body: SafeArea(
        top: false,
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

            // CONTENT
            ListView(
              padding: const EdgeInsets.fromLTRB(14, 14, 14, 24),
              children: [
                _notifItem(
                  icon: Icons.camera_alt_rounded,
                  color: AppColors.accent,
                  title: 'Waktunya scan!',
                  desc: 'Sudah 7 hari sejak scan terakhir kamu',
                  time: 'Hari ini',
                  onTap: () => Get.toNamed('/scan'),
                ),
                _notifItem(
                  icon: Icons.notifications_rounded,
                  color: AppColors.yellow,
                  title: 'Reminder',
                  desc: 'Besok waktunya scan scalp kamu',
                  time: 'Kemarin',
                  onTap: null,
                ),
                _notifItem(
                  icon: Icons.check_circle_rounded,
                  color: AppColors.accent,
                  title: 'Progress membaik',
                  desc: 'Kondisi scalp kamu meningkat dari sebelumnya',
                  time: '2 hari lalu',
                  onTap: () => Get.toNamed('/progress'),
                ),
                _notifItem(
                  icon: Icons.info_rounded,
                  color: AppColors.muted,
                  title: 'Tips perawatan',
                  desc: 'Gunakan sampo anti ketombe secara rutin',
                  time: '3 hari lalu',
                  onTap: null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _notifItem({
    required IconData icon,
    required Color color,
    required String title,
    required String desc,
    required String time,
    required VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: onTap,
        child: AppCard(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: color.withOpacity(0.1),
                ),
                child: Icon(icon, color: color, size: 18),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: AppText.body.copyWith(
                            fontSize: 12, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 2),
                    Text(desc,
                        style: AppText.caption.copyWith(fontSize: 10)),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Text(time, style: AppText.caption.copyWith(fontSize: 9)),
              if (onTap != null) ...[
                const SizedBox(width: 4),
                const Icon(Icons.chevron_right_rounded,
                    size: 14, color: AppColors.muted),
              ],
            ],
          ),
        ),
      ),
    );
  }
}