import 'package:get/get.dart';
import '../data/models/scalp_result.dart';
import '../routes/app_routes.dart';

class DashboardController extends GetxController {

  final selectedTab = 0.obs;

  final routines = <Routine>[
    Routine(name: 'Masker Lidah Buaya', duration: '15 menit', time: 'Pagi', icon: '🌿', isDone: true),
    Routine(name: 'Sampo Anti-Dandruff', duration: '5 menit', time: 'Siang', icon: '💧', isDone: true),
    Routine(name: 'Kondisioner Deep Care', duration: '10 menit', time: 'Malam', icon: '🍯'),
  ].obs;

  void toggleRoutine(int index) {
    routines[index].isDone = !routines[index].isDone;
    routines.refresh();
  }

  /// Peta index → route
  static const _routes = [
    AppRoutes.dashboard,
    AppRoutes.scan,
    AppRoutes.progress,
    AppRoutes.profile,
  ];

  /// Navigasi dari navbar mana pun.
  /// [fromIndex] = index tab halaman yang sedang membuka navbar ini.
  /// [toIndex]   = index tab yang dituju user.
  void navigateTo(int fromIndex, int toIndex) {
    if (fromIndex == toIndex) return;

    selectedTab.value = toIndex;

    // Kalau tujuan adalah dashboard, bersihkan semua stack
    // supaya tidak terjadi tumpukan route yang kacau.
    if (toIndex == 0) {
      Get.offAllNamed(AppRoutes.dashboard);
    } else {
      // Dari halaman mana pun selain dashboard:
      // offNamedUntil ke dashboard dulu lalu push tujuan,
      // sehingga stack selalu: dashboard → halaman aktif.
      Get.offAllNamed(_routes[toIndex]);
    }
  }
}