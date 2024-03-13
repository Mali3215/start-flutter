mixin StudentValidationMixin {
  String? validateFirstName(String? value) {
    if (value == null || value.isEmpty) {
      return "İsim boş olamaz.";
    } else if (value.length < 2) {
      return "İsim en az 2 karakter olmalıdır.";
    } else {
      return null; // Geçerli giriş
    }
  }
  String? validateLastName(String? value) {
    if (value == null || value.isEmpty) {
      return "Soy isim boş olamaz.";
    } else if (value.length < 2) {
      return "Soy isim en az 2 karakter olmalıdır.";
    } else {
      return null; // Geçerli giriş
    }
  }
  String? validateGrade(String? value) {
    if (value == null) {
      return "Not boş olamaz.";
    } else {
      var grade = int.parse(value);
      if (grade < 0 || grade > 100) {
        return "Not 0 ile 100 arasında olmalıdır.";
      } else {
        return null; // Geçerli giriş
      }
    }
  }
}
