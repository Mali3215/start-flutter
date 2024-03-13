import 'package:flutter/material.dart';
import '../models/student.dart';
import '../validation/student_validator.dart';

class StudentUpdate extends StatefulWidget{
  Student selectedStudent;
  StudentUpdate(this.selectedStudent);

  @override
  State<StatefulWidget> createState() {
    return _StudentUpdateState(selectedStudent);
  }
}

class _StudentUpdateState extends State with StudentValidationMixin{
  Student selectedStudent;
  _StudentUpdateState(this.selectedStudent);

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
      initialValue: selectedStudent.firstName,
      decoration: InputDecoration(labelText: "Öğrenci Adı"),
      validator: validateFirstName,
      onSaved: (String? value){
        if(value != null){
          selectedStudent.firstName = value;
        }
      },
    );
  }
  Widget buildLastNameField() {
    return TextFormField(
      initialValue: selectedStudent.lastName,
      decoration: InputDecoration(labelText: "Öğrenci Soyadı"),
      validator: validateLastName,
      onSaved: (String? value){
        if(value != null){
          selectedStudent.lastName = value;
        }
      },
    );
  }
  Widget buildGradeField() {
    return TextFormField(
      initialValue: selectedStudent.grade.toString(),
      decoration: InputDecoration(labelText: "Öğrenci Notu"),
      validator: validateGrade,
      onSaved: (String? value){
        if(value != null){
          selectedStudent.grade = int.parse(value);
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
    Navigator.pop(context);
  }


}

