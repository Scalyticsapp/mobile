import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl = "http://10.225.58.243:4000";

  // 🔐 LOGIN
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final res = await http.post(
        Uri.parse("$baseUrl/api/auth/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      print("STATUS LOGIN: ${res.statusCode}");
      print("BODY LOGIN: ${res.body}");

      if (res.statusCode == 200 && res.body.isNotEmpty) {
        return jsonDecode(res.body);
      } else {
        return {"message": "Login gagal (${res.statusCode})"};
      }
    } catch (e) {
      print("LOGIN ERROR: $e");
      return {"message": "Tidak bisa connect ke server"};
    }
  }

  // 📝 REGISTER
  Future<Map<String, dynamic>> register(
      String name, String email, String password) async {
    try {
      final res = await http.post(
        Uri.parse("$baseUrl/api/auth/register"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "password": password,
          "name": name,
        }),
      );

      print("STATUS REGISTER: ${res.statusCode}");
      print("BODY REGISTER: ${res.body}");

      if (res.statusCode == 200 && res.body.isNotEmpty) {
        return jsonDecode(res.body);
      } else {
        return {"message": "Register gagal (${res.statusCode})"};
      }
    } catch (e) {
      print("REGISTER ERROR: $e");
      return {"message": "Tidak bisa connect ke server"};
    }
  }

  // 👤 GET USER (🔥 INI YANG KEMARIN KURANG)
  Future<Map<String, dynamic>> getMe(String token) async {
    try {
      final res = await http.get(
        Uri.parse("$baseUrl/api/auth/me"),
        headers: {
          "Authorization": "Bearer $token",
        },
      );

      print("STATUS ME: ${res.statusCode}");
      print("BODY ME: ${res.body}");

      if (res.statusCode == 200 && res.body.isNotEmpty) {
        return jsonDecode(res.body);
      } else {
        return {"message": "Gagal ambil user"};
      }
    } catch (e) {
      print("GET ME ERROR: $e");
      return {"message": "Error get user"};
    }
  }
}