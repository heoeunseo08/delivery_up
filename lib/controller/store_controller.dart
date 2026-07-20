import 'dart:convert';

import 'package:delivery_up_test4/model/store_detail_model.dart';
import 'package:delivery_up_test4/model/store_list_model.dart';
import 'package:delivery_up_test4/utils/info.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class StoreController {
  bool isListLoading = false;
  bool isDetailLoading = false;
  bool isHeartLoading = false;

  List<StoreListModel> storeListModels = [];
  StoreDetailModel? storeDetailModel;

  List<int> heart = [];

  bool isHeart(int id) => heart.contains(id);

  ValueNotifier<String> sortNotifier = ValueNotifier("DEFAULT");

  String get sort => sortNotifier.value;
  List<String> category = [];
  String? keyword;

  set sort(String value) => sortNotifier.value = value;

  Future<void> setHeart(int storeId) async {
    final index = storeListModels.indexWhere(
      (element) => element.id == storeId,
    );
    final current = storeListModels[index].favorite;
    isHeartLoading = true;
    try {
      final uri = Uri.parse(
        "http://$baseUrl/stores/$storeId/favorite?userId=${id.value}",
      );
      final res = current
          ? await http.delete(uri, headers: headers)
          : await http.post(uri, headers: headers);

      print(res.statusCode);
      print(res.body);

      if (res.statusCode == 200 || res.statusCode == 201) {
        final data = jsonDecode(res.body)['data']['favorite'];
        storeListModels[index].favorite = data;
      }
    } catch (e) {
      print("error : $e");
    }
    isHeartLoading = false;
  }

  Future<void> loadListStore() async {
    isListLoading = true;

    try {
      final param = {
        "sort": sort,
        if (category.isNotEmpty) "categories": category.join(','),
        if (keyword != null && keyword!.isNotEmpty) "keyword": keyword,
        "userId": "${id.value}",
      };

      final uri = Uri.parse(
        "http://$baseUrl/stores",
      ).replace(queryParameters: param);
      final res = await http.get(uri, headers: headers);

      print(res.statusCode);
      print(res.body);

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        storeListModels = (data['data'] as List)
            .map((e) => StoreListModel.fromJson(e))
            .toList();
      }
    } catch (e) {
      print("error: $e");
    }
    isListLoading = false;
  }

  Future<void> loadDetailStore(int storeId) async {

    isDetailLoading = true;

    try {
      final uri = Uri.parse("http://$baseUrl/stores/$storeId?userId=${id.value}");
      final res = await http.get(uri, headers: headers);

      print(res.statusCode);
      print(res.body);

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        storeDetailModel = StoreDetailModel.fromJson(data['data']);
      }
    } catch (e) {
      print("error : $e");
    }
    isDetailLoading = false;
  }
}
