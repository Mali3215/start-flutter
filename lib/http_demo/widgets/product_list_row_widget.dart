import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:start_flutter/http_demo/models/product.dart';

class ProductListRowWidget extends StatelessWidget{
  Product product;

  ProductListRowWidget(this.product);

  @override
  Widget build(BuildContext context) {
   return buildProductItemCard(context);
  }

  Widget buildProductItemCard(BuildContext context) {
    return InkWell(
      child: Card(
        child: Column(
          children: [
            Container(
              child: Image.network( "https://cdn.pixabay.com/photo/2024/02/25/10/11/forsythia-8595521_1280.jpg"),
              height: 110,
              width: MediaQuery.of(context).size.width/2,
            ),
            SizedBox(height: 10),
            Text(product.productName,textAlign: TextAlign.center),
            Text(product.unitPrice.toString()  + " TL" ,textAlign: TextAlign.center,style: TextStyle(fontSize: 15),)

          ],
        ) ,
      ),
    );
  }



}