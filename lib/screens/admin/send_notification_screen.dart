import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../components/round_button.dart';
import '../../toast/toastmsg.dart';
class SendMessageScreen extends StatefulWidget {
  const SendMessageScreen({super.key});

  @override
  State<SendMessageScreen> createState() => _SendMessageScreenState();
}

class _SendMessageScreenState extends State<SendMessageScreen> {
  bool showSpinner=false;
  TextEditingController titlecontroller=TextEditingController();
  TextEditingController bodycontroller=TextEditingController();
  final postRef=FirebaseDatabase.instance.ref().child('Notification');

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title:Center(
            child: Text("Send Message",style: TextStyle(color: Colors.black87,fontFamily: 'serif'),),
          ),
          backgroundColor: Colors.blue[100],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [

              SizedBox(height: 20,),
              //RoundButton(title:Icon(), onPress: onPress)
              Form(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          controller: titlecontroller,
                          keyboardType: TextInputType.text,
                          minLines: 1,

                          decoration: InputDecoration(
                            labelText: 'Title',
                            hintText: 'Write the title..',
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
                          controller: bodycontroller,
                          keyboardType: TextInputType.text,
                          minLines: 1,
                          maxLines: 4,
                          decoration: InputDecoration(
                            labelText: 'Body',
                            hintText: 'Write the message',
                            border: OutlineInputBorder(
                              borderRadius:BorderRadius.only(bottomLeft:Radius.circular(10),bottomRight: Radius.circular(10),topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: RoundButton(
                    title: "Send Notification",
                    onPress: ()async{
                      setState(() {
                        showSpinner=true;
                      });
                      try{
                        int date=DateTime.now().microsecondsSinceEpoch;
                        final date1=DateTime.now();
                        postRef.child('Notification List').child(date.toString()).set(
                            {
                              'id':date.toString(),
                              'title':titlecontroller.text.toString(),
                              'body':bodycontroller.text.toString(),
                              'date':date1.toString()
                            }).then((value){
                          toastMessage().toastMassage("Message send to the users");
                          Navigator.pop(context);
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
          ),
        ),
      ),
    );
  }
}
