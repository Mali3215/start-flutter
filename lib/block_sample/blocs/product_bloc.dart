import 'dart:async';

import 'package:start_flutter/block_sample/data/product_service.dart';
import 'package:start_flutter/block_sample/models/product.dart';

class ProductBloc{

  final productStreamController = StreamController.broadcast();

  Stream get getStream => productStreamController.stream;

  List<Product> getAll(){
    return ProductService.getAll();
  }

}

final productBloc = ProductBloc(); // tüm sistemlerden çağırmak için