import 'dart:convert';

import 'package:delivery_up_test4/controller/cart_controller.dart';
import 'package:delivery_up_test4/model/order_model.dart';
import 'package:delivery_up_test4/utils/info.dart';
import 'package:http/http.dart' as http;

class OrderController {
  bool isLoading = false;
  List<OrderModel> models = [];

  Future<bool> order(int addressId) async {
    try {
      final uri = Uri.parse("http://$baseUrl/orders?userId=${id.value}");
      final res = await http.post(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({
          "storeId": cartController.storeId,
          "addressId": addressId,
          "items": cartController.items
              .map(
                (e) => {
                  "menuId": e.menuId,
                  "optionIds": e.optionId,
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

  Future<void> loadOrderList() async {
    isLoading = true;

    try {
      final uri = Uri.parse("http://$baseUrl/orders?userId=${id.value}");
      final res = await http.get(uri, headers: headers);

      print(res.statusCode);
      print(res.body);

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        models = (data['data'] as List)
            .map((e) => OrderModel.fromJson(e))
            .toList();
      }
    } catch (e) {
      print("error : $e");
    }
    isLoading = false;
  }
}
