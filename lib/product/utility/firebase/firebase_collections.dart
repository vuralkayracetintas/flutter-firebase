import 'package:cloud_firestore/cloud_firestore.dart';

enum FirebaseCollections {
  version,
  news,
  tag;

  CollectionReference get referance =>
      FirebaseFirestore.instance.collection(name);
}
