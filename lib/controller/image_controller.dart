import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImageController {
  String? imagePath;

  Future<void> load() async {
    final pref = await SharedPreferences.getInstance();
    final path = pref.getString("image");
    if (path != null && File(path).existsSync()) {
      imagePath = path;
    }
  }

  Future<void> pick(ImageSource source) async {
    final picked = await ImagePicker().pickImage(source: source);
    if(picked == null)return;
    final dir = await getApplicationDocumentsDirectory();
    final fileName = 'profile_${DateTime.now().microsecondsSinceEpoch}.png';
    final target = '${dir.path}/$fileName';

    await File(picked.path).copy(target);

    await clear();

    imagePath = target;

    final pref = await SharedPreferences.getInstance();
    await  pref.setString("image", imagePath!);
   }

  Future<void> remove() async {
    await clear();
    imagePath = null;
    final prefs = await
    SharedPreferences.getInstance();
    await prefs.remove("image");
  }

  Future<void> clear() async {
    if(imagePath == null) return;
    final file = File(imagePath!);
    if(await file.exists()){
      await file.delete();
    }
  }
}
