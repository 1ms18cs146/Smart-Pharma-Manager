import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:pharma/src/block/bloc.dart';

class Home extends StatelessWidget{

  Widget build(BuildContext context){
    return StreamBuilder(
      stream: bloc.nav,
      builder: (context, snapshot) {
        return bloc.chooseWidget();
      },

    );
  }  
}