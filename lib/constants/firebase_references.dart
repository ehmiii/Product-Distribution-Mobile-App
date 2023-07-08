import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseReferences {
  CollectionReference order_bookersReference =
      FirebaseFirestore.instance.collection('bookerOrder');
  CollectionReference sale = FirebaseFirestore.instance.collection('sale');
  CollectionReference products =
      FirebaseFirestore.instance.collection('products');
  CollectionReference orders = FirebaseFirestore.instance.collection('orders');
  CollectionReference story = FirebaseFirestore.instance.collection('story');
  CollectionReference users = FirebaseFirestore.instance.collection("users");
}
