import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../services/auth_service.dart';
import '../routes/app_routes.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();
  final storage = const FlutterSecureStorage();

  var user = {}.obs;
  var isLoading = false.obs;

  // 🔐 LOGIN
  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;

      final res = await _authService.login(email, password);

      print("LOGIN RESPONSE: $res");

      if (res is Map &&
          res.containsKey("access_token") &&
          res["access_token"] != null) {
        
        String token = res["access_token"].toString();

        await storage.write(key: "token", value: token);

        final me = await _authService.getMe(token);

        if (me is Map) {
          user.value = me;
        } else {
          user.value = {};
        }

        Get.offAllNamed(AppRoutes.dashboard);
      } else {
        Get.snackbar(
          "Error",
          res["message"]?.toString() ?? "Login gagal",
        );
      }
    } catch (e) {
      print("LOGIN ERROR: $e");
      Get.snackbar("Error", "Terjadi error saat login");
    } finally {
      isLoading.value = false;
    }
  }

  // 📝 REGISTER
  Future<void> register(String name, String email, String password) async {
    try {
      isLoading.value = true;

      final res = await _authService.register(name, email, password);

      print("REGISTER RESPONSE: $res");

      if (res is Map &&
          res.containsKey("user") &&
          res["user"] != null) {
        
        Get.snackbar("Success", "Register berhasil, silakan login");
        Get.offAllNamed("/login");
      } else {
        Get.snackbar(
          "Error",
          res["message"]?.toString() ?? "Register gagal",
        );
      }
    } catch (e) {
      print("REGISTER ERROR: $e");
      Get.snackbar("Error", "Terjadi error saat register");
    } finally {
      isLoading.value = false;
    }
  }

  // 👤 LOAD USER
  Future<void> loadUser() async {
    try {
      String? token = await storage.read(key: "token");

      if (token != null && token.isNotEmpty) {
        final me = await _authService.getMe(token);

        if (me is Map) {
          user.value = me;
        }
      }
    } catch (e) {
      print("LOAD USER ERROR: $e");
    }
  }

  // 🚪 LOGOUT
  Future<void> logout() async {
    await storage.delete(key: "token");
    user.value = {};
    Get.offAllNamed("/login");
  }
}