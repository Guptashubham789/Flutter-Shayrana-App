import 'package:flutter/material.dart';
import 'package:shayrana/components/round_button.dart';
import 'package:shayrana/screens/admin/home_screen.dart';
import 'package:shayrana/screens/signin_screen.dart';
import 'package:shayrana/screens/signup_screen.dart';

class OptionScreen extends StatefulWidget {
  const OptionScreen({super.key});

  @override
  State<OptionScreen> createState() => _OptionScreenState();
}

class _OptionScreenState extends State<OptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(image: AssetImage("images/logo1shayrana.jpg")),
              SizedBox(height: 30,),
                RoundButton(
                    title: "Login",
                    onPress: (){
                      Navigator.push(
                          context,MaterialPageRoute(builder: (Context)=> SignInScreen()));
                    }),
                SizedBox(height: 30,),
              RoundButton(title: "Register", onPress: (){
                Navigator.push(
                    context,MaterialPageRoute(builder: (Context)=> SignUpScreen()));
              }),
              SizedBox(height: 50,),
              Text("Developed by- SSG",style: TextStyle(fontSize: 13,fontStyle: FontStyle.italic,fontFamily: 'serif'),)

            ],
          ),
        ),
      ),
    );
  }
}
