import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';

class Validators {
  final validateEmail = StreamTransformer<String,String>.fromHandlers(
    handleData: (email,sink){
      if(email.contains('@')){
        sink.add(email);
      }else{
        sink.addError('Enter a Valid Email');
      }
    }
  );

  final validatePassword = StreamTransformer<String,String>.fromHandlers(
    handleData: (pass,sink){
      if(pass.length>3){
        sink.add(pass);
      }else{
        sink.addError('Must be atleast 4 characters');
      }
    }
  );
}