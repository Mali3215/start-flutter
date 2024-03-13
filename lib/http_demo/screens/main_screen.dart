import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:start_flutter/http_demo/data/api/product_api.dart';
import 'package:start_flutter/http_demo/models/product.dart';
import 'package:start_flutter/http_demo/widgets/product_list_widget.dart';
import '../data/api/category_api.dart';
import '../models/category.dart';

class MainScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _MainScreenState();
  }
}

class _MainScreenState extends State {
  late List<Category> categories = [];
  late List<Widget> categoryWidgets = [];
  List<Product> products = [];

  @override
  void initState() {
    getCategoriesFromApi();
    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Alışveriş Sistemi", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: (categoryWidgets),
              ),
            ),
            ProductListWidget(products)
          ],
        ),
      ),
    );
  }

  void getCategoriesFromApi() {
    CategoryApi.getCategories().then((response){
      setState(() {
        Iterable list = json.decode(response.body);
        this.categories = list.map((category) => Category.fromJson(category)).toList();
        getCategoryWidgets();
      });
    });
  }

  List<Widget> getCategoryWidgets() {
    for(int i = 0; i < this.categories.length; i++){
      categoryWidgets.add(getCategoryWidget(categories[i]));
    }
    return categoryWidgets;
  }

  Widget getCategoryWidget(Category category) {
    return Padding(
      padding: EdgeInsets.only(left: 4,right: 4,bottom: 4,top: 4),
      child: MaterialButton(
        color: Colors.blueGrey,
        onPressed: () {
            getProductsByCategoryId(category.id);
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(color: Colors.lightGreenAccent)
        ),
        child: Text(category.categoryName, style: TextStyle(color: Colors.white)),
      ),
    );
  }

  void getProductsByCategoryId(int categoryId) {
    ProductApi.getProductsByCategoryId(categoryId).then((response){
      setState(() {
        Iterable list = json.decode(response.body);
        this.products = list.map((product) => Product.fromJson(product)).toList();

      });
    });
  }
  void getProducts() {
    ProductApi.getProducts().then((response){
      setState(() {
        Iterable list = json.decode(response.body);
        this.products = list.map((product) => Product.fromJson(product)).toList();

      });
    });
  }
}