import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:pharma/src/models/datamodel.dart';

// bloc import
import '../block/bloc.dart';

class Products extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProductState();
  }
}

class ProductState extends State<Products>{
  List<DataModel> elements = [];   // empty list initilisation to store data which we will fetch from localhost
  Future<dynamic> part =  get('http://10.0.2.2:3000/data/getData');
  List<bool> checkBool = [];
  String st = '';
  int x = 0;

     Widget build(BuildContext context){
      // fetchData();
    return FutureBuilder(
      future: part,
      builder: (context,sn){
        List<Widget> children;
        if(sn.hasData){
          children = <Widget>[
            flipSwitch(),
            Expanded(child:
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: formatData(json.decode(sn.data.body))
                ),
            ),
            ];
        }else {
            children = <Widget>[
              SizedBox(
                child: CircularProgressIndicator(),
                width: 60,
                height: 60,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Awaiting result...'),
              )
            ];
            }

            return  StreamBuilder( 
      stream: bloc.colorMode,
      builder: (context,snap){
        bloc.backgroundColor =  bloc.currentColor()?Colors.black:Colors.white;
        bloc.textColor =  bloc.currentColor()?Colors.white:Colors.black;
        return  streamComponent(children);
      }
    );
      },
    );
  }

  Widget streamComponent(List<Widget> children){
    return SizedBox.expand(
      child: Container(
        color: bloc.backgroundColor,
      child: Container(
        color: bloc.backgroundColor,
       // decoration: BoxDecoration(border: Border.all(color: Colors.grey[300])),
        padding: EdgeInsets.all(20.0),
        margin: EdgeInsets.all(20.0),
        child: Column(
          children: children,
        )
      ),
      // child: Text('A new Page'),
    )
    );
  }

  void invertColor(val){
    bloc.updateColor(val);
  }

  Widget flipSwitch(){
    return StreamBuilder(
      stream: bloc.colorMode,
      builder: (context, snapshot){
        return Row(
              children: <Widget>[
                Text('Flip the colors!?',
                style: TextStyle(color: bloc.textColor),
                ),
                Switch(
                  value: snapshot.hasData?snapshot.data:false,
                   onChanged: invertColor,
                   activeColor: Color.fromRGBO(211, 255, 21,1),
                   ),
              ],
            );
      },    
    ); 
  }

  Widget formatData(List<dynamic> jsonArr){
    for(int i=0;i<jsonArr.length;i++){
     elements.add(DataModel(jsonArr[i])); 
    }
    if(checkBool.length==0){
      checkBool.length = elements.length;
    checkBool.fillRange(0,elements.length,false);
    }
    return StreamBuilder(
      stream: bloc.colorMode,
      builder: (context,snap){
        return ListView.builder(
      itemCount:elements.length,
      itemBuilder: (context,int position) {
         print(position);
       return buildComponent(elements[position],position);
      },
    );
      },
    );
  }


// for each medicine framework
  Widget buildComponent(DataModel instanceOfData,int position){
   if(position>=5){
     return Container();
   }
    return Container(
   //   color:  ,
     decoration: BoxDecoration(border: Border.all(color:bloc.backgroundColor)),
     padding: EdgeInsets.all(10.0),
     margin: EdgeInsets.all(20.0),
      child: Column(
        children: productList(instanceOfData,position),
                ),
               );
             }
            
           
             void addToCart(DataModel instance,int position) async{
             // print(checkBool[position]);
               bloc.updatedata(instance);
              setState(() {
                checkBool[position] = true;
              });
                    await post('http://10.0.2.2:3000/data/addCart',headers: {'Content-type' : 'application/json'},body: jsonEncode({'id':instance.id}));
                   // .then((value) => print(json.decode(value)))
                   // .catchError((onError)=>print(onError));
              // });
             }




  List<Widget> productList(instanceOfData,position){
    return [
        //  Image(image: AssetImage(instanceOfData.url)),
         

             Padding(
                 padding: EdgeInsets.only(top: 5.0,bottom: 8.0),
                 child: Text(instanceOfData.name,style: TextStyle(color: bloc.currentColor()?Colors.white:Colors.blue,fontSize: 30.0),),
               ),
        Text('Description',style: TextStyle(color: bloc.currentColor()?Colors.white:Colors.blue),),
         Padding(
             padding: EdgeInsets.only(top: 5.0),
             child: Text(instanceOfData.desc,style: TextStyle(color: bloc.currentColor()?Colors.white:Colors.blue),),
           ),
           Text('Image',style: TextStyle(color: bloc.currentColor()?Colors.white:Colors.blue),),
         Padding(
             padding: EdgeInsets.only(top: 5.0),
             child: Image(image: AssetImage(instanceOfData.url),)
           ),
                      RaisedButton(onPressed:(checkBool[position] || instanceOfData.isAdded)?null:()=>addToCart(instanceOfData,position),
                      child:(checkBool[position] || instanceOfData.isAdded)?Text('Added to cart'):Text('Add to cart'),           
                      color: bloc.currentColor()?Color.fromRGBO(211, 255, 21,1):Colors.lightBlue[200])
           
                  ];
  }         
}