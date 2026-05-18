import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../core/constants/app_strings.dart';
import '../data/repositories/auth_repository.dart';
import '../routes/app_routes.dart';

class AuthController extends GetxController {
  final AuthRepository _authRepository =
      AuthRepository();

  final FlutterSecureStorage storage =
      const FlutterSecureStorage();

  final SupabaseClient supabase =
      Supabase.instance.client;

  final RxMap user = {}.obs;

  final RxBool isLoading = false.obs;
  final RxBool isGoogleLoading =
      false.obs;

  final GoogleSignIn _googleSignIn =
      GoogleSignIn(
    scopes: ['email'],
    serverClientId:
        '538909060362-imqcte3bcj6so2345q74armnnb56vukg.apps.googleusercontent.com',
  );

  // 🔐 LOGIN EMAIL
  Future<void> login(
    String email,
    String password,
  ) async {
    try {
      isLoading.value = true;

      final response =
          await _authRepository.login(
        email,
        password,
      );

      print(
        'LOGIN RESPONSE: $response',
      );

      final bool hasToken =
          response.containsKey(
            'access_token',
          ) &&
          response['access_token'] !=
              null;

      if (!hasToken) {
        Get.snackbar(
          'Error',
          response['message']
                  ?.toString() ??
              AppStrings.loginFailed,
        );
        return;
      }

      final String token =
          response['access_token']
              .toString();

      await storage.write(
        key: 'token',
        value: token,
      );

      final userData =
          await _authRepository.getMe(
        token,
      );

      user.value = userData;

      Get.snackbar(
        'Success',
        AppStrings.loginSuccess,
      );

      Get.offAllNamed(
        AppRoutes.dashboard,
      );
    } catch (e) {
      print('LOGIN ERROR: $e');

      Get.snackbar(
        'Error',
        AppStrings.serverError,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // 📝 REGISTER EMAIL
  Future<void> register(
    String name,
    String email,
    String password,
  ) async {
    try {
      isLoading.value = true;

      final response =
          await _authRepository.register(
        name,
        email,
        password,
      );

      print(
        'REGISTER RESPONSE: $response',
      );

      final bool isSuccess =
          response.containsKey('user') &&
          response['user'] != null;

      if (!isSuccess) {
        Get.snackbar(
          'Error',
          response['message']
                  ?.toString() ??
              AppStrings.registerFailed,
        );
        return;
      }

      Get.snackbar(
        'Success',
        AppStrings.registerSuccess,
      );

      Get.offAllNamed(
        AppRoutes.login,
      );
    } catch (e) {
      print(
        'REGISTER ERROR: $e',
      );

      Get.snackbar(
        'Error',
        AppStrings.serverError,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // 🔥 LOGIN GOOGLE
  Future<void> loginWithGoogle() async {
    try {
      isGoogleLoading.value = true;

      // Force logout agar popup akun muncul
      await _googleSignIn.signOut();

      final GoogleSignInAccount?
          googleUser =
          await _googleSignIn.signIn();

      if (googleUser == null) {
        return;
      }

      final googleAuth =
          await googleUser.authentication;

      final String? idToken =
          googleAuth.idToken;

      final String? accessToken =
          googleAuth.accessToken;

      print('ID TOKEN: $idToken');

      if (idToken == null ||
          accessToken == null) {
        throw Exception(
          'Google token null',
        );
      }

      final response =
          await supabase.auth
              .signInWithIdToken(
        provider:
            OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );

      if (response.session == null) {
        Get.snackbar(
          'Error',
          'Login Google gagal',
        );
        return;
      }

      Get.snackbar(
        'Success',
        'Login Google berhasil',
      );

      Get.offAllNamed(
        AppRoutes.dashboard,
      );
    } catch (e) {
      print(
        'GOOGLE LOGIN ERROR: $e',
      );

      Get.snackbar(
        'Error',
        'Login Google gagal',
      );
    } finally {
      isGoogleLoading.value =
          false;
    }
  }

  // 👤 LOAD USER
  Future<void> loadUser() async {
    try {
      final String? token =
          await storage.read(
        key: 'token',
      );

      if (token == null ||
          token.isEmpty) {
        return;
      }

      final userData =
          await _authRepository.getMe(
        token,
      );

      user.value = userData;
    } catch (e) {
      print(
        'LOAD USER ERROR: $e',
      );
    }
  }

  // 🚪 LOGOUT
  Future<void> logout() async {
    await storage.delete(
      key: 'token',
    );

    user.value = {};

    Get.offAllNamed(
      AppRoutes.login,
    );
  }
}