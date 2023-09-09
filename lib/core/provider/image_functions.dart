import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class StudentImage with ChangeNotifier {
  String? imgPath;

  Future<void> getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }
    final selectedImage = File(image.path); 
    imgPath = selectedImage.path;
    notifyListeners();
  }

  
}
