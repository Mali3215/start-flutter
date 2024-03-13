import 'dart:async';
import 'package:start_flutter/block_sample/data/cart_service.dart';
import '../models/cart.dart';


class CartBloc{
  final cartStreamController = StreamController.broadcast();
  
  Stream get getStream => cartStreamController.stream;
  
  void addToCart(Cart item){
    CartService.addToCard(item);
    cartStreamController.sink.add(CartService.getCard()); // bu yapıyı kullanan her yeri güncelle

  }

  void removeFromCart(Cart item){
    CartService.removeToCard(item);
    cartStreamController.sink.add(CartService.getCard()); // bu yapıyı kullanan her yeri güncelle
  }

  List<Cart> getAll(){
    return CartService.getCard();
  }
}

final cartBloc = CartBloc(); // tüm sistemlerden çağırmak için