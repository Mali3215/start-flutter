import 'package:flutter/material.dart';
import '../models/student.dart';
import '../validation/student_validator.dart';
class StudentAdd  extends StatefulWidget{
  List<Student> students;
  StudentAdd(this.students);
  @override
  State<StatefulWidget> createState() {
    return _StudentAddState(students);
  }
}
class _StudentAddState extends State with StudentValidationMixin{
  List<Student> students;
  _StudentAddState(this.students);
  var student = Student.withoutInfo();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Yeni Öğrenci Ekle"),
        backgroundColor: Colors.blueAccent,
      ),

      body: Container(
        margin: EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
           child: Column(
             children: [
              buildFirstNameField(),
               buildLastNameField(),
               buildGradeField(),
               buildSubmitButton()

             ],
           ),
        ),
      )
    );

  }
  Widget buildFirstNameField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Öğrenci Adı"),
      validator: validateFirstName,
      onSaved: (String? value){
        if(value != null){
          student.firstName = value;
        }
      },
    );
  }
  Widget buildLastNameField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Öğrenci Soyadı"),
      validator: validateLastName,
      onSaved: (String? value){
        if(value != null){
          student.lastName = value;
        }
      },
    );
  }
  Widget buildGradeField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Öğrenci Notu"),
      validator: validateGrade,
      onSaved: (String? value){
        if(value != null){
          student.grade = int.parse(value);
        }
      },
    );
  }
  Widget buildSubmitButton() {
    return MaterialButton(
      child: Text("Kaydet"),
      color: Colors.greenAccent,
      onPressed: (){
        if(formKey.currentState != null){
          if(formKey.currentState!.validate()){
            formKey.currentState!.save();
            saveStudent();
          }
        }

      },
    );
  }
  void saveStudent() {
    students.add(student);
    Navigator.pop(context);
  }


}


