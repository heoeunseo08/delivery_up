import 'dart:convert';

import 'package:delivery_up_test4/model/address_model.dart';
import 'package:delivery_up_test4/utils/info.dart';
import 'package:http/http.dart' as http;

class AddressController {
  bool isLoading = false;
  List<AddressModel> models = [];

  List<String> labelTexts = ["집", "회사", "기타"];
  List<String> labelCodes = ["HOME", "COMPANY", "ETC"];

  String address = "";
  String addressDetail = "";
  String label = "";

  Future<void> loadAddress() async {
    isLoading = true;
    try {
      final uri = Uri.parse("http://${baseUrl}/addresses?userId=${id.value}");
      final res = await http.get(uri, headers: headers);

      print(res.statusCode);
      print(res.body);

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        models = (data['data'] as List)
            .map((e) => AddressModel.fromJson(e))
            .toList();
      }
    } catch (e) {
      print("error : $e");
    }
    isLoading = false;
  }

  Future<void> add({
    required String addressText,
    required String addressDetailText,
    required String labelText,
  }) async {
    try {
      final uri = Uri.parse("http://$baseUrl/addresses?userId=${id.value}");
      final res = await http.post(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${token}",
        },
        body: jsonEncode({
          "address": addressText,
          "addressDetail":addressDetailText,
          "label": labelText,
        }),
      );

      print(res.statusCode);
      print(res.body);

      if(res.statusCode == 201){
        final data  = jsonDecode(res.body);
        address = data['data']['address'];
        addressDetail = data['data']['addressDetail'];
        label = data['data']['label'];
      }
    } catch (e) {
      print("error : $e");
    }
  }

  Future<void> remove(int addressId) async => models.removeWhere((element) => element.id == addressId);

  Future<void> setDefault(int addressId) async {
    for(final i in models){
      i.isDefault = i.id == addressId;
    }
  }
}
