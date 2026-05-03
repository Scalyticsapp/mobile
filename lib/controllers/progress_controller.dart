import 'package:get/get.dart';
import '../models/scalp_result.dart';

class ProgressController extends GetxController {
  final selectedPeriod = '3B'.obs;
  final periods = ['1M', '3B', '6B', '1T'];

  // 🔥 GANTI INI UNTUK DEMO:
  // 'soon'    → banner kuning "5 hari lagi scan"
  // 'overdue' → banner merah "scan sekarang"
  final demoMode = 'soon';

  final _baseHistory = [
    ScanHistory(date: DateTime(2026, 4, 21), score: 75, dandruffPct: 42, change: 8),
    ScanHistory(date: DateTime(2026, 4, 14), score: 67, dandruffPct: 58, change: 5),
    ScanHistory(date: DateTime(2026, 4, 7), score: 62, dandruffPct: 70, change: 0),
    ScanHistory(date: DateTime(2026, 3, 31), score: 62, dandruffPct: 72, change: -3),
    ScanHistory(date: DateTime(2026, 3, 24), score: 59, dandruffPct: 76, change: -2),
  ];

  RxList<ScanHistory> get scanHistory {
    if (demoMode == 'soon') {
      return [
        ScanHistory(
          date: DateTime.now().subtract(const Duration(days: 2)),
          score: 75,
          dandruffPct: 42,
          change: 8,
        ),
        ..._baseHistory.skip(1),
      ].obs;
    } else if (demoMode == 'overdue') {
      return [
        ScanHistory(
          date: DateTime.now().subtract(const Duration(days: 7)),
          score: 75,
          dandruffPct: 42,
          change: 8,
        ),
        ..._baseHistory.skip(1),
      ].obs;
    }
    return _baseHistory.obs;
  }

  final chartData = [
    [50.0, 36.0, 20.0],
    [46.0, 34.0, 22.0],
    [40.0, 32.0, 18.0],
    [36.0, 30.0, 16.0],
    [30.0, 28.0, 14.0],
    [24.0, 24.0, 12.0],
    [18.0, 20.0, 10.0],
  ].obs;

  void selectPeriod(String p) => selectedPeriod.value = p;
}