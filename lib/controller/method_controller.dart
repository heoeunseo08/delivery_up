import 'package:flutter/services.dart';

class MethodController {
  static const MethodChannel channel = MethodChannel('up');
}

Future<void> showMessage(String text) async {
  await MethodController.channel.invokeMethod("show", {'text': text});
}
