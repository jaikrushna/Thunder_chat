import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:thunder_chat/Screens/Chat Screen.dart';
import 'package:thunder_chat/Screens/Registration_Screen.dart';
import 'package:flutter/material.dart';
import 'package:thunder_chat/Padding_button.dart';
import 'package:thunder_chat/Constants.dart';
import 'dart:io';

class LoginScreen extends StatefulWidget {
  static const String id = 'login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String passkey;
  bool progress = false;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: progress,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('lib/Icons/thunder_logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
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
                height: 8.0,
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
                decoration:
                    kInputDecormail.copyWith(hintText: 'Enter your Passkey'),
              ),
              SizedBox(
                height: 24.0,
              ),
              padding_button(
                colour: Colors.lightBlueAccent,
                OnPressed: () async {
                  try {
                    setState(() {
                      progress = true;
                    });
                    final user = await _auth.signInWithEmailAndPassword(
                        email: email, password: passkey);
                    if (user != null) {
                      Navigator.pushNamed(context, ChatScreen.id);
                    }
                    setState(() {
                      progress = false;
                    });
                  } on HttpException catch (error) {
                    var error_message = 'Authentication failed';
                    if (error.toString().contains('EMAIL_EXISTS')) {
                      error_message = 'Email already exits';
                    }
                    if (error.toString().contains('EMAIL_NOT_FOUND')) {
                      error_message = 'Email not found!!';
                    }
                    if (error.toString().contains('INVALID_PASSSWORD')) {
                      error_message = 'Password incorrect!!';
                    }
                    signinerror(error_message);
                  } catch (e) {
                    var error_message = 'Authentication failed';
                    signinerror(error_message);
                  }
                },
                Title: 'Log In',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
