import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import '../../toast/toastmsg.dart';
class UsersFeedback extends StatefulWidget {
  const UsersFeedback({super.key});

  @override
  State<UsersFeedback> createState() => _UsersFeedbackState();
}

class _UsersFeedbackState extends State<UsersFeedback> {
  final ref = FirebaseDatabase.instance.ref();
  final def=FirebaseDatabase.instance.ref().child('FeedbackUsers/Feedback List');
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
              query: ref.child('FeedbackUsers/Feedback List'),
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

                                    Text("Name : ",style: TextStyle(color: Colors.red,fontSize: 15,fontFamily: 'serif',),),

                                    Text(
                                      snapshot.child('fName').value.toString(),
                                      style: const TextStyle(
                                          fontSize: 12,
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

                                    Text("Email : ",style: TextStyle(color: Colors.red,fontSize: 15,fontFamily: 'serif',),),
                                    Text(

                                      snapshot.child('fEmail').value.toString(),
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'serif',

                                          color: Colors.black87
                                      ),
                                    ),


                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [

                                    Text("Feedback :",style: TextStyle(color: Colors.red,fontSize: 15,fontFamily: 'serif',)),

                                    Center(
                                      child:Container(
                                        constraints:  BoxConstraints(
                                            maxWidth: 500),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10),
                                          child: Text(snapshot.child('fMessage').value.toString(),
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                                fontFamily: 'serif',
                                                color: Colors.black87,
                                                fontStyle: FontStyle.italic
                                            ),
                                          ),
                                        ),
                                      ),
                                    )

                                  ],
                                ),
                              ),
                              SizedBox(height: 10,),
                              InkWell(
                                child: GestureDetector(
                                  onTap: (){
                                    def.child(snapshot.child('fId').value.toString()).remove();
                                    toastMessage().toastMassage('Delete Feedback Message');
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
