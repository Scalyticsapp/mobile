import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../services/auth_service.dart';
import '../routes/app_routes.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();
  final storage = const FlutterSecureStorage();

  final supabase = Supabase.instance.client;

  var user = {}.obs;
  var isLoading = false.obs;

  final GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: ['email'],
  serverClientId: '538909060362-imqcte3bcj6so2345q74armnnb56vukg.apps.googleusercontent.com',
  );

  // 🔐 LOGIN EMAIL
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

  // 📝 REGISTER EMAIL
  Future<void> register(String name, String email, String password) async {
    try {
      isLoading.value = true;

      final res = await _authService.register(name, email, password);

      print("REGISTER RESPONSE: $res");

      if (res is Map &&
          res.containsKey("user") &&
          res["user"] != null) {
        
        Get.snackbar("Success", "Register berhasil, silakan login");
        Get.offAllNamed(AppRoutes.login);
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

  // 🔥 LOGIN GOOGLE (INI YANG TADI KURANG)
  Future<void> loginWithGoogle() async {
  try {
    isLoading.value = true;

    // 🔥 FORCE LOGOUT BIAR POPUP MUNCUL
    await _googleSignIn.signOut();

    final googleUser = await _googleSignIn.signIn();

    if (googleUser == null) return;

    final googleAuth = await googleUser.authentication;

    final idToken = googleAuth.idToken;
    final accessToken = googleAuth.accessToken;

    print("ID TOKEN: $idToken");

    if (idToken == null || accessToken == null) {
      throw Exception("Token Google null");
    }

    final res = await supabase.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );

    if (res.session != null) {
      Get.snackbar("Success", "Login Google berhasil");
      Get.offAllNamed(AppRoutes.dashboard);
    } else {
      Get.snackbar("Error", "Login Google gagal");
    }
  } catch (e) {
    print("GOOGLE LOGIN ERROR: $e");
    Get.snackbar("Error", "Login Google gagal");
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
    Get.offAllNamed(AppRoutes.login);
  }
}