import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shayrana/components/btm_bar_screen.dart';
import 'package:shayrana/screens/admin/home_screen.dart';
import 'package:shayrana/screens/forgotpassword_screen.dart';
import 'package:shayrana/screens/home_screen.dart';

import '../components/round_button.dart';
import '../toast/toastmsg.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  FirebaseAuth _auth=FirebaseAuth.instance;
  bool showSpinner=false;
  TextEditingController emailcontroller=TextEditingController();
  TextEditingController passwordcontroller=TextEditingController();
  void admin(){
    setState(() {

    });
    if(email=="Sonam".trim() && password=="prashu".trim() || email=="shubham".trim() && password=="gupta@8090".trim() || email=="7704050632".trim() && password=="7704050632".trim() || email=="9336605145".trim() && password=="9336605145".trim()){
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (Context)=> AdminHomeScreen()));
      toastMessage().toastMassage('Hello ${emailcontroller.text.toString()}');
    }else{
      //toastMessage().toastMassage("email & password wrong..");

    }
  }

  final _formKey=GlobalKey<FormState>();
  String email="",password="";

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Login",style: TextStyle(fontFamily: 'Serif',color: Colors.black87),),
          backgroundColor: Colors.blue[100],
        ),
        body: SingleChildScrollView(
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.center,
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 100,),
              Text("Login",style: TextStyle(fontSize: 24,fontFamily: 'courier'),),
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
                        TextFormField(
                          controller: passwordcontroller,
                          keyboardType: TextInputType.text,
                          obscureText: false,
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: (){
                              Navigator.push(
                                  context,MaterialPageRoute(builder: (Context)=> ForgotPassScreen()));
                            },
                            child: Align(
                              alignment: Alignment.centerRight,
                                child: Text('Forgot Password?')),
                          ),
                        ),
                        SizedBox(height: 20,),
                        RoundButton(title: "Login", onPress: ()async{
                          if(_formKey.currentState!.validate()){
                            admin();
                            setState(() {
                              showSpinner=true;
                            });
                            try{
                              final user=await _auth.signInWithEmailAndPassword(
                                  email: email.toString().trim(),
                                  password: password.toString().trim()
                              );
                              if(user!=null){
                                toastMessage().toastMassage("Login successfully..");
                                setState(() {
                                  showSpinner=false;
                                });
                                Navigator.popUntil(context, (route) => route.isFirst);
                                Navigator.pushReplacement(context,MaterialPageRoute(builder: (Context)=> BottomBarScreen()));
                                // Navigator.push(
                                //     context,MaterialPageRoute(builder: (Context)=> HomeScreen()));
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
}
