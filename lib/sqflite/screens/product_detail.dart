import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data/dbHelper.dart';
import '../models/product.dart';

class ProductDetail extends StatefulWidget{
  Product product;
  ProductDetail(this.product);


  @override
  State<StatefulWidget> createState() {
    return _ProductDetailState(product);
  }
}

enum Options{delete,update}

class _ProductDetailState extends State {
  DBHelper dbHelper = DBHelper();
  var txtNameController = TextEditingController();
  var txtDescriptionController = TextEditingController();
  var txtUnitPriceController = TextEditingController();
  Product product;
  _ProductDetailState(this.product);

  @override
  void initState() {
    txtNameController.text = product.name;
    txtDescriptionController.text = product.description;
    txtUnitPriceController.text = product.unitPrice.toString();
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Text("Ürün Detayı: ${product.name}"),
       backgroundColor: Colors.blueAccent,

       actions: [
         PopupMenuButton<Options>(
           onSelected: selectProcess,
           itemBuilder: (BuildContext context) => <PopupMenuEntry<Options>> [
             PopupMenuItem<Options>(
               value: Options.delete,
               child: Text("Sil"),
             ),
             PopupMenuItem<Options>(
               value: Options.update,
               child: Text("Güncelle"),
             )
           ],
         )
       ],
     ),
     body: buidProductDetail(),
   );
  }

  buidProductDetail() {
    return Padding(
      padding: EdgeInsets.all(30.0),
      child: Column(
        children: [
          buildFirstNameField(),
          buildLastNameField(),
          buildGradeField(),
        ],
      ),
    );
  }
  buildFirstNameField() {
    return TextField(
      decoration: InputDecoration(labelText: "Ürün Adı"),
      controller: txtNameController,

    );
  }

  buildLastNameField() {
    return TextField(
      decoration: InputDecoration(labelText: "Ürün Açıklaması"),
      controller: txtDescriptionController,
    );
  }

  buildGradeField() {
    return TextField(
      decoration: InputDecoration(labelText: "Ürün Fiyatı"),
      controller: txtUnitPriceController,
    );
  }
  void selectProcess(Options options) async {
    switch(options){
      case Options.delete:
        await dbHelper.deleteProduct(product.id);
        Navigator.pop(context,true);
        break;

      case Options.update:
        await dbHelper.updateProduct(Product.withoutId(product.id, txtNameController.text,
            txtDescriptionController.text,
            (double.tryParse(txtUnitPriceController.text) ?? 0.0)));
        Navigator.pop(context,true);
        break;

      default:
    }
  }
}