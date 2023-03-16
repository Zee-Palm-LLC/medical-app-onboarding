import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/category_model.dart';
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

  CollectionReference<CategoryModel> categoryCollection =
      FirebaseFirestore.instance.collection('category').withConverter(
            fromFirestore: (snapshots, _) =>
                CategoryModel.fromMap(snapshots.data()!),
            toFirestore: (category, _) => category.toMap(),
          );

  CollectionReference courseCollection =
      FirebaseFirestore.instance.collection('course');

  CollectionReference favoriteCollection =
      FirebaseFirestore.instance.collection('favorites');

  CollectionReference cartCollection =
      FirebaseFirestore.instance.collection('cart');

  CollectionReference purchasedCollection =
      FirebaseFirestore.instance.collection('purchased');
}
