import 'dart:convert';

import 'package:delivery_up/utils/info.dart';
import 'package:http/http.dart' as http;

class AuthController {
  String? error;

  Future<bool> login({
    required String emailText,
    required String passwordText,
  }) async {
    error = null;

    try {
      final res = await http.post(
        Uri.parse("$baseUrl/auth/login"),
        headers: {"Content-Type": "application/json"},
        body: {"email": emailText, "password": passwordText},
      );

      print("stats : ${res.statusCode}");
      print("body : ${res.body}");

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        tkn = data['data']['token'];
        id.value = data['data']['user']['id'];
        email.value = data['data']['user']['email'];
        name.value = data['data']['user']['name'];
        grade.value = data['data']['user']['grade'];

        return true;
      } else {
        print("stats : ${res.statusCode}");
        return false;
      }
    } catch (e) {
      error = "네트워크 오류 : $e";
      return false;
    }
  }

  Future<void> logout() async {
    tkn = '';

    id.value = 0;
    email.value = '';
    name.value = '';
    grade.value = '';
  }
}
