import 'dart:convert';

import 'package:delivery_up/model/store_detail_model.dart';
import 'package:delivery_up/model/store_list_model.dart';
import 'package:delivery_up/utils/info.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class StoreController {
  bool isListLoading = false;
  bool isDetailLoading = false;
  bool isHeartLoading = false;
  List<StoreListModel> storeListModel = [];
  StoreDetailModel? detailModel;

  List<int> hearts = [];

  bool isHeart(int id) => hearts.contains(id);

  String get sort => sortNotifier.value;
  List<String> category = [];
  String? keyword;

  final ValueNotifier<String> sortNotifier = ValueNotifier("DEFAULT");
  set sort(String value) => sortNotifier.value = value;

  Future<void> setHeart(int storeId) async {
    final index = storeListModel.indexWhere((element) => element.id == storeId);
    final current = storeListModel[index].favorite;

    isHeartLoading = true;

    try {
      final uri = Uri.parse("$baseUrl/stores/$storeId/favorite?userId=${id.value}");
      final res = current
          ? await http.delete(uri, headers: {"Authorization": "Bearer $tkn"})
          : await http.post(uri, headers: {"Authorization": "Bearer $tkn"});

      if (res.statusCode == 201 || res.statusCode == 200) {
        final data = jsonDecode(res.body)['data']['favorite'];

        storeListModel[index].favorite = data;
        if (detailModel!.id == storeId && detailModel != null)
          detailModel!.favorite = data;
      }
    } catch (e) {
      print("오류 : $e");
    }

    isHeartLoading = false;
  }

  Future<void> loadList() async {
    isListLoading = true;

    try {
      final param = {
        'sort': sort,
        if (category.isNotEmpty) 'categories': category.join(','),
        if (keyword != null && keyword!.isNotEmpty) 'keyword': keyword,
        'userId': "${id.value}",
      };

      final uri = Uri.parse("$baseUrl/stores").replace(queryParameters: param);
      final res = await http.get(
        uri,
        headers: {"Authorization": "Bearer $tkn"},
      );

      print("$uri");
      print(res.statusCode);
      print(res.body);

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        storeListModel = (data['data'] as List)
            .map((e) => StoreListModel.fromJson(e))
            .toList();
      }
    } catch (e) {
      print("네트워크 오류: $e");
    }
    isListLoading = false;
  }

  Future<void> loadDetail(int storeId) async {
    isDetailLoading = true;

    try {
      final uri = Uri.parse("$baseUrl/stores/$storeId?userId=${id.value}");
    } catch (e) {
      print("오류 : $e");
    }

    isDetailLoading = false;
  }
}
