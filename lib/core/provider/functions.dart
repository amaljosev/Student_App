import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProviderFunctions with ChangeNotifier {
  Future<File?> getImage() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) {
      return null;
    }
    return File(returnImage.path);
  }

  File? _selectedImage;

  File? get selectedImage => _selectedImage;

  void setImage(File? image) {
    _selectedImage = image;
    notifyListeners();
  }
}
