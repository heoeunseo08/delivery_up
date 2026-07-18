import 'dart:convert';

import 'package:delivery_up/controller/cart_controller.dart';
import 'package:delivery_up/model/order_model.dart';
import 'package:http/http.dart' as http;

import '../utils/info.dart';

class OrderController {
  String? error;
  bool isLoading = false;
  List<OrderModel> ordersList = [];

  Future<bool> order(int addressId) async {
    try {
      final uri = Uri.parse("$baseUrl/orders?userId=${id.value}");
      final res = await http.post(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $tkn",
        },
        body: jsonEncode({
          "storeId": cartController.storeId,
          "addressId": addressId,
          "items": cartController.items
              .map(
                (e) => {
                  "menuId": e.menuId,
                  "optionIds": e.optionIds,
                  "quantity": e.quantity,
                },
              )
              .toList(),
        }),
      );

      print(res.statusCode);
      print(res.body);

      return res.statusCode == 201;
    } catch (e) {
      print("error : $e");
      return false;
    }
  }

  Future<void> getOrderList() async {
    isLoading = true;
    try {
      final uri = Uri.parse("$baseUrl/orders?userId=${id.value}");
      final res = await http.get(
        uri,
        headers: {"Authorization": "Bearer $tkn"},
      );

      print(res.statusCode);
      print(res.body);

      if(res.statusCode == 200){
        final data = jsonDecode(res.body);
        ordersList = (data['data']as List).map((e) => OrderModel.fromJson(e)).toList();
      }
    } catch (e) {
      print("error : $e");
    }
    isLoading = false;
  }
}
