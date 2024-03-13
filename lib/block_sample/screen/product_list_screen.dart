import 'package:flutter/material.dart';
import 'package:start_flutter/block_sample/blocs/cart_bloc.dart';
import 'package:start_flutter/block_sample/blocs/product_bloc.dart';
import 'package:start_flutter/block_sample/models/cart.dart';
import 'package:start_flutter/block_sample/models/product.dart';

class ProductListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Alışveriş"),
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(
              onPressed: () => {Navigator.pushNamed(context, "/cart")},
              icon: Icon(Icons.shopping_cart))
        ],
      ),
      body: buildProductList(),
    );
  }

  buildProductList() {
    return StreamBuilder(
      initialData: productBloc.getAll(),
      stream: productBloc.getStream,
      builder: (context, snapshot) {
        return snapshot.data.length > 0 ? buildProductListItem(snapshot) : Center(child: Text("Data yok"));
      },
    );
  }

  buildProductListItem(AsyncSnapshot snapshot) {
    return ListView.builder(
      itemCount: snapshot.data.length,
      itemBuilder: (BuildContext context, index) {
        final list = snapshot.data;
        return ListTile(
          title: Text(list[index].name),
          subtitle: Text(list[index].price.toString()),
          trailing: IconButton(
            icon: Icon(Icons.add_shopping_cart),
            onPressed: () {
              cartBloc.addToCart(Cart(list[index], 1));
            },
          ),
        );
      },
    );
  }

}
