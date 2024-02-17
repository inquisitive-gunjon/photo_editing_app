

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:photo_editing_app/view/image_edit_page.dart';

class PhotoEditorViewModel extends ChangeNotifier{

  List<File> images = [];
  int currentIndex = 0;

  void setCurrentIndex(int index){
    currentIndex=index;
    notifyListeners();
  }

  Future<void> pickImages() async {
    List<XFile>? pickedImages = await ImagePicker().pickMultiImage(
      imageQuality: 50,
    );

    if (pickedImages != null && pickedImages.isNotEmpty) {
        images = pickedImages.map((image) => File(image.path)).toList();
        currentIndex = 0;
    }
    notifyListeners();
  }

  Future<void> editImage(BuildContext context) async {
    if (images.isEmpty) {
      return;
    }

    File editedImage = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ImageEditPage(images[currentIndex]),
      ),
    );

    if (editedImage != null) {
        images[currentIndex] = editedImage;
    }
  }

}