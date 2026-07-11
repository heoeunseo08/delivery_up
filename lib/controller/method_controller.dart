import 'package:flutter/services.dart';

class MethodController {
  static const MethodChannel channel = MethodChannel("delivery_up");

  Future<void> showMessage(String text) async {
    await channel.invokeMethod("show_message", {'text': text});
  }
}
