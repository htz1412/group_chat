import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImagePicker extends StatefulWidget {
  final Function pickImageFn;

  const ProfileImagePicker(this.pickImageFn);

  @override
  _ProfileImagePickerState createState() => _ProfileImagePickerState();
}

class _ProfileImagePickerState extends State<ProfileImagePicker> {
  File _pickedImage;

  void _pickImage() async {
    final _pickedImageFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );

    setState(() {
      _pickedImage = File(_pickedImageFile.path);
    });

    widget.pickImageFn(_pickedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey[300],
          backgroundImage:
              _pickedImage == null ? null : FileImage(_pickedImage),
        ),
        TextButton.icon(
          onPressed: _pickImage,
          style: TextButton.styleFrom(primary: Theme.of(context).accentColor),
          icon: Icon(
            Icons.add_a_photo_outlined,
            size: 18,
          ),
          label: Text('Add Photo'),
        ),
      ],
    );
  }
}
