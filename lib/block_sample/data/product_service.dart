import 'package:start_flutter/block_sample/models/product.dart';

class ProductService{
  static List<Product> products = [];

  static List<Product> getAll(){
    products.clear();
    products.add(Product(1, "Acer Laptop", 6000));
    products.add(Product(2, "Acer Laptop", 7000));
    products.add(Product(3, "Acer Laptop", 8000));
    products.add(Product(4, "Acer Laptop", 9000));
    products.add(Product(5, "Acer Laptop", 10000));

    return products;
  }

  static ProductService _singleton = ProductService._internal();

  factory ProductService(){
    return _singleton;
  }

  ProductService._internal();
}