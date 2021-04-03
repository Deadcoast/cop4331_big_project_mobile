
import 'dart:io';

import 'package:brownie_points/config/Config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class ImageForm extends StatefulWidget {
  @override
  ImageFormState createState() => ImageFormState();
}

class ImageFormState extends State<ImageForm> {

  static final formKey = formKeys[1];
  static File image;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children:<Widget>[
        ImageSubmit(),
      ],
    );
  }

}


class ImageSubmit extends StatefulWidget {
  @override
  _ImageSubmitState createState() => _ImageSubmitState();
}

class _ImageSubmitState extends State<ImageSubmit> {

  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(16),
            height: 100,
            width: MediaQuery.of(context).size.width / 2,
            color:Colors.deepPurple,
            child: ImageFormState.image == null
                  ? Icon(Icons.add_photo_alternate)
                  : Image.file(ImageFormState.image, height: MediaQuery.of(context).size.height, width: MediaQuery.of(context).size.width),
          ),
        ),
        ButtonBar(
          alignment: MainAxisAlignment.center,
          buttonMinWidth: (MediaQuery.of(context).size.width)/4,
          children: [
            ElevatedButton(
              onPressed: (){
                getImage(ImageSource.camera);
                setState(() {});
                },
              child: Center(child:Icon(Icons.add_a_photo_outlined)),
            ),
            ElevatedButton(
              child: Center(child:Icon(Icons.add_photo_alternate)),
              onPressed: (){
                getImage(ImageSource.gallery);
                setState(() {});
              },
            ),
            ElevatedButton(
              child: Center(child:Icon(Icons.remove_circle_outline)),
              onPressed: (){
                ImageFormState.image = null;
                setState(() {});
              },
            )
          ]
        ),
      ]
    );
  }

  Future getImage(ImageSource src) async {
    print("Pick image!");
    final pickedFile = await picker.getImage(source: src);

    setState(() {
      if (pickedFile != null) {
        ImageFormState.image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

}