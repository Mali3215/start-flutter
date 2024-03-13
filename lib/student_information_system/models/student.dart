class Student{
  int id = -1;
  String firstName = "";
  String lastName= "";
  int grade= -1;
  String _status= "";


  Student.withId(this.id,this.firstName, this.lastName,this.grade);

  Student(this.firstName, this.lastName,this.grade);

  Student.withoutInfo(){}

  String get getFirstName{
    return "OGR - $firstName";
  }

  set setFirstName(String value){
    firstName = value;
  }

  String get getStatus{
    var massage = "";
    if(grade >= 65){
      massage = "Geçti";
    }else if(grade >= 40){
      massage = "Bütünleme";
    }else {
      massage = "Kaldı";

    }
    return massage;
  }


}