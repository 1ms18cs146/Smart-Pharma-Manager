import 'package:flutter/material.dart';


import './screens/home.dart';
import './navigation.dart';

class App extends StatelessWidget{

  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Home Page',
      home: Scaffold(
        body: Home(),
        bottomNavigationBar: Navigation(), 
    )
    );
  }
}