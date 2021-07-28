import 'dart:convert';
import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import '../api/FirebaseMlApi.dart';

import '../block/bloc.dart';

class AdminLogin extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
   return AdminLoginState();
  }
}

class AdminLoginState extends State<AdminLogin>{
  bool isTrue = false;
  File image;
  String text = '';
  void pressed() async{
    print('yep');
  }
// can be made .camera to read from camera when not using an emulator.
  Future buildImage() async{
    final file = await ImagePicker().getImage(source: ImageSource.gallery);
    setImage(File(file.path));
    scanText();
  }

  void setImage(File newImage){
    setState(() {
      image = newImage;
    });
  }

  void setText(String newText){
    setState((){
      text=newText;
      isTrue = true;
    });
  }

  void scanText() async{
    final text = await FirebaseMLApi.recogniseText(image);
    setText(text);
  }
  Widget build(BuildContext context){
    return StreamBuilder<Object>(
      stream: bloc.colorMode,
      builder: (context, snapshot) {
        return imageSelector();
      }
    );
  }


// widget to choose image
  Widget imageSelector(){
    return Container(
          color: bloc.currentColor()?Colors.black:Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children:[Column(
                   children:[RaisedButton(
                     
              color: bloc.currentColor()?Colors.lightBlue:Colors.brown,
              onPressed: buildImage,
              child: Text('select Image',style: TextStyle(color: bloc.currentColor()?Colors.white:Colors.black),),
            )],
              ),
            image!=null?Image.file(image):Icon(Icons.photo,size: 80,color: Colors.blue,), 
            Text(text,style: TextStyle(color:bloc.currentColor()?Colors.lightBlue:Colors.black),),
            // child: Text('A new Page'),
              ],
            ),
          ));
  }
}