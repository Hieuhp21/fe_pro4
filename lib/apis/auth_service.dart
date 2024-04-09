import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/login_request.dart';

class AuthService {
  Future<bool> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('https://yourapi.com/login'),
      body: jsonEncode({'email': email, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      // Xử lý dữ liệu trả về từ API ở đây nếu cần
      return true; // Đăng nhập thành công
    } else {
      return false; // Đăng nhập thất bại
    }
  }
}
