class Product {
  int id = -1;
  String name = "";
  String description = "";
  double unitPrice = 0.0;

  Product(this.name,this.description,this.unitPrice);

  Product.withoutId(this.id,this.name,this.description,this.unitPrice);

  Product.withoutInfo();

  Product.fromObject(Map<String, dynamic> obj) {
    this.id = obj["id"];
    this.name = obj["name"];
    this.description = obj["description"];
    this.unitPrice = obj["unitPrice"].toDouble(); // doğrudan double'a dönüştür
  }


  Map<String, dynamic> toMap(){
    var map = Map<String, dynamic>();
    map["name"] = name;
    map["description"] = description;
    map["unitPrice"] = unitPrice;

    if(id != -1){
      map["id"] = id;
    }
    return map;
  }
}
