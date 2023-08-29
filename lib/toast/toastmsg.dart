import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class toastMessage{

  void toastMassage(String massage){
    Fluttertoast.showToast(
        msg: massage,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blue[100],
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

}