class Product {
  late int id;
  late int categoryId;
  late String productName;
  late String quantityPerUnit;
  late double unitPrice;
  late int unitsInStock;

  Product(this.id,
      this.categoryId,
      this.productName,
      this.quantityPerUnit,
      this.unitPrice,
      this.unitsInStock);

  Product.fromJson(Map json) {
    id = json["id"] is String ? int.parse(json["id"]) : 0;
    categoryId = json["categoryId"] is String ? int.parse(json["categoryId"]) : 0;
    productName = json["productName"] ?? "";
    quantityPerUnit = json["quantityPerUnit"] ?? "";
    unitPrice = json["unitPrice"] is double ? json["unitPrice"] : 0.0;
    unitsInStock = json["unitsInStock"] is String ? int.parse(json["unitsInStock"]) : 0;
  }

  Map toJson() {
    return {
      "id": id,
      "categoryId": categoryId,
      "productName": productName,
      "quantityPerUnit": quantityPerUnit,
      "unitPrice": unitPrice,
      "unitsInStock": unitsInStock
    };
  }
}
