import 'dart:convert';

import 'package:delivery_up_test4/utils/info.dart';
import 'package:http/http.dart' as http;

class AuthController {
  bool isLoading = false;

  Future<void> login({
    required String emailText,
    required String passwordText,
  }) async {
    isLoading = true;
    try {
      final uri = Uri.parse("http://$baseUrl/auth/login");
      final res = await http.post(
        uri,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": "user102@mad.co.kr",
          "password": "Mobile102!",
        }),
      );
      print(res.statusCode);
      print(res.body);

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        token = data['data']['token'];

        id.value = data['data']['user']['id'];
        email.value = data['data']['user']['email'];
        name.value = data['data']['user']['name'];
        grade.value = data['data']['user']['grade'];
      }
    } catch (e) {
      print('error: $e');
    }
    isLoading = false;
  }

  Future<void> logout() async {
    token = '';

    id.value = 0;
    email.value = "";
    name.value = "";
    grade.value = "";
  }
}
