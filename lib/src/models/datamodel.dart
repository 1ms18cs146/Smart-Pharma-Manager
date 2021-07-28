class DataModel {
  String id;
  String name;
  String desc;
  int price;
  String url;
  bool isAdded;

  DataModel(Map<String,dynamic> parsed){
    id = parsed['_id'];
    name = parsed['name'];
    desc = parsed['desc'];
    price = parsed['price'];
    url = parsed['url'] + '.jpg';
    isAdded = parsed['isAdded'];
  }
}