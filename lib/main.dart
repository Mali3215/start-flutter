import 'package:flutter/material.dart';
import 'package:start_flutter/block_sample/screen/cart_screen.dart';
import 'package:start_flutter/block_sample/screen/product_list_screen.dart';
import 'package:start_flutter/http_demo/screens/main_screen.dart';
import 'package:start_flutter/sqflite/screens/product_list.dart';
import 'package:start_flutter/student_information_system/models/student.dart';
import 'package:start_flutter/student_information_system/screens/student_add.dart';
import 'package:start_flutter/student_information_system/screens/student_update.dart';
import 'firebase_sample/survey_list.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
      //home: ConditionBlocks() // -> şart blokları
      //home: ListsTypes() // -> liste kullanımları, fun kullanımları, getter setter kullanımları, navigation, listelerde add, update delete
      //home: SqfLite() // -> Sqflite
      //home: HttpApp() // rest api örnek
      //home: BlocSample(), // bloc pattern örnek
      home: FirabaseSample() // firabase örnek
  ));
}

class FirabaseSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Anket Listesi',style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.blueGrey,
        ),
        body: SurveyList(),
      ),
    );
  }
}

class BlocSample extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/": (BuildContext context) => ProductListScreen(),
        "/cart": (BuildContext context) => CartScreen()
      },
      initialRoute: "/",
    );
  }
}

class HttpApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainScreen(),
    );
  }


}

class SqfLite extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: ProductList()
    );
  }

}
// -> liste kullanımları, fun kullanımları, getter setter kullanımları, navigation, listelerde add, update delete
class ListsTypes extends StatefulWidget /* durum yönetimi yapar*/ {
  @override
  State<StatefulWidget> createState() => _ListsTypes();
}

class _ListsTypes extends State<
    ListsTypes> /*StatelessWidget -> durum yönetimi yapmaz sadece çizer */ {
  var title = "Öğrenci Listesi";
  var urunler = ["Laptop", "Mouse", "Keyboard"];
  Student selectedStudent = Student.withId(-1, "", "", -1);
  List<Student> students = [
    Student.withId(1, "Mali", "Mali", 100),
    Student.withId(2, "Ali", "Mali", 25),
    Student.withId(3, "Mali", "Ali", 45)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.blueAccent,
      ),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
              itemCount: students.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: const CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://cdn.pixabay.com/photo/2024/02/25/10/11/forsythia-8595521_1280.jpg"),
                  ),
                  onLongPress: () {
                    selectedStudent = students[index];
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                StudentUpdate(selectedStudent))).then((value) {
                      setState(() {
                        // Yeni öğrenci eklendikten sonra liste güncellenecek
                      });
                    });
                  },
                  title: Text(
                      "${students[index].firstName} ${students[index].lastName}"),
                  subtitle: Text(
                      "Sınavdan Aldığı Not = ${students[index].grade} [${students[index].getStatus}] "),
                  trailing: buildStatusIcon(students[index].grade),
                  onTap: () {
                    setState(() {
                      selectedStudent = students[index];
                    });
                  },
                );
              }),
        ),
        Text(
            "Seçili Öğrenci: ${selectedStudent.firstName} ${selectedStudent.lastName}"),
        Row(
          children: [
            Flexible(
              fit: FlexFit.tight,
              flex: 2,
              child: MaterialButton(
                child: Row(
                  children: [
                    Icon(Icons.add, color: Colors.white),
                    SizedBox(width: 5),
                    Text("Yeni Öğrenci"),
                  ],
                ),
                onPressed: () {
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StudentAdd(students)))
                      .then((value) {
                    setState(() {
                      // Yeni öğrenci eklendikten sonra liste güncellenecek
                    });
                  });
                },
                color: Colors.greenAccent,
                textColor: Colors.white,
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 2,
              child: MaterialButton(
                child: Row(
                  children: [
                    Icon(Icons.update, color: Colors.white),
                    SizedBox(width: 5),
                    Text("Güncelle"),
                  ],
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              StudentUpdate(selectedStudent))).then((value) {
                    setState(() {
                      // Yeni öğrenci eklendikten sonra liste güncellenecek
                    });
                  });
                },
                color: Colors.orangeAccent,
                textColor: Colors.white,
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: MaterialButton(
                child: Row(
                  children: [
                    Icon(Icons.delete, color: Colors.white),
                    SizedBox(width: 5),
                    Text("Sil"),
                  ],
                ),
                onPressed: () {
                  setState(() {
                    students.remove(selectedStudent);
                  });
                  var message =
                      "${selectedStudent.firstName} ${selectedStudent.firstName} Adlı Öğrenci Silindi.";
                  showMassage(context, message);
                },
                color: Colors.redAccent,
                textColor: Colors.white,
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget buildStatusIcon(int grade) {
    if (grade >= 65) {
      return Icon(Icons.check);
    } else if (grade >= 40) {
      return Icon(Icons.album);
    } else {
      return Icon(Icons.clear);
    }
  }

  String sinavSonucuHesapla(int not) {
    var cevap = "";
    if (not >= 65) {
      cevap = "Aleyküm selam";
    } else if (not >= 40) {
      cevap = "Yakışmadı ama Aleyküm selam";
    } else {
      cevap = "Batırdın be kardeşim ama Aleyküm selam";
    }
    return cevap;
  }

  void showMassage(BuildContext context, String result) {
    var alert = AlertDialog(
      //title: Text("Cevabım"),
      content: Text(result),
    );
    showDialog(context: context, builder: (BuildContext context) => alert);
  }
}

// şart blokları
class ConditionBlocks extends StatelessWidget {
  var one = "Selamun aleyküm";
  var two = "Aleyküm selam!";
  var not = 35;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sonucu Gör"),
      ),
      body: Center(
        child: MaterialButton(
          child: Text("Cevap Ver"),
          onPressed: () {
            var cevap = "";
            if (not >= 65) {
              cevap = "Aleyküm selam";
            } else if (not >= 40) {
              cevap = "Yakışmadı ama Aleyküm selam";
            } else {
              cevap = "Batırdın be kardeşim ama Aleyküm selam";
            }

            var alert = AlertDialog(
              title: Text("Cevabım"),
              content: Text(cevap),
            );
            showDialog(
                context: context, builder: (BuildContext context) => alert);
          },
        ),
      ),
    );
  }
}
