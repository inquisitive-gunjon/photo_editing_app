

import 'dart:io';
import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class ImageEditPage extends StatefulWidget {
  final File imageFile;

  ImageEditPage(this.imageFile);

  @override
  _ImageEditPageState createState() => _ImageEditPageState();
}

class _ImageEditPageState extends State<ImageEditPage> {
  img.Image? _editedImage;
  late img.Image _originalImage;
  double _rotationAngle = 0.0; // New variable to store rotation angle

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> _loadImage() async {
    List<int> bytes = await widget.imageFile.readAsBytes();
    _originalImage = img.decodeImage(Uint8List.fromList(bytes))!;
    _editedImage = img.copyRotate(_originalImage,angle: _rotationAngle);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Image'),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () => _saveImage(),
          ),
        ],
      ),
      body: _editedImage == null
          ? Center(
        child: CircularProgressIndicator(),
      )
          : Column(
        children: [
          Expanded(
            child: InteractiveViewer(
              child: Image.memory(Uint8List.fromList(img.encodeJpg(_editedImage!))),
            ),
          ),
          Slider(
            value: _rotationAngle,
            min: 0,
            max: 360,
            onChanged: (value) {
              setState(() {
                _rotationAngle = value;
                _editedImage = img.copyRotate(_originalImage,angle: value);
              });
            },
          ),
        ],
      ),
    );
  }

  Future<void> _saveImage() async {
    if (_editedImage != null) {
      File savedImage = await _writeImageToFile(_editedImage!);
      Navigator.of(context).pop(savedImage);
    }
  }

  Future<File> _writeImageToFile(img.Image image) async {
    List<int> pngBytes = img.encodePng(image);
    File savedFile = File('${(await getTemporaryDirectory()).path}/edited_image.png');
    await savedFile.writeAsBytes(pngBytes);
    return savedFile;
  }
}