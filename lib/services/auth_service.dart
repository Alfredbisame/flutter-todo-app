import 'dart:convert';
import 'package:bloc_todo/models/user.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final String _registerUrl = dotenv.env['REGISTER_API_URL']!;

  Future<Map<String, dynamic>> register(User user) async {
    if (!user.isValid()) {
      return {'error': 'Invalid user data'};
    }
    if (_registerUrl.isEmpty) {
      return {'error': 'API URL not found'};
    }
    try {
      final response = await http.post(
        Uri.parse(_registerUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(user.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {'success': true, 'data': jsonDecode(response.body)};
      } else {
        return {'error': 'Registration failed: ${response.reasonPhrase}'};
      }
    } catch (e) {
      return {'error': 'Network error: $e'};
    }
  }
}