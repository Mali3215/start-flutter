import 'package:flutter/material.dart';
import '../data/dbHelper.dart';
import '../models/product.dart';

class AddProduct extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddProductState();
  }
}

class _AddProductState extends State{
  DBHelper dbHelper = DBHelper();
  var txtNameController = TextEditingController();
  var txtDescriptionController = TextEditingController();
  var txtUnitPriceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Ürün Ekle"),
          backgroundColor: Colors.blueAccent,
        ),
        body: Padding(
          padding: EdgeInsets.all(30.0),
          child: Column(
            children: [
              buildFirstNameField(),
              buildLastNameField(),
              buildGradeField(),
              buildSaveButton()
            ],
          ),
        )
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

  buildSaveButton() {
    return MaterialButton( child: Text("Ekle"),
      color: Colors.greenAccent,
      onPressed: () {
        addProduct();
      });
  }
  void addProduct() async {
    try {
        await dbHelper.addProduct(Product(
        txtNameController.text,
        txtDescriptionController.text,
        (double.tryParse(txtUnitPriceController.text) ?? 0.0), // Hata ayıklama için null check ekledim
      ));
      print("Ürün eklendi");

      Navigator.pop(context, true);
    } catch (e) {
      print("Ürün eklenirken bir hata oluştu: $e");
    }
  }


}