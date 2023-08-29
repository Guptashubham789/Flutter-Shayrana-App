import 'package:flutter/material.dart';
import 'package:shayrana/components/round_button.dart';
import 'package:shayrana/screens/admin/addpost_screen.dart';
import 'package:shayrana/screens/admin/allPost_screen.dart';
import 'package:shayrana/screens/admin/allUser_screen.dart';
import 'package:shayrana/screens/admin/sadPost_screen.dart';
import 'package:shayrana/screens/admin/send_notification_screen.dart';
import 'package:shayrana/screens/admin/users_feedback.dart';
import 'package:shayrana/screens/option_screen.dart';
class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:Center(
          child: Text("Admin Screen",style: TextStyle(fontFamily: 'Serif',color: Colors.black87),),
        ),
        backgroundColor: Colors.blue[100],
        actions: [
          InkWell(
            onTap: (){
              Navigator.push(
                  context,MaterialPageRoute(builder: (Context)=> AddPostScreen()));
            },
              child: Icon(Icons.add,color: Colors.black87,)),
          SizedBox(width: 20,),

        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Text("Welcome To Shayrana App",style: TextStyle(fontFamily: 'serif',fontSize: 16,color: Colors.redAccent),),
              SizedBox(height: 20,),
              RoundButton(
                  title: "Love Post",
                  onPress: (){
                    Navigator.push(
                        context,MaterialPageRoute(builder: (Context)=> AddPostScreen()));
                  }
              ),
              SizedBox(height: 20,),
              RoundButton(
                  title: "Sad Post",
                  onPress: (){
                    Navigator.push(
                        context,MaterialPageRoute(builder: (Context)=> SadPostScreen()));
                  }
              ),
              SizedBox(height: 20,),
              RoundButton(
                  title: "Send Notification",
                  onPress: (){
                    Navigator.push(
                        context,MaterialPageRoute(builder: (Context)=> SendMessageScreen()));
                  }
              ),
              SizedBox(height: 20,),
              RoundButton(
                  title: "All Post",
                  onPress: (){
                    Navigator.push(
                        context,MaterialPageRoute(builder: (Context)=> AllPostScreen()));
                  }
              ),
              SizedBox(height: 20,),
              RoundButton(
                  title: "All Users",
                  onPress: (){
                    Navigator.push(
                        context,MaterialPageRoute(builder: (Context)=> AllUserScreen()));
                  }
              ),

              SizedBox(height: 20,),
              RoundButton(
                  title: "Users Feedback",
                  onPress: (){
                    Navigator.push(
                        context,MaterialPageRoute(builder: (Context)=> UsersFeedback()));
                  }
              ),
              SizedBox(height: 20,),
              RoundButton(
                  title: "Logout",
                  onPress: (){
                    Navigator.push(
                        context,MaterialPageRoute(builder: (Context)=> OptionScreen()));
                  }
              ),
              SizedBox(height: 100,),
              Text("Developed by- SSG",style: TextStyle(fontSize: 13,fontStyle: FontStyle.italic,fontFamily: 'serif'),)
            ],
          ),
        ),
      ),
    );
  }
}
