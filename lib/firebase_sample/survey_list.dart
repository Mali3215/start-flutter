import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'models/survey.dart';

class SurveyList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SurveyListState();
  }
}

class SurveyListState extends State<SurveyList> {
  @override
  Widget build(BuildContext context) {

   return StreamBuilder<QuerySnapshot>(
     stream: FirebaseFirestore.instance.collection('dil_anketi').snapshots(),
     builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
       if (snapshot.hasError) return Text('Error: ${snapshot.error}');
       switch (snapshot.connectionState) {
         case ConnectionState.waiting:
           return LinearProgressIndicator();
         default:
           if(snapshot.data != null){
             return buildBody(context,snapshot.data!.docs);
           }else{
             return Text("Data Yok");
           }
       }
     },
   );
  }

  Widget buildBody(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: EdgeInsets.only(top: 20),
      children: snapshot.map<Widget>((data) => buildListItem(context, data)).toList(),
    );
  }

  buildListItem(BuildContext context, DocumentSnapshot data) {
    final row = Survey.fromSnapshot(data); // data parametresi artık Map<String, dynamic> türünde
    return Padding(
      key: ValueKey(row.name),
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8 ),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8)
        ),
        child: ListTile(
          title: Text(row.name),
          trailing: Text(row.vote.toString()),
          onTap: () => FirebaseFirestore.instance.runTransaction((transaction) async{
            final freshSnapshot = await transaction.get(row.reference); // Snapshot
            final fresh = Survey.fromSnapshot(freshSnapshot);
            await transaction.update((row.reference), {'vote':fresh.vote + 1});

            //row.reference.update({'vote':row.vote + 1}) // farklı bir kullanım
          }),
        ),
      ),
    );
  }

}
