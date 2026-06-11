import 'dart:convert';
import 'dart:async';
import 'package:point_sale/core/constants/api_constants.dart';
import 'package:http/http.dart' as http;
import 'package:point_sale/core/services/user_session.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart' show kDebugMode;

class AuthService {
  static const String _authTokenKey = 'auth_token';

  static String get _registerUrl => ApiConstants.register;
  static String get _loginUrl => ApiConstants.login;
  static String get _logoutUrl => ApiConstants.logout;
  static String get _meUrl => ApiConstants.me;

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_authTokenKey);
  }

  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_authTokenKey, token);
  }

  Future<void> _clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_authTokenKey);
  }

  Future<RegisterResult> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(_registerUrl),
        headers: const {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': passwordConfirmation,
        }),
      ).timeout(const Duration(seconds: 15));

      final jsonBody = response.body.isNotEmpty
          ? jsonDecode(response.body) as Map<String, dynamic>
          : <String, dynamic>{};

      if (response.statusCode == 200 || response.statusCode == 201) {
        return RegisterResult(success: true, message: 'Account created successfully.');
      }

      final message = _extractErrorMessage(jsonBody) ??
          'Registration failed (${response.statusCode}). Please try again.';

      return RegisterResult(success: false, message: message);
    } on TimeoutException {
      return RegisterResult(
        success: false,
        message: 'Request timed out. Please check your network and try again.',
      );
    } catch (e) {
      final details = kDebugMode ? ' (${e.toString()})' : '';
      return RegisterResult(
        success: false,
        message: 'Unable to connect to server. Please check your network and try again.$details',
      );
    }
  }

  Future<LoginResult> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(_loginUrl),
        headers: const {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      ).timeout(const Duration(seconds: 15));

      final jsonBody = response.body.isNotEmpty
          ? jsonDecode(response.body) as Map<String, dynamic>
          : <String, dynamic>{};

      if (response.statusCode == 200 || response.statusCode == 201) {
        final token = _extractToken(jsonBody);

        if (token != null && token.trim().isNotEmpty) {
          await _saveToken(token);
        }

        UserSession.instance.user = jsonBody['data'] as Map<String, dynamic>?;

        return LoginResult(
          success: true,
          message: _extractSuccessMessage(jsonBody) ?? 'Login successful.',
          token: token,
        );
      }

      final message = _extractErrorMessage(jsonBody) ??
          'Login failed (${response.statusCode}). Please try again.';

      return LoginResult(success: false, message: message);
    } on TimeoutException {
      return LoginResult(
        success: false,
        message: 'Request timed out. Please check your network and try again.',
      );
    } catch (e) {
      final details = kDebugMode ? ' (${e.toString()})' : '';
      return LoginResult(
        success: false,
        message: 'Unable to connect to server. Please check your network and try again.$details',
      );
    }
  }

  Future<LogoutResult> logout() async {
    try {
      final token = await getToken();
      final headers = <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

      if (token != null && token.trim().isNotEmpty) {
        headers['Authorization'] = 'Bearer ${token.trim()}';
      }

      final response = await http.delete(
        Uri.parse(_logoutUrl),
        headers: headers,
      ).timeout(const Duration(seconds: 15));

      final jsonBody = response.body.isNotEmpty
          ? jsonDecode(response.body) as Map<String, dynamic>
          : <String, dynamic>{};

      if (response.statusCode == 200 || response.statusCode == 204) {
        await _clearToken();
        UserSession.instance.clear();

        return LogoutResult(
          success: true,
          message: _extractSuccessMessage(jsonBody) ?? 'Logged out successfully.',
        );
      }

      return LogoutResult(
        success: false,
        message: _extractErrorMessage(jsonBody) ??
          'Logout failed (${response.statusCode}). Please try again.',
      );
    } on TimeoutException {
      return LogoutResult(
        success: false,
        message: 'Request timed out. Please check your network and try again.',
      );
    } catch (e) {
      final details = kDebugMode ? ' (${e.toString()})' : '';
      return LogoutResult(
        success: false,
        message: 'Unable to connect to server. Please check your network and try again.$details',
      );
    }
  }

  String? _extractSuccessMessage(Map<String, dynamic> body) {
    final message = body['message'];
    if (message is String && message.trim().isNotEmpty) {
      return message;
    }

    return null;
  }

  String? _extractToken(Map<String, dynamic> body) {
    final directToken = body['token'];
    if (directToken is String && directToken.trim().isNotEmpty) {
      return directToken;
    }

    final data = body['data'];
    if (data is Map<String, dynamic>) {
      final dataToken = data['token'];
      if (dataToken is String && dataToken.trim().isNotEmpty) {
        return dataToken;
      }
    }

    return null;
  }

  String? _extractErrorMessage(Map<String, dynamic> body) {
    final message = body['message'];
    if (message is String && message.trim().isNotEmpty) {
      return message;
    }

    final errors = body['errors'];
    if (errors is Map<String, dynamic>) {
      for (final value in errors.values) {
        if (value is List && value.isNotEmpty && value.first is String) {
          return value.first as String;
        }
      }
    }

    return null;
  }
}

class RegisterResult {
  final bool success;
  final String message;

  RegisterResult({required this.success, required this.message});
}

class LoginResult {
  final bool success;
  final String message;
  final String? token;

  LoginResult({required this.success, required this.message, this.token});
}

class LogoutResult {
  final bool success;
  final String message;

  LogoutResult({required this.success, required this.message});
}
