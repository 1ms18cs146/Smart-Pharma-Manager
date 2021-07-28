import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import './block/bloc.dart';


class Navigation extends StatelessWidget{
  Widget build(BuildContext context){

    return StreamBuilder(
      stream: bloc.navColorMode,
      builder: (context,snapshot){
        return CurvedNavigationBar(
    backgroundColor: bloc.currentColor()?Colors.black:Colors.white,
    color: bloc.currentColor()?Color.fromRGBO(211, 255, 21,1):Colors.lightBlue[200],
    animationDuration:Duration(milliseconds: 620),
    items: <Widget>[
      Icon(Icons.add, size: 30),
      Icon(Icons.list, size: 30),
      Icon(Icons.compare_arrows, size: 30),
    ],
    onTap: (index) {
      //Handle button tap
      bloc.changePage(index);
    },
  );
      },
    );
  }
}