import 'package:cloud_firestore/cloud_firestore.dart';


class Survey {
  late String name;
  late int vote;
  late DocumentReference reference;

  Survey.fromMap(Map<String, dynamic> map, {required this.reference})
      : assert(map["name"] != null),
        assert(map["vote"] != null),
        name = map["name"],
        vote = map["vote"];

  Survey.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data() as Map<String, dynamic>, reference: snapshot.reference);
}
