import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import '../../toast/toastmsg.dart';
class AllUserScreen extends StatefulWidget {
  const AllUserScreen({super.key});

  @override
  State<AllUserScreen> createState() => _AllUserScreenState();
}

class _AllUserScreenState extends State<AllUserScreen> {
  final ref = FirebaseDatabase.instance.ref();
  final def=FirebaseDatabase.instance.ref().child('Users');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title:Center(
          child: Text("All Users",style: TextStyle(color: Colors.black87,fontFamily: 'serif'),),
        ),
        backgroundColor: Colors.blue[100],
      ),
      body:  Column(
        children: [
          Expanded(
            child:FirebaseAnimatedList(
              query: ref.child('Users'),
              itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
                var get;
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SizedBox(
                        height:190,
                        child: Card(

                          color: Colors.blue[50],
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Column(
                            children: [

                              Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [

                                    Text("Name : ",style: TextStyle(color: Colors.red,fontSize: 18,fontFamily: 'serif',),),

                                    Text(
                                      snapshot.child('name').value.toString(),
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontFamily: 'serif',
                                          color: Colors.black87
                                      ),
                                    ),



                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [

                                    Text("Email : ",style: TextStyle(color: Colors.red,fontSize: 18,fontFamily: 'serif',),),
                                    Text(
                                      snapshot.child('email').value.toString(),
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontFamily: 'serif',
                                          color: Colors.black87
                                      ),
                                    ),


                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [

                                    Text("Password :",style: TextStyle(color: Colors.red,fontSize: 18,fontFamily: 'serif',)),
                                    Text(
                                      snapshot.child('password').value.toString(),
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontFamily: 'serif',
                                          color: Colors.black87
                                      ),
                                    ),


                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [

                                    Text("Mobile no :",style: TextStyle(color: Colors.red,fontSize: 18,fontFamily: 'serif',)),
                                    Text(
                                      snapshot.child('phone').value.toString(),
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontFamily: 'serif',
                                          color: Colors.black87
                                      ),
                                    ),


                                  ],
                                ),
                              ),
                              InkWell(
                                child: GestureDetector(
                                  onTap: (){
                                    def.child(snapshot.child('id').value.toString()).remove();
                                    toastMessage().toastMassage('Users deleted successful..');
                                  },child: Icon(Icons.delete),
                                ),
                              ),

                              SizedBox(height: 10,),
                            ],
                          ),


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
