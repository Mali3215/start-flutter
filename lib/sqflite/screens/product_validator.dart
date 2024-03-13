mixin ProductValidationMixin {
  String? validateProductName(String? value) {
    if (value == null || value.isEmpty) {
      return "Ürün ismi boş olamaz.";
    } else if (value.length < 2) {
      return "İsim en az 2 karakter olmalıdır.";
    } else {
      return null; // Geçerli giriş
    }
  }
  String? validateProductDescription(String? value) {
    if (value == null || value.isEmpty) {
      return "Ürün açıklaması boş olamaz.";
    } else if (value.length < 2) {
      return "Ürün açıklaması en az 2 karakter olmalıdır.";
    } else {
      return null; // Geçerli giriş
    }
  }
  String? validateProductUnitPrice(String? value) {
    if (value == null) {
      return "Ürün fiyatı boş olamaz.";
    } else {
      var grade = double.parse(value);
      if (grade < 0) {
        return "Ürün fiyatı 0'dan büyük olmalıdır.";
      } else {
        return null; // Geçerli giriş
      }
    }
  }
}
