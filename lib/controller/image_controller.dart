import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ImageController {
  String? path;

  Future<void> load() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/profile.jpg');
    if(await file.exists()) path = file.path;
  }

  Future<void> pick(ImageSource source) async {
    try{
      final picked = await ImagePicker().pickImage(source: source);
      if(picked == null) return;

      final dir = await getApplicationDocumentsDirectory();
      final save = await File(picked.path).copy('${dir.path}/profile.jpg');
      path = save.path;
    }catch(e){
      print("error : $e");
    }
  }

  Future<void> remove() async {
    if(path == null)return;
    await File(path!).delete();
    path = null;
  }
}