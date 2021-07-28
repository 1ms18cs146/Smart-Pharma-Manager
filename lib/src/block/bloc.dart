import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pharma/src/models/datamodel.dart';

import './validators.dart';
import 'package:rxdart/rxdart.dart';
import './navBloc.dart';

// nav screen import
import '../screens/adminlogin.dart';
import '../screens/analyse.dart';
import '../screens/products.dart';

class Bloc extends Validators with NavBloc{
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _navigationController = BehaviorSubject<int>();
  final _colorModeController = BehaviorSubject<bool>();
  final _dataModeController = BehaviorSubject<DataModel>();

  // colors and texts
  Color backgroundColor;
  Color textColor;
  Color forgroundColor;
  List<DataModel> arr = [];
  bool isDisabled = false;

  
  // add data to stream
  Stream<String> get email => _emailController.stream.transform(validateEmail);
  Stream<String> get password => _passwordController.stream.transform(validatePassword);
  Stream<DataModel> get data => _dataModeController.stream.transform(getData);
  
  Stream<bool> get submitValid => Observable.combineLatest2(email, password,(e,p)=>true);
  Stream<int> get nav => _navigationController.stream.transform(clickPage); 
  Stream<bool> get colorMode => _colorModeController.stream.transform(changeColor);
  Stream<bool> get navColorMode => Observable.combineLatest2(nav, colorMode,(e,p)=>true);
  Stream<bool> get dataAndColorStream => Observable.combineLatest2(data, colorMode,(e,p)=>true);
  //change data

 Function(String) get changeEmail => _emailController.sink.add;
 Function(String)  get changePassword => _passwordController.sink.add;
 Function(int)  get changePage => _navigationController.sink.add;
 Function(bool)  get updateColor => _colorModeController.sink.add;
 Function(DataModel)  get updatedata => _dataModeController.sink.add;
 
 dispose(){
   _emailController.close();
   _passwordController.close();
   _navigationController.close();
   _colorModeController.close();
   _dataModeController.close();
 }

 Widget chooseWidget(){
   if(_navigationController.value == 1){
     return AdminLogin(); // this is the page o add image
   }else if(_navigationController.value == 2){
     return Cart(); // cart screen
   }else{
     return Products();
   }
 }
 submit(){
   final email = _emailController.value;
   final pass = _passwordController.value;

   print('email is $email and pass is $pass');
 }

 // current color
 bool currentColor(){
   if(_colorModeController.value == null){
     return false;
   }else{
     return _colorModeController.value;
   }
 }

 DataModel returnData(){
   return _dataModeController.value;
 }
}

final bloc = Bloc();