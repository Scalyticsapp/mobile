import 'package:get/get.dart';
import '../routes/app_routes.dart';

class AuthController extends GetxController {

  /// 🔥 LOGIN (TANPA NOTIFIKASI)
  Future<void> login(String email, String password) async {
    try {
      // TODO: logic login (API / Firebase / dummy)

      // 🔥 langsung ke dashboard
      Get.offAllNamed(AppRoutes.dashboard);

    } catch (e) {
      // ❌ tidak ada snackbar / notif
    }
  }

  /// 🔥 REGISTER (TANPA NOTIFIKASI)
  Future<void> register(String email, String password) async {
    try {
      // TODO: logic register

      // 🔥 langsung ke login
      Get.offAllNamed(AppRoutes.login);

    } catch (e) {
      // ❌ tidak ada snackbar / notif
    }
  }
}