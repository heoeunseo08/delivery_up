import 'dart:convert';

import 'package:delivery_up_test4/model/profile_model.dart';
import 'package:http/http.dart' as http;

import '../utils/info.dart';

class ProfileController {
  bool isLoading = false;
  ProfileModel? model;

  Future<void> load() async {
    isLoading = true;

    try {
      final uri = Uri.parse("http://$baseUrl/profile/stats?userId=${id.value}");
      final res = await http.get(uri, headers: headers);

      print(res.statusCode);
      print(res.body);

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        model = ProfileModel.fromJson(data['data']);
      }
    } catch (e) {
      print("error : $e");
    }
    isLoading = false;
  }
}
