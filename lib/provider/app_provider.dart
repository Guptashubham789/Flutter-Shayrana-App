import 'package:flutter/material.dart';
import 'package:shayrana/provider/user_model.dart';

import '../models/firebase/firebase_database.dart';
UserModel? _userModel;
UserModel get getUserInformation => _userModel!;

class AppProvider with ChangeNotifier{

  void getUserInfoFirebase() async{
    _userModel = await FirebaseFirestoreHelper.instance.getUserInformation();
    notifyListeners();
  }

}