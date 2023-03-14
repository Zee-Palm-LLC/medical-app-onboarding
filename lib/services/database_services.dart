import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_model.dart';

class DatabaseService {
  FirebaseFirestore firebase = FirebaseFirestore.instance;

  CollectionReference<UserModel?> get userCollection => firebase
          .collection('Users')
          .withConverter(fromFirestore: (snapshot, options) {
        return snapshot.exists ? UserModel.fromMap(snapshot.data()!) : null;
      }, toFirestore: (object, options) {
        return object!.toMap();
      });

  CollectionReference courseCollection =
      FirebaseFirestore.instance.collection('course');

  CollectionReference favoriteCollection =
      FirebaseFirestore.instance.collection('favorites');

  CollectionReference cartCollection =
      FirebaseFirestore.instance.collection('cart');
}
