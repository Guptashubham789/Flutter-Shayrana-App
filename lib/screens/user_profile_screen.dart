import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shayrana/screens/user_notification_screen.dart';

import '../components/round_button.dart';
import '../toast/toastmsg.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {

  @override
  Widget build(BuildContext context) {
    final ref=FirebaseDatabase.instance.ref('Users');
    final auth=FirebaseAuth.instance.currentUser!;
    final postRef=FirebaseDatabase.instance.ref().child('FeedbackUsers');
    TextEditingController feedbackcontroller=TextEditingController();
    TextEditingController namecontroller=TextEditingController();
    TextEditingController emailcontroller=TextEditingController();
    bool showSpinner=false;

    print(auth);
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Center(child: Text("Profile",style: TextStyle(color: Colors.black87,fontFamily: 'serif'))),
          backgroundColor: Colors.blue[100],
          actions: [
            IconButton(onPressed: (){
              Navigator.push(
                  context,MaterialPageRoute(builder: (Context)=> UserNotificationScreen()));
            }, icon: Icon(Icons.mark_unread_chat_alt_outlined,color: Colors.black87,),),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: StreamBuilder(

              builder: (context, snapshot){
                if(snapshot.hasData){
                    return CircularProgressIndicator();
                }else{
                  return Column(
                    children: [
                      Center(
                        child: Center(
                          child: Card(
                            color: Colors.white,
                            elevation: 10.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Container(
                              height: 100,
                              width: 100,
                              // color: Colors.white,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  color: Colors.white
                              ),
                              child: Image(image: AssetImage("images/logo1shayrana.jpg")),),
                          ),

                        ),
                      ),

                      SizedBox(height: 15,),

                      Text(auth.email.toString().toLowerCase(),style: TextStyle(fontSize: 20,fontFamily: 'serif',color: Colors.red),),
                      Divider(height: 20,color: Colors.black87,),
                      Text('Feedback',style: TextStyle(fontSize: 14,fontFamily: 'serif',color: Colors.black87,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),),
                      Form(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: TextFormField(
                                  controller: namecontroller,
                                  keyboardType: TextInputType.text,
                                  minLines: 1,
                                  maxLines: 4,
                                  decoration: InputDecoration(
                                    labelText: 'Name',
                                    hintText: 'Enter name',
                                    border: OutlineInputBorder(
                                      borderRadius:BorderRadius.only(bottomLeft:Radius.circular(10),bottomRight: Radius.circular(10),topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                                      borderSide: BorderSide(color: Colors.blue),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: TextFormField(
                                  controller: emailcontroller,
                                  keyboardType: TextInputType.text,
                                  minLines: 1,
                                  maxLines: 4,
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                    hintText: 'Enter email',
                                    border: OutlineInputBorder(
                                      borderRadius:BorderRadius.only(bottomLeft:Radius.circular(10),bottomRight: Radius.circular(10),topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                                      borderSide: BorderSide(color: Colors.blue),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: TextFormField(
                                  controller: feedbackcontroller,
                                  keyboardType: TextInputType.text,
                                  minLines: 1,
                                  maxLines: 4,
                                  decoration: InputDecoration(
                                    labelText: 'Feedback',
                                    hintText: 'Enter the message',
                                    border: OutlineInputBorder(
                                      borderRadius:BorderRadius.only(bottomLeft:Radius.circular(10),bottomRight: Radius.circular(10),topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                                      borderSide: BorderSide(color: Colors.blue),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                      ),

                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: RoundButton(
                            title: "Feedback",
                            onPress: ()async{
                              setState(() {
                                showSpinner=true;
                              });
                              try{

                                int date=DateTime.now().microsecondsSinceEpoch;
                                postRef.child('Feedback List').child(date.toString()).set(
                                    {
                                      'fId':date.toString(),
                                      'fName':namecontroller.text.toString(),
                                      'fEmail':emailcontroller.text.toString(),
                                      'fMessage':feedbackcontroller.text.toString(),

                                    }).then((value){
                                  toastMessage().toastMassage("Thanks for Feedback");

                                  setState(() {
                                    showSpinner=false;
                                  });
                                }).onError((error, stackTrace){
                                  toastMessage().toastMassage(error.toString());
                                  setState(() {
                                    showSpinner=false;
                                  });
                                });
                              }catch(e){
                                setState(() {
                                  showSpinner=false;
                                });
                                toastMessage().toastMassage(e.toString());
                              }

                            }
                        ),
                      )


                    ],
                  );
                }

              },
              ),
            ),
          ),
        ),
    );
  }
}
