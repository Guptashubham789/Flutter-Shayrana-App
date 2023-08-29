import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../components/round_button.dart';
import '../toast/toastmsg.dart';

class ForgotPassScreen extends StatefulWidget {
  const ForgotPassScreen({super.key});

  @override
  State<ForgotPassScreen> createState() => _ForgotPassScreenState();
}

class _ForgotPassScreenState extends State<ForgotPassScreen> {
  FirebaseAuth _auth=FirebaseAuth.instance;
  bool showSpinner=false;
  TextEditingController emailcontroller=TextEditingController();
  final _formKey=GlobalKey<FormState>();
  String email="";

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Forgot Password",style: TextStyle(fontFamily: 'Serif',color: Colors.black87),),
          backgroundColor: Colors.blue[100],


        ),
        body: SingleChildScrollView(
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.center,
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 100,),
              SizedBox(height: 30,),
              Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: emailcontroller,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            hintText: "Email",
                            labelText: "Email",
                            border: OutlineInputBorder(
                              borderRadius:BorderRadius.only(bottomLeft:Radius.circular(10),bottomRight: Radius.circular(10),topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            prefixIcon: Icon(Icons.email_outlined),
                            prefixIconColor:Colors.blue,
                          ),
                          onChanged: (String value){
                            email=value;
                          },
                          validator:(value){
                            return value!.isEmpty?'Enter email':null;
                          },
                        ),
                        SizedBox(height: 20,),

                        RoundButton(title: "Send Email", onPress: ()async{
                          if(_formKey.currentState!.validate()){

                            setState(() {
                              showSpinner=true;
                            });
                            try{
                              _auth.sendPasswordResetEmail(email: emailcontroller.text.toString()).then((value){
                                setState(() {
                                  showSpinner=false;
                                });
                                toastMessage().toastMassage("Please check your email, a reset link has been sent to you via email");
                              }).onError((error, stackTrace) {
                                toastMessage().toastMassage(error.toString());
                                setState(() {
                                  showSpinner=false;
                                });
                              });
                            }catch(e){
                              // print(e.toString());
                              toastMessage().toastMassage(e.toString());
                              setState(() {
                                showSpinner=false;
                              });
                            }
                          }
                        })
                      ],
                    ),
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}
