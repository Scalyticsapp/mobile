import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart'
    as http;

import '../../core/constants/app_api.dart';
import '../../core/constants/app_strings.dart';

class AuthService {
  final String baseUrl =
      AppApi.baseUrl;

  final storage =
      const FlutterSecureStorage();

  // 🔐 LOGIN
  Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) async {
    try {
      final response =
          await http
              .post(
                Uri.parse(
                  '$baseUrl/api/auth/login',
                ),
                headers: {
                  'Content-Type':
                      'application/json',

                  'ngrok-skip-browser-warning':
                      'true',
                },
                body: jsonEncode({
                  'email': email,
                  'password': password,
                }),
              )
              .timeout(
                const Duration(
                  seconds: 15,
                ),
              );

      print(
        'STATUS LOGIN: ${response.statusCode}',
      );

      print(
        'BODY LOGIN: ${response.body}',
      );

      final bool isSuccess =
          response.statusCode == 200 &&
          response.body.isNotEmpty;

      if (isSuccess) {
        final data =
            jsonDecode(response.body);

        final token =
            data['access_token'];

        await storage.write(
          key: 'token',
          value: token,
        );

        final savedToken =
          await storage.read(
        key: 'token',
      );

      print(
        'TOKEN TERSIMPAN: $savedToken',
      );

        return data;
      }

      return {
        'message':
            '${AppStrings.loginFailed} (${response.statusCode})',
      };
    } catch (e) {
      print('LOGIN ERROR: $e');

      return {
        'message':
            AppStrings.networkError,
      };
    }
  }

  // 📝 REGISTER
  Future<Map<String, dynamic>>
      register(
    String name,
    String email,
    String password,
  ) async {
    try {
      final response =
          await http
              .post(
                Uri.parse(
                  '$baseUrl/api/auth/register',
                ),
                headers: {
                  'Content-Type':
                      'application/json',

                  'ngrok-skip-browser-warning':
                      'true',
                },
                body: jsonEncode({
                  'email': email,
                  'password': password,
                  'name': name,
                }),
              )
              .timeout(
                const Duration(
                  seconds: 15,
                ),
              );

      print(
        'STATUS REGISTER: ${response.statusCode}',
      );

      print(
        'BODY REGISTER: ${response.body}',
      );

      final bool isSuccess =
          response.statusCode == 200 &&
          response.body.isNotEmpty;

      if (isSuccess) {
        return jsonDecode(
          response.body,
        );
      }

      return {
        'message':
            '${AppStrings.registerFailed} (${response.statusCode})',
      };
    } catch (e) {
      print(
        'REGISTER ERROR: $e',
      );

      return {
        'message':
            AppStrings.networkError,
      };
    }
  }

  // 👤 GET USER
  Future<Map<String, dynamic>>
      getMe(
    String token,
  ) 
  
  async {
    try {
      final response =
          await http
              .get(
                Uri.parse(
                  '$baseUrl/api/auth/me',
                ),
                headers: {
                  'Authorization':
                      'Bearer $token',

                  'ngrok-skip-browser-warning':
                      'true',
                },
              )
              .timeout(
                const Duration(
                  seconds: 15,
                ),
              );

      print(
        'STATUS ME: ${response.statusCode}',
      );

      print(
        'BODY ME: ${response.body}',
      );

      final bool isSuccess =
          response.statusCode == 200 &&
          response.body.isNotEmpty;

      if (isSuccess) {
        return jsonDecode(
          response.body,
        );
      }

      return {
        'message':
            'Gagal ambil user',
      };
    } catch (e) {
      print(
        'GET ME ERROR: $e',
      );

      return {
        'message':
            AppStrings.serverError,
      };
    }
  }

  // ✏️ UPDATE PROFILE
Future<Map<String, dynamic>>
    updateProfile(
  String token,
  String name,
) async {
  try {
    final response =
        await http.put(
      Uri.parse(
        '$baseUrl/api/auth/update-profile',
      ),

      headers: {
        'Content-Type':
            'application/json',

        'Authorization':
            'Bearer $token',

        'ngrok-skip-browser-warning':
            'true',
      },

      body: jsonEncode({
        'name': name,
      }),
    );

    print(
      'STATUS UPDATE: ${response.statusCode}',
    );

    print(
      'BODY UPDATE: ${response.body}',
    );

    if (response.statusCode == 200) {
      return jsonDecode(
        response.body,
      );
    }

    return {
      'message':
          'Update profile gagal',
    };
  } catch (e) {
    print(
      'UPDATE ERROR: $e',
    );

    return {
      'message':
          AppStrings.serverError,
    };
  }
}

  // 🚪 LOGOUT
  Future<void> logout() async {
    await storage.delete(
      key: 'token',
    );
  }
}