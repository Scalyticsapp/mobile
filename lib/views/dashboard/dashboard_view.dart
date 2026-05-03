import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/dashboard_controller.dart';
import '../../theme/app_theme.dart';
import '../../widgets/shared_widgets.dart';
import '../../routes/app_routes.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  // Index tab Dashboard = 0
  static const _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    // ✅ Set selectedTab saat halaman ini aktif — pakai addPostFrameCallback
    // supaya tidak dipanggil di tengah build tree.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.selectedTab.value = _tabIndex;
    });

    return Scaffold(
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

                  // CONTENT SCROLL
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeader(),
                        const SizedBox(height: 20),
                        _buildStatusCard(),
                        const SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: _buildQuickScanBtn(),
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SectionTitle('Perawatan Hari Ini'),
                              _buildRoutineList(),
                              const SizedBox(height: 16),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SectionTitle('Progress Minggu Ini'),
                              const SizedBox(height: 8),
                              _buildProgressCard(),
                              const SizedBox(height: 24),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // NAVBAR
            Obx(() => AppBottomNav(
              currentIndex: controller.selectedTab.value,
              onTap: (i) => controller.navigateTo(_tabIndex, i),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
  return Padding(
    padding: const EdgeInsets.fromLTRB(18, 16, 18, 12),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        // TEXT
        RichText(
          text: TextSpan(
            style: AppText.heading,
            children: [
              TextSpan(
                text: 'Halo, ',
                style: AppText.body.copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                ),
              ),
              TextSpan(
                text: 'Zahwa',
                style: AppText.heading.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),

        // 🔔 NOTIF (FIXED)
        GestureDetector(
          onTap: () => Get.toNamed(AppRoutes.notification),
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.accent.withOpacity(0.05),
                  border: Border.all(
                    color: AppColors.accent.withOpacity(0.3),
                  ),
                ),
                child: const Icon(
                  Icons.notifications_rounded,
                  size: 22,
                  color: AppColors.accent,
                ),
              ),

              // 🔴 DOT
              Positioned(
                top: 2,
                right: 2,
                child: Container(
                  width: 9,
                  height: 9,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

  Widget _buildStatusCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0F1A00),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.accent.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Image.asset(
            'assets/images/hair.png',
            width: 52,
            height: 52,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'KONDISI HARI INI',
                  style: AppText.label.copyWith(color: AppColors.accent),
                ),
                const SizedBox(height: 4),
                Text(
                  'Membaik',
                  style: AppText.headingMd.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Kulit kepala lebih bersih dari sebelumnya · terus pertahankan!',
                  style: AppText.caption.copyWith(fontSize: 11),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoutineList() {
  final colors = [AppColors.a2, AppColors.accent, AppColors.a3];

  return Obx(() => Column(
    children: List.generate(controller.routines.length, (i) {
      final r = controller.routines[i];
      return Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: AppCard(
          padding: const EdgeInsets.all(12),
          child: Row(children: [
            // Icon box
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9),
                color: colors[i].withOpacity(0.1),
              ),
              child: Center(
                child: Text(r.icon, style: const TextStyle(fontSize: 16)),
              ),
            ),
            const SizedBox(width: 10),

            // Nama + durasi
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(r.name,
                      style: AppText.body.copyWith(
                          fontSize: 12, fontWeight: FontWeight.w600)),
                  Text('${r.duration} · ${r.time}',
                      style: AppText.caption.copyWith(fontSize: 10)),
                ],
              ),
            ),

            // 🔥 Centang — sama persis seperti di progress
            GestureDetector(
              onTap: () => controller.toggleRoutine(i),
              child: Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: r.isDone
                      ? AppColors.accent.withOpacity(0.15)
                      : Colors.transparent,
                  border: Border.all(
                    color: r.isDone ? AppColors.accent : AppColors.border,
                    width: 1.5,
                  ),
                ),
                child: r.isDone
                    ? const Icon(Icons.check_rounded,
                        size: 13, color: AppColors.accent)
                    : null,
              ),
            ),
          ]),
        ),
      );
    }),
  ));
}

  Widget _buildQuickScanBtn() {
    return GestureDetector(
      // ✅ Navigasi via controller — bukan langsung Get.toNamed
      onTap: () => controller.navigateTo(_tabIndex, 1),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.accent.withOpacity(0.3)),
          color: AppColors.accent.withOpacity(0.05),
        ),
        child: Row(children: [
          const Icon(Icons.document_scanner_rounded,
              color: AppColors.accent, size: 20),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Scan Scalp Sekarang',
                  style: AppText.body
                      .copyWith(fontWeight: FontWeight.w600, fontSize: 13)),
              Text('Pantau perkembangan kondisimu',
                  style: AppText.caption.copyWith(fontSize: 10)),
            ],
          ),
          const Spacer(),
          const Icon(Icons.chevron_right_rounded, color: AppColors.accent),
        ]),
      ),
    );
  }

  Widget _buildProgressCard() {
    return GestureDetector(
      // ✅ Navigasi via controller
      onTap: () => controller.navigateTo(_tabIndex, 2),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.border),
          color: AppColors.s1,
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.accent.withOpacity(0.1),
              ),
              child: const Icon(Icons.show_chart_rounded,
                  color: AppColors.accent, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Perkembangan Kondisi',
                      style: AppText.body.copyWith(
                          fontWeight: FontWeight.w600, fontSize: 13)),
                  Text('Kondisi membaik dalam beberapa hari terakhir',
                      style: AppText.caption.copyWith(fontSize: 10)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: AppColors.muted),
          ],
        ),
      ),
    );
  }
}