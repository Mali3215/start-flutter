import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:start_flutter/sqflite/data/dbHelper.dart';
import 'package:start_flutter/sqflite/screens/add_product.dart';
import 'package:start_flutter/sqflite/screens/product_detail.dart';

import '../models/product.dart';

class ProductList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ProductListState();
  }
}

class _ProductListState extends State{
  DBHelper dbHelper = DBHelper();
  List<Product> products = List.empty();
  int productCount = 0;

  @override
  void initState() {
    super.initState(); // Üst sınıfın initState metodunu çağır
    getProducts();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Ürün Listesi"),
        backgroundColor: Colors.blueAccent,
      ),
      body: buildProductList(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        child: Icon(Icons.add,color: Colors.white),
        onPressed: (){
          goToProductAdd();
        },
      ),
    );

  }

  ListView buildProductList() {
    return ListView.builder(itemCount: productCount,itemBuilder: (BuildContext context, int position){
       return Card(
         color: Colors.cyan,
         elevation: 2.0,
         child: ListTile(
           leading: CircleAvatar(backgroundColor: Colors.black12,child: Text("P")),
           title: Text(this.products[position].name),
           subtitle: Text(this.products[position].description),
           onTap: (){
              goToProductDetail(this.products[position]);
           },
         ),
       );
    });
  }

  void goToProductAdd() async{
    bool? result = await Navigator.push(context, MaterialPageRoute(builder: (context) => AddProduct()));
    if(result != null && result){
      getProducts();
    }
  }

  void getProducts() async {
    var productsFeature = dbHelper.getProducts();
    productsFeature.then((data) {
      setState(() {
        this.products = data;
        this.productCount = data.length;
      });
    });
  }


  void goToProductDetail(Product product) async {
    bool? result = await Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetail(product)));

    if(result != null && result){
      getProducts();
    }
  }


}