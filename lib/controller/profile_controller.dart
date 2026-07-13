import 'dart:convert';

import 'package:delivery_up/model/profile_model.dart';
import 'package:delivery_up/utils/info.dart';
import 'package:http/http.dart' as http;

class ProfileController {
  String?  error;
  bool isLoading = false;
  late ProfileModel profileModel;

  Future<void> load() async {
    isLoading = true;
    error = null;

    try{
      final uri = Uri.parse("$baseUrl/profile/stats?userId=${id.value}");
      final res = await http.get(uri,headers: {"Authorization":"Bearer $tkn"});

      print(res.statusCode);
      print(res.body);

      if(res.statusCode == 200){
        final data = jsonDecode(res.body);
        profileModel = ProfileModel.fromJson(data['data']);
      }
      else{
        print("object");
      }
    }catch(e){
      print("네크워크오류 : $e");
    }

    isLoading =  false;
  }
}