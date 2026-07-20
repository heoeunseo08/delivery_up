import 'dart:convert';
import 'dart:io';

import 'package:delivery_up_test4/utils/info.dart';
import 'package:http/http.dart' as http;

class ReviewController {
  int? reviewId;

  Future<void> review({
    required int orderId,
    required int rating,
    required String content,
  }) async {
    try {
      final uri = Uri.parse("http://$baseUrl/reviews?userId=${id.value}");
      final res = await http.post(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({
          "orderId": orderId,
          "rating": rating,
          "content": content,
        }),
      );

      print(res.statusCode);
      print(res.body);

      if (res.statusCode == 201) {
        final data = jsonDecode(res.body);
        reviewId = data['data']["reviewId"];
      }
    } catch (e) {
      print("error : $e");
    }
  }

  Future<void> reviewImage(int reviewId, File image) async {
    try {
      final uri = Uri.parse(
        "http://$baseUrl/reviews/$reviewId/image?userId=${id.value}",
      );
      final send = http.MultipartRequest('POST', uri);
      send.headers['Authorization'] = 'Bearer $token';
      send.files.add(await http.MultipartFile.fromPath('image', image.path));

      final res = await http.Response.fromStream(await send.send());

      print(res.statusCode);
      print(res.body);
    } catch (e) {
      print("error : $e");
    }
  }
}
