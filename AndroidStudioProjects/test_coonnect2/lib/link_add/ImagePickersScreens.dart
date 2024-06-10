import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerScreen extends StatefulWidget {
  @override
  _ImagePickerScreenState createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  XFile? imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (imageFile != null) ...[
              Image.file(
                File(imageFile!.path),
                width: 200,
                height: 200,
              ),
              SizedBox(height: 20),
            ],
            ElevatedButton(
              onPressed: () async {
                imageFile = await ImagePicker().pickImage(source: ImageSource.gallery);

                if (imageFile != null) {
                  // Do something with the selected image.
                }

                setState(() {});
              },
              child: Text('Pick Image'),
            ),
          ],
        ),
      ),
    );
  }
}
