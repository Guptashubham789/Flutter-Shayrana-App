import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import '../../toast/toastmsg.dart';
class AllPostScreen extends StatefulWidget {
  const AllPostScreen({super.key});

  @override
  State<AllPostScreen> createState() => _AllPostScreenState();
}

class _AllPostScreenState extends State<AllPostScreen> {
  final ref = FirebaseDatabase.instance.ref();
  final def=FirebaseDatabase.instance.ref().child('Posts/Post List');
  final def1=FirebaseDatabase.instance.ref().child('SadPost/Post List');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title:Center(
          child: Text("All Post",style: TextStyle(color: Colors.black87,fontFamily: 'serif'),),
        ),
        backgroundColor: Colors.blue[100],
      ),
      body: Column(
        children: [
          Expanded(
            child:FirebaseAnimatedList(
              query: ref.child('Posts/Post List'),
              itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
                var get;
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
                              height: 150,
                              width: 400,
                              child: Image.network(snapshot.child('pImage').value.toString(),height: 150, width: 400,

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
                                          fontSize: 18,
                                          fontFamily: 'serif',
                                          color: Colors.black87
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    child: GestureDetector(
                                      onTap: (){
                                        def.child(snapshot.child('pId').value.toString()).remove();
                                        toastMessage().toastMassage("Post Delete Succesful");
                                      },child: Icon(Icons.delete),
                                    ),
                                  )
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
              },),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text("Sad Post",style:TextStyle(fontFamily: 'serif',backgroundColor: Colors.blue[100])),
          ),
          Expanded(
            child:FirebaseAnimatedList(
              query: ref.child('SadPost/Post List'),
              itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
                var get;
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
                              height: 150,
                              width: 400,
                              child: Image.network(snapshot.child('pImage').value.toString(),height: 150, width: 400,

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
                                          fontSize: 18,
                                          fontFamily: 'serif',
                                          color: Colors.black87
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    child: GestureDetector(
                                      onTap: (){
                                        def1.child(snapshot.child('pId').value.toString()).remove();
                                        toastMessage().toastMassage("Post Delete Succesful");
                                      },child: Icon(Icons.delete),
                                    ),
                                  )
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
              },),
          )
        ],
      ),
    );
  }
}
