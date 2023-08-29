import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
class UserNotificationScreen extends StatefulWidget {
  const UserNotificationScreen({super.key});

  @override
  State<UserNotificationScreen> createState() => _UserNotificationScreenState();
}

class _UserNotificationScreenState extends State<UserNotificationScreen> {
  final ref = FirebaseDatabase.instance.ref();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text("Notification",style: TextStyle(color: Colors.black87,fontFamily: 'serif'),
        ),
        backgroundColor: Colors.blue[100],
      ),
      body: Column(
        children: [

          Expanded(
            child:FirebaseAnimatedList(
              query: ref.child('Notification/Notification List').limitToLast(1),

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
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                        child: Column(
                          children: [
                            Column(
                              children: [

                                Card(
                                  elevation: 8.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: SizedBox(
                                    height:100,
                                    child: Image(image: AssetImage('images/logo1shayrana.jpg')),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 20,),


                            Center(
                              child:  Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: Text(snapshot.child('title').value.toString(),
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'serif',
                                            color: Colors.black87,
                                            fontStyle: FontStyle.italic
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Container(
                                    constraints:  BoxConstraints(
                                        maxWidth: 500),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: Text(snapshot.child('body').value.toString(),
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
                                  //Text(snapshot.child('pTime').value.toString()),
                                  //IconButton(onPressed: () {}, icon:Icon(Icons.favorite,color: Colors.red,)),


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
          //FloatingActionButton(onPressed: (){}),
        ],

      ),
    );
  }
}
