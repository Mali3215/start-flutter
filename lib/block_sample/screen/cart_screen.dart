import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:start_flutter/block_sample/blocs/cart_bloc.dart';

class CartScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sepet"),
        backgroundColor: Colors.blueGrey,
      ),
      body: StreamBuilder(
        stream: cartBloc.getStream,
        initialData: cartBloc.getAll(),
        builder: (context, snapshot) {
          return snapshot.data.length > 0 ? buildCartProductList(snapshot) : Center(child: Text("Sepet boş"));
        },
      ),
    );
  }

  buildCartProductList(AsyncSnapshot snapshot) {
    return ListView.builder(
        itemCount: snapshot.data.length,
        itemBuilder: (BuildContext context,index){
          final cart = snapshot.data;
          return ListTile(
            title: Text(cart[index].product.name),
            subtitle: Text(cart[index].product.price.toString()),
            trailing: IconButton(
              icon: Icon(Icons.remove_shopping_cart),
              onPressed: (){
                cartBloc.removeFromCart(cart[index]);
              },
            ),
          );
        });
  }


}