import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ImageController {
  String? profilePath;
  String? reviewPath;

  Future<void> profileLoad() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/profile.jpg');
    if(await file.exists()) profilePath = file.path;
  }

  Future<void> profilePick(ImageSource source) async {
    try{
      final picked = await ImagePicker().pickImage(source: source);
      if(picked == null) return;

      final dir = await getApplicationDocumentsDirectory();
      final save = await File(picked.path).copy('${dir.path}/profile.jpg');
      profilePath = save.path;
    }catch(e){
      print("error : $e");
    }
  }

  Future<void> profileRemove() async {
    if(profilePath == null)return;
    await File(profilePath!).delete();
    profilePath = null;
  }


  Future<void> reviewLoad() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/review.jpg');
    if(await file.exists()) reviewPath = file.path;
  }

  Future<void> reviewPick(ImageSource source) async {
    try{
      final picked = await ImagePicker().pickImage(source: source);
      if(picked == null) return;

      final dir = await getApplicationDocumentsDirectory();
      final save = await File(picked.path).copy('${dir.path}/review.jpg');
      reviewPath = save.path;
    }catch(e){
      print("error : $e");
    }
  }

  Future<void> reviewRemove() async {
    if(reviewPath == null)return;
    await File(reviewPath!).delete();
    reviewPath = null;
  }
}