import 'package:flutter/material.dart';
import 'package:thunder_chat/Screens/Welcome screen.dart';
import 'package:thunder_chat/Screens/Login screeen.dart';
import 'package:thunder_chat/Screens/Registration_Screen.dart';
import 'package:thunder_chat/Screens/Chat Screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

// void main() => runApp(FlashChat());
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FlashChat());
}

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) => MaterialApp(
          theme: ThemeData.dark().copyWith(
            textTheme: TextTheme(
              bodyText1: TextStyle(color: Colors.black54),
            ),
          ),
          initialRoute: WelcomeScreen.id,
          routes: {
            WelcomeScreen.id: (context) => WelcomeScreen(),
            LoginScreen.id: (context) => LoginScreen(),
            RegistrationScreen.id: (context) => RegistrationScreen(),
            ChatScreen.id: (context) => ChatScreen(),
          }),
    );
  }
}
