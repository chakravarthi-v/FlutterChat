import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  UserImagePicker(this.imagePickFn);
  final void Function(File image) imagePickFn;
  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _pickImageFile;
  void _pickImage() async{
    final picker=ImagePicker();
    final picked=await picker.getImage(
        source:ImageSource.camera,
        imageQuality:50,
    maxWidth: 150,);
    final pickedImage=File(picked.path);
    setState(() {
      _pickImageFile=pickedImage;
    });
    widget.imagePickFn(_pickImageFile);
  }
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CircleAvatar(radius: 50,backgroundColor:Colors.grey,
        backgroundImage:_pickImageFile!=null?FileImage(_pickImageFile):null,),
      FlatButton.icon(textColor:Theme.of(context).primaryColor,onPressed:_pickImage,
          icon:Icon(Icons.image),label:Text('Add image')),
    ],);
  }
}
