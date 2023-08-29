import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shayrana/models/posts_models.dart';
import 'package:shayrana/toast/toastmsg.dart';

class FirebaseFirestoreHelper{
  static FirebaseFirestoreHelper instance=FirebaseFirestoreHelper();

  //FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final dbRef=FirebaseDatabase.instance.ref().child('Posts').child('Post List');

  //get category firebase
  Future<List<PostsModel>> getPosts() async{
    try{
      Map<String,dynamic> querySnapshot= (await dbRef.get()) as Map<String, dynamic>;
      List<PostsModel> postsList=querySnapshot.values
          .map((e) => PostsModel.fromJson(e.data()))
          .toList();
      return postsList;
    }catch (e){
      toastMessage().toastMassage(e.toString());
      log(e.toString());
      return [];
    }
  }

  getUserInformation() {}





}

