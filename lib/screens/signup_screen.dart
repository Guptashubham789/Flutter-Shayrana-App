
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shayrana/components/btm_bar_screen.dart';
import 'package:shayrana/toast/toastmsg.dart';

import '../components/round_button.dart';
import 'home_screen.dart';
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final databaseRef = FirebaseDatabase.instance.ref('Users');
  FirebaseAuth _auth=FirebaseAuth.instance;
  bool showSpinner=false;
  TextEditingController emailcontroller=TextEditingController();
  TextEditingController passwordcontroller=TextEditingController();
  TextEditingController namecontroller=TextEditingController();
  TextEditingController mobilecontroller=TextEditingController();

  final _formKey=GlobalKey<FormState>();
  String email="",password="",name="",mobile="";

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Register",style: TextStyle(fontFamily: 'Serif',color: Colors.black87),),
          backgroundColor: Colors.blue[100],
        ),
        body: SingleChildScrollView(
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.center,
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 100,),
              Text("SignUp",style: TextStyle(fontSize: 24,fontFamily: 'courier'),),
              SizedBox(height: 30,),
              Form(
                key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: namecontroller,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            hintText: "Name",
                            labelText: "Name",
                            border: OutlineInputBorder(
                              borderRadius:BorderRadius.only(bottomLeft:Radius.circular(10),bottomRight: Radius.circular(10),topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            prefixIcon: Icon(Icons.person_sharp),
                            prefixIconColor:Colors.blue,
                          ),
                          onChanged: (String value){
                            name=value;
                          },
                          validator:(value){
                            return value!.isEmpty?'Enter name':null;
                          },
                        ),
                        SizedBox(height: 20,),
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
                        TextFormField(
                          controller: passwordcontroller,
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          decoration: const InputDecoration(
                            hintText: "Password",
                            labelText: "Password",

                            border: OutlineInputBorder(
                              borderRadius:BorderRadius.only(bottomLeft:Radius.circular(10),bottomRight: Radius.circular(10),topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            prefixIcon: Icon(Icons.lock_clock_outlined),
                            prefixIconColor:Colors.blue,
                          ),
                          onChanged: (String value){
                            password=value;
                          },
                          validator:(value){
                            return value!.isEmpty?'Enter password':null;
                          },
                        ),
                        SizedBox(height: 20,),
                        TextFormField(
                          controller: mobilecontroller,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            hintText: "Mobile",
                            labelText: "Mobile",
                            border: OutlineInputBorder(
                              borderRadius:BorderRadius.only(bottomLeft:Radius.circular(10),bottomRight: Radius.circular(10),topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            prefixIcon: Icon(Icons.phone_android_outlined),
                            prefixIconColor:Colors.blue,
                          ),
                          onChanged: (String value){
                            mobile=value;
                          },
                          validator:(value){
                            return value!.isEmpty?'Enter mobile number':null;
                          },
                        ),
                        SizedBox(height: 20,),
                        RoundButton(title: "SignUp", onPress: ()async{
                          if(_formKey.currentState!.validate()){
                            User();
                            setState(() {
                              showSpinner=true;
                            });
                              try{
                                final user=await _auth.createUserWithEmailAndPassword(
                                    email: email.toString().trim(),
                                    password: password.toString().trim()
                                );
                                if(user!=null){
                                  toastMessage().toastMassage('Welcome To  ${emailcontroller.text.toString()}');
                                  setState(() {
                                    showSpinner=false;
                                  });
                                  Navigator.popUntil(context, (route) => route.isFirst);
                                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (Context)=> BottomBarScreen()));
                                }
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
  void User(){
    databaseRef
        .child(DateTime.now().millisecondsSinceEpoch.toString())
        .set({
      'email': emailcontroller.text.toString(),
      'password': passwordcontroller.text.toString(),
      'name': namecontroller.text.toString(),
      'phone': mobilecontroller.text.toString(),
      'id': DateTime.now().millisecondsSinceEpoch.toString()
    });
  }
}
