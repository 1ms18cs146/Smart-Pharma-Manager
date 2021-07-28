import 'package:flutter/material.dart';
import 'package:pharma/src/models/datamodel.dart';

import '../block/bloc.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context)
  {
    if(bloc.returnData()!=null){
       setState(() {
         if(!bloc.arr.contains(bloc.returnData()))
          bloc.arr.add(bloc.returnData());
    });
    }
    return StreamBuilder(
      stream: bloc.dataAndColorStream,
      builder: (context, snapshot) {
        return Container(
          color: bloc.currentColor()?Colors.black:Colors.white,
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Text("Your Cart",style: TextStyle(fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w100,fontSize: 28.0,
              color: bloc.currentColor()?Color.fromRGBO(211, 255, 21,1):Colors.blue[300],
              )),
              Container(
      child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: bloc.arr.length,
              itemBuilder: (BuildContext context, int index) {
                return buildData(bloc.arr[index]);
              },
      ),
    ),
            ],
          ),
        );
      },
    );
  }

  Widget buildData(DataModel instance){

    return Column(
      children: [
        Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
        child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: Container(
          padding: EdgeInsets.only(right: 12.0),
          decoration: new BoxDecoration(
              border: new Border(
                  right: new BorderSide(width: 1.0, color: Colors.white24))),
          child: Icon(Icons.autorenew, color: Colors.white),
        ),
        title: Text(
          instance.name,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

        subtitle: Row(
          children: <Widget>[
            Icon(Icons.linear_scale, color: Colors.yellowAccent),
            Text("dssf", style: TextStyle(color: Colors.white))
          ],
        ),
        trailing:
            Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0)),
      ),
    ),
      ],
    );
  }
}