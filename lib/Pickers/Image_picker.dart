import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class Image_picker extends StatefulWidget {
  @override
  _Image_pickerState createState() => _Image_pickerState();
}

class _Image_pickerState extends State<Image_picker> {
  final ImagePicker _picker = ImagePicker();
  XFile? picked_image;
  void picked_Image() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      XFile imageFileGal = XFile(image.path);
      setState(() {
        picked_image = imageFileGal;
      });
      // final ref =
      //     FirebaseStorage.instance.ref().child('Users').child(mail + '.jpg');
      // await ref.putFile(File(picked_image!.path)).whenComplete;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundImage:
              picked_image != null ? FileImage(File(picked_image!.path)) : null,
          backgroundColor: Colors.grey,
          radius: 40,
        ),
        TextButton(
          onPressed: picked_Image,
          child: Row(
            children: [
              SizedBox(
                width: 110.0,
              ),
              Center(child: Icon(Icons.add_a_photo)),
              SizedBox(
                width: 10.0,
              ),
              Center(
                child: Text(
                  'Add Image',
                  style: TextStyle(color: Colors.blueAccent),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
