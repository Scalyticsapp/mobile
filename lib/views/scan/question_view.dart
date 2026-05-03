import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/app_theme.dart';
import '../../routes/app_routes.dart';
import '../../controllers/scan_controller.dart';

class QuestionView extends StatefulWidget {
  const QuestionView({super.key});

  @override
  State<QuestionView> createState() => _QuestionViewState();
}

class _QuestionViewState extends State<QuestionView> {
  String? selectedDandruff;
  String? selectedOil;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF060606),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // 🔹 HEADER
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: const Icon(Icons.arrow_back_ios_new_rounded,
                        size: 18, color: AppColors.textPrimary),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Pertanyaan',
                    style: AppText.body.copyWith(fontWeight: FontWeight.w600),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // 🔹 TITLE
              Text(
                'Bantu kami memahami kondisi scalp kamu',
                style: AppText.headingMd.copyWith(fontSize: 18),
              ),

              const SizedBox(height: 24),

              // 🔹 Q1
              _question(
                'Apakah kamu mengalami ketombe?',
                ['Tidak', 'Sedikit', 'Parah'],
                selectedDandruff,
                (val) => setState(() => selectedDandruff = val),
              ),

              const SizedBox(height: 20),

              // 🔹 Q2
              _question(
                'Kulit kepala kamu terasa?',
                ['Normal', 'Berminyak', 'Kering'],
                selectedOil,
                (val) => setState(() => selectedOil = val),
              ),

              const Spacer(),

              // 🔹 BUTTON
              GestureDetector(
                onTap: () {
                  if (selectedDandruff == null || selectedOil == null) {
                    Get.snackbar('Oops', 'Isi semua pertanyaan dulu ya');
                    return;
                  }

                  // 👉 lanjut ke loading (yang tadi kamu punya)
                  final controller = Get.find<ScanController>();

                  controller.userDandruff = selectedDandruff!;
                  controller.userOil = selectedOil!;

                  Get.toNamed(AppRoutes.loading);
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: AppColors.accent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      'Lanjut Analisis',
                      style: TextStyle(
                          fontWeight: FontWeight.w600, color: Colors.black),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // 🔹 WIDGET QUESTION
  Widget _question(
    String title,
    List<String> options,
    String? selected,
    Function(String) onSelect,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppText.body.copyWith(fontSize: 13)),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          children: options.map((o) {
            final isSelected = selected == o;

            return GestureDetector(
              onTap: () => onSelect(o),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.accent.withOpacity(0.2)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color:
                        isSelected ? AppColors.accent : AppColors.border,
                  ),
                ),
                child: Text(
                  o,
                  style: TextStyle(
                    fontSize: 11,
                    color: isSelected
                        ? AppColors.accent
                        : AppColors.textPrimary,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}