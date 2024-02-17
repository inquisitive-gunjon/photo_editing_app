

import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_editing_app/view/collage_page_two.dart';
import 'package:photo_editing_app/view_model/photo_editor_view_model.dart';
import 'package:provider/provider.dart';

class CollagePageOne extends StatefulWidget {
  CollagePageOne({Key? key}) : super(key: key);

  @override
  _CollagePageOneState createState() => _CollagePageOneState();
}

class _CollagePageOneState extends State<CollagePageOne> {
  List<String> imagePaths = [
    'asset/images/aurora-gedce14a47_1920.jpg',
    'asset/images/avenue-g332954b27_1920.jpg',
    'asset/images/lake-g182d96213_1280.jpg',
    'asset/images/aurora-gf2f50c4c8_1920.jpg',
    'asset/images/bird-g7bf4243e0_1920.jpg'
  ];

  Set<File> selectedImages = new HashSet<File>();

  String getSelectedImagesText() {
    StringBuffer text = new StringBuffer();

    text.write(selectedImages.length.toString());
    text.write(" Image");
    if (selectedImages.length > 1) {
      text.write("s");
    }
    text.write(" selected");
    return text.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PhotoEditorViewModel>(
      builder: (context,photoEditorViewModel,child) {
        return Scaffold(
          appBar: AppBar(
            leading: selectedImages.isNotEmpty
                ? IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                setState(() {
                  selectedImages.clear();
                });
              },
            )
                : Container(),
            title: Text(selectedImages.isNotEmpty
                ? getSelectedImagesText()
                : "Select Image for Collage"),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Flexible(
                  child: GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      childAspectRatio: 1.5,
                      padding: const EdgeInsets.all(4.0),
                      mainAxisSpacing: 2.0,
                      crossAxisSpacing: 2.0,
                      children: photoEditorViewModel.images.map((File url) {
                        return getGridItem(url);
                      }).toList())),
              Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                  child: const Text("Make Collage"),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CollageScreenTwo(
                          imagePaths: selectedImages.toList(),
                        )));
                  },
                ),
              )
            ],
          ),
        );
      }
    );
  }

  Widget getGridItem(File url) {
    return GridTile(
        child: InkWell(
            onTap: () {
              setState(() {
                if (selectedImages.contains(url)) {
                  selectedImages.remove(url);
                } else {
                  selectedImages.add(url);
                }
              });
            },
            child: Stack(children: [
              // Image.file(url),
              Image.file(
                url,
                color: Colors.black.withOpacity(isSelected(url) ? 0.9 : 0),
                colorBlendMode: BlendMode.color,
              ),
              Visibility(
                  visible: isSelected(url),
                  child: const Align(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.check_circle,
                      color: Colors.white,
                      size: 40,
                    ),
                  ))
            ])));
  }

  bool isSelected(File url) {
    return selectedImages.contains(url);
  }
}