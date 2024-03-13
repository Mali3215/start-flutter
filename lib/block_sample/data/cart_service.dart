import '../models/cart.dart';

class CartService{

  static List<Cart> cartItems = [];

  static CartService _singleton = CartService._internal();

  factory CartService(){
    return _singleton;
  }

  CartService._internal();

  static void addToCard(Cart item){
    cartItems.add(item);
  }

  static void removeToCard(Cart item){
    cartItems.remove(item);
  }

  static List<Cart> getCard(){
    return cartItems;
  }

}