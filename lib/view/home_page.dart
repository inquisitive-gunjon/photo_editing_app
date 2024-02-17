

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_editing_app/view_model/photo_editor_view_model.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:image/image.dart' as img;
import 'package:provider/provider.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // List<File> images = [];
  // int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<PhotoEditorViewModel>(
      builder: (context,photoEditorViewModel,child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Photo Editing App'),
            actions: [
              IconButton(
                icon: Icon(Icons.photo),
                onPressed: photoEditorViewModel.pickImages,
              ),
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: ()=>photoEditorViewModel.editImage(context),
              ),
            ],
          ),
          body: photoEditorViewModel.images.isEmpty
              ? Center(
            child: Text('No images selected'),
          )
              : PhotoViewGallery.builder(
            itemCount: photoEditorViewModel.images.length,
            builder: (context, index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: FileImage(photoEditorViewModel.images[index]),
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered * 2,
              );
            },
            onPageChanged: (index) {
              photoEditorViewModel.setCurrentIndex(index);
            },
            scrollPhysics: BouncingScrollPhysics(),
            backgroundDecoration: BoxDecoration(
              color: Colors.black,
            ),
          ),
        );
      }
    );
  }


}
