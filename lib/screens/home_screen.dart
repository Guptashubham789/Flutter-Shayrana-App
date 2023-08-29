
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shayrana/screens/option_screen.dart';
import 'package:shayrana/screens/user_notification_screen.dart';
import 'package:shayrana/toast/toastmsg.dart';
//import 'package:flutter_icons/flutter_icons.dart';
import 'package:url_launcher/url_launcher.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //final dbRef=FirebaseDatabase.instance.ref().child('Posts');
  final ref = FirebaseDatabase.instance.ref();

  final refresh=FirebaseDatabase.instance.reference();
  //final snapshot =ref.child('Posts/Post List').get();
  FirebaseAuth _auth=FirebaseAuth.instance;
  String? instagram;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:Center(
          child: Text("Love Shayri",style: TextStyle(color: Colors.black87,fontFamily: 'serif'),),
        ),
        backgroundColor: Colors.blue[100],
        actions: [
          IconButton(onPressed: (){
            Navigator.push(
                context,MaterialPageRoute(builder: (Context)=> UserNotificationScreen()));
          }, icon: Icon(Icons.mark_unread_chat_alt_outlined,color: Colors.black87,)),
          IconButton(onPressed: (){
            _auth.signOut().then((value) {
              Navigator.popUntil(context, (route) => route.isFirst);
              Navigator.push(
                  context,MaterialPageRoute(builder: (Context)=> OptionScreen()));
              toastMessage().toastMassage("Logout success");
              setState(() {

              });
            }).onError((error, stackTrace) {
              toastMessage().toastMassage(error.toString());
            });
          }, icon:Icon(Icons.logout_outlined,color: Colors.black87,)),
        ],
      ),

      body:Column(
        children: [

          Expanded(
              child:FirebaseAnimatedList(
                query: ref.child('Posts/Post List'),
                reverse: false,

                itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
                 // var index;
                if(index==index){
                return Column(

                children: [
                Padding(
                padding: const EdgeInsets.all(12.0),
                  child: Card(
                  color: Colors.blue[50],
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Column(
                  children: [
                  SizedBox(height: 20,),
                  SizedBox(
                  height: 300,
                  width: 400,
                  child: Image.network(snapshot.child('pImage').value.toString(),height: 300, width: 400,

                  ),
                  ),
                  SizedBox(height: 10,),

                  Center(
                  child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(snapshot.child('pTitle').value.toString(),
                  style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'serif',
                  color: Colors.black87,
                  fontStyle: FontStyle.italic
                  ),
                  ),
                  ),
                  //Text(snapshot.child('pTime').value.toString()),
                  IconButton(onPressed: () {}, icon:Icon(Icons.favorite,color: Colors.red,)),
                  IconButton(onPressed: () async {
                  Share.share(snapshot.child('pImage').value.toString());
                  }, icon:Icon(Icons.share,color: Colors.black87,)),

                  ],
                  ),
                  ),
                  SizedBox(height: 10,),
                  ],
                  ),


                  ),
                  ),
                  ],
                  );
                }else{
                  return Center(
                    child: Text("Item is empty.."),
                  );
                }


              },),
          ),
          //FloatingActionButton(onPressed: (){}),
        ],

      ),

    );
  }
}



