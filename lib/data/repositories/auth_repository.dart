import '../services/auth_service.dart';

class AuthRepository {
  final AuthService _authService =
      AuthService();

  // 🔐 LOGIN
  Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) async {
    return await _authService.login(
      email,
      password,
    );
  }

  // 📝 REGISTER
  Future<Map<String, dynamic>> register(
    String name,
    String email,
    String password,
  ) async {
    return await _authService.register(
      name,
      email,
      password,
    );
  }

  // 👤 GET USER
  Future<Map<String, dynamic>> getMe(
    String token,
  ) async {
    return await _authService.getMe(
      token,
    );
  }
}