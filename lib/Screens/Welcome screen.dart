import 'package:thunder_chat/Screens/Login screeen.dart';
import 'package:thunder_chat/Screens/Registration_Screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:thunder_chat/Padding_button.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController control;
  late Animation animate;
  //
  // AnimationController control;
  // Animation animate;
  @override
  void initState() {
    super.initState();
    control = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    control.forward();
    animate =
        ColorTween(begin: Colors.blueGrey, end: Colors.white).animate(control);

    control.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    control.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animate.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('lib/Icons/thunder_logo.png'),
                    height: (control.value) * 100,
                  ),
                ),
                DefaultTextStyle(
                  style: TextStyle(
                    color: Color(0xff071d6d),
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Permanent Marker Regular',
                  ),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText('Thunder'),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            padding_button(
              colour: Colors.lightBlueAccent,
              OnPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
              Title: 'Log In',
            ),
            padding_button(
              colour: Colors.blueAccent,
              OnPressed: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
              Title: 'Register',
            ),
          ],
        ),
      ),
    );
  }
}
