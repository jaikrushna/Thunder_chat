import 'package:thunder_chat/Screens/Chat Screen.dart';
import 'package:thunder_chat/Screens/Login screeen.dart';
import 'package:flutter/material.dart';
import 'package:thunder_chat/Padding_button.dart';
import 'package:thunder_chat/Constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:thunder_chat/Pickers/Image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'register';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late String email;
  late String passkey;
  late String name;
  // late Future url;
  // late XFile image;

  final _firestone = FirebaseFirestore.instance;
  bool progress = false;
  FirebaseAuth _auth = FirebaseAuth.instance;
  void signinerror(String error_message) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text('Authentication Failed!'),
              content: Text(error_message),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: Text('Okay'))
              ],
            ));
  }

  // final ImagePicker _picker = ImagePicker();
  // XFile? picked_image;
  // void picked_Image() async {
  //   final XFile? image = await _picker.pickImage(
  //     source: ImageSource.gallery,
  //     imageQuality: 10,
  //   );
  //   if (image != null) {
  //     XFile imageFileGal = XFile(image.path);
  //     setState(() {
  //       picked_image = imageFileGal;
  //     });
  // final ref =
  //     FirebaseStorage.instance.ref().child('Users').child(mail + '.jpg');
  //     // await ref.putFile(File(picked_image!.path)).whenComplete;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: progress,
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Hero(
                    tag: 'logo',
                    child: Container(
                      height: 130.0,
                      child: Image.asset('lib/Icons/thunder_logo.png'),
                    ),
                  ),
                  Image_picker(),
                  // CircleAvatar(
                  //   backgroundImage: picked_image != null
                  //       ? FileImage(File(picked_image!.path))
                  //       : null,
                  //   backgroundColor: Colors.grey,
                  //   radius: 40,
                  // ),
                  // TextButton(
                  //   onPressed: picked_Image,
                  //   child: Row(
                  //     children: [
                  //       SizedBox(
                  //         width: 110.0,
                  //       ),
                  //       Center(child: Icon(Icons.add_a_photo)),
                  //       SizedBox(
                  //         width: 10.0,
                  //       ),
                  //       Center(
                  //         child: Text(
                  //           'Add Image',
                  //           style: TextStyle(color: Colors.blueAccent),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  TextField(
                    style: TextStyle(
                      color: Colors.black87,
                    ),
                    keyboardType: TextInputType.name,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      name = value;
                    },
                    decoration:
                        kInputDecormail.copyWith(hintText: 'Enter your name'),
                  ),
                  SizedBox(
                    height: 7.0,
                  ),
                  TextField(
                    style: TextStyle(
                      color: Colors.black87,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      email = value;
                    },
                    decoration:
                        kInputDecormail.copyWith(hintText: 'Enter your Email'),
                  ),
                  SizedBox(
                    height: 7.0,
                  ),
                  TextField(
                    style: TextStyle(
                      color: Colors.black87,
                    ),
                    obscureText: true,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      passkey = value;
                    },
                    decoration: kInputDecormail.copyWith(
                        hintText: 'Enter your Passkey'),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  padding_button(
                    colour: Colors.blueAccent,
                    OnPressed: () async {
                      try {
                        setState(() {
                          progress = true;
                        });
                        _firestone.collection('user').add({
                          'email': email,
                          'name': name,
                          'passkey': passkey,
                          // 'URL': url,
                        });
                        final newuser =
                            await _auth.createUserWithEmailAndPassword(
                                email: email, password: passkey);
                        if (newuser != null) {
                          Navigator.pushNamed(context, ChatScreen.id);
                        }
                        setState(() {
                          progress = false;
                        });
                        // final ref = FirebaseStorage.instance
                        //     .ref()
                        //     .child('Users/' + email + '.jpg');
                        // .child(email + '.jpg');
                        // ref.putFile(File(picked_image!.path)).whenComplete;
                        // final url = await ref.getDownloadURL();

                      } on HttpException catch (error) {
                        print(error);
                        var error_message = 'Authentication failed';
                        if (error.toString().contains('INVALID_EMAIL')) {
                          error_message = 'Invalid email';
                        }
                        if (error.toString().contains('WEAK_PASSWORD')) {
                          error_message = 'Password is weak, Enter another';
                        }
                        signinerror(error_message);
                        setState(() {
                          progress = false;
                        });
                      } catch (error) {
                        //   final ref = FirebaseStorage.instance
                        //       .ref()
                        //       .child('Users/' + email + '.jpg');
                        //   final url = await ref.getDownloadURL();
                        //   _firestone.collection('user').add({
                        //     'email': email,
                        //     'name': name,
                        //     'passkey': passkey,
                        //     'URL': url,
                        //   });
                        print(error);
                        var error_message =
                            'Authentication failed something went wrong';
                        signinerror(error_message);
                        setState(() {
                          progress = false;
                        });
                      }
                    },
                    Title: 'Register',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
