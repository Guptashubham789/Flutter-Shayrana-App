import 'package:flutter/material.dart';
import 'package:shayrana/components/round_button.dart';
import 'package:shayrana/screens/user_notification_screen.dart';
import 'package:url_launcher/url_launcher.dart';
class FollowScreen extends StatefulWidget {
  const FollowScreen({super.key});

  @override
  State<FollowScreen> createState() => _FollowScreenState();
}

class _FollowScreenState extends State<FollowScreen> {
  _launchURL() async {
    final Uri url = Uri.parse('https://www.instagram.com/shayrana_so/');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(child: Text("Follow Me Instagram",style: TextStyle(color: Colors.black87,fontFamily: 'serif'))),
        backgroundColor: Colors.blue[100],
        actions: [
          IconButton(onPressed: (){
            Navigator.push(
                context,MaterialPageRoute(builder: (Context)=> UserNotificationScreen()));
          }, icon: Icon(Icons.mark_unread_chat_alt_outlined,color: Colors.black87,)),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Card(
                color: Colors.blue[50],
                elevation: 6.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: SizedBox(
                  height: 580,
                  child: Column(
                    children: [
                      Image(image: AssetImage("images/accountpic.jpg")),
                      Image(image: AssetImage("images/accountpic1.jpg")),
                      SizedBox(height: 20,),
                      Padding(
                          padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Text("Contact By - sg731159@gmail.com",style: TextStyle(fontSize: 14,fontFamily: 'serif'),)
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          color: Colors.blue[100],
                          child:RoundButton(title: "Follow Me Instagram", onPress:  _launchURL)
                        ),
                      )
                    ],
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );;
  }
}
