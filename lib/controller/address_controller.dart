import 'dart:convert';

import 'package:delivery_up/model/address_model.dart';
import 'package:delivery_up/utils/info.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class AddressController {
  bool isLoading = false;
  bool isAddLoading = false;
  List<AddressModel> models = [];
  List<String> addressCode = ["HOME", "COMPANY", "ETC"];
  List<String> addressLabels = ["집", "회사", "기타"];

  ValueNotifier<String> address = ValueNotifier("");
  ValueNotifier<String> addressDetail = ValueNotifier("");
  ValueNotifier<String> label = ValueNotifier("");

  Future<void> loadAddress() async {
    isLoading = true;

    try {
      final uri = Uri.parse("$baseUrl/addresses?userId=${id.value}");
      final res = await http.get(
        uri,
        headers: {"Authorization": "Bearer $tkn"},
      );
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

  Future<void> addAddress({
    required String addressText,
    required String addressDetailText,
    required String labelText,
  }) async {
    isLoading = true;

    try {
      final uri = Uri.parse("$baseUrl/addresses?userId=${id.value}");
      final res = await http.post(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $tkn",
        },
        body: jsonEncode({
          "address": addressText,
          "addressDetail": addressDetailText,
          "label": labelText,
        }),
      );

      print(res.statusCode);
      print(res.body);

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        address.value = data['data']['address'];
        addressDetail.value = data['data']['addressDetail'];
        label.value = data['data']['label'];
      }
    } catch (e) {
      print("error: $e");
    }
    isLoading = false;
  }

  void removeAddress(int addressId)=> models.removeWhere((element) => element.id == addressId);

   void setDefault(int addressId) {
     models = models.map((e) {
       if(e.id == addressId){
         return AddressModel(id: id, label: label, address: address, addressDetail: addressDetail, isDefault: isDefault)
       }
     },).toList();
   }
}
