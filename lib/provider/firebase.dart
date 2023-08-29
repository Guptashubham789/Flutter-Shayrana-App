import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shayrana/provider/user_model.dart';

class FirebaseFirestoreHelper{
  static FirebaseFirestoreHelper instance=FirebaseFirestoreHelper();
 // FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final ref=FirebaseDatabase.instance.ref().child('Users');

  Future<UserModel> getUserInformation() async{
    Map<String,dynamic> querySnapshot=
    (await ref.child(FirebaseAuth.instance.currentUser!.uid).get()) as Map<String, dynamic>;

    return UserModel.fromJson(querySnapshot);
  }
}

