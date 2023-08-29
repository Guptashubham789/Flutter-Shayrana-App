import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../components/round_button.dart';
import '../../toast/toastmsg.dart';
class SadPostScreen extends StatefulWidget {
  const SadPostScreen({super.key});

  @override
  State<SadPostScreen> createState() => _SadPostScreenState();
}

class _SadPostScreenState extends State<SadPostScreen> {

  bool showSpinner=false;
  final postRef=FirebaseDatabase.instance.ref().child('SadPost');
  firebase_storage.FirebaseStorage storage=firebase_storage.FirebaseStorage.instance;
  FirebaseAuth _auth=FirebaseAuth.instance;
  final ImagePicker _picker = ImagePicker();
  TextEditingController titlecontroller=TextEditingController();

  File? _image;

  Future getImage() async{
    final image=await ImagePicker().pickImage(source: ImageSource.gallery);
    if(image==null) return;

    final imageTemporary=File(image.path);
    setState(() {
      this._image=imageTemporary;
    });
  }
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          //automaticallyImplyLeading: false,
          title: Text("Sad Post Upload",style: TextStyle(fontFamily: 'Serif',color: Colors.black87),
          ),
          backgroundColor: Colors.blue[100],

        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Center(
                  child: _image!=null?Image.file(_image!,width: 400,height: 400,fit: BoxFit.cover,):
                  Container(
                    height: 200,
                    width: 200,
                    color: Colors.blue[100],
                    child: InkWell(
                        onTap: (){
                          getImage();
                        },
                        child: Icon(Icons.camera_alt)),
                  ),
                ),
              ),
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
                          maxLines: 4,
                          decoration: InputDecoration(
                            labelText: 'Title',
                            hintText: 'Write the title name',
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
                    title: "Upload",
                    onPress: ()async{
                      setState(() {
                        showSpinner=true;
                      });
                      try{
                        int date=DateTime.now().microsecondsSinceEpoch;
                        firebase_storage.Reference ref=firebase_storage.FirebaseStorage.instance.ref('Sad/shayrana$date');
                        UploadTask uploadTask=ref.putFile(_image!);
                        print(uploadTask);
                        await Future.value(uploadTask);
                        var newUrl=await ref.getDownloadURL();

                        postRef.child('Post List').child(date.toString()).set(
                            {
                              'pId':date.toString(),
                              'pImage':newUrl.toString(),
                              'pTitle':titlecontroller.text.toString(),
                              'pTime':date.toString()
                            }).then((value){
                          toastMessage().toastMassage("Post Published ");
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
