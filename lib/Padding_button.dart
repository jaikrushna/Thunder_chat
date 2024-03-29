import 'package:flutter/material.dart';

class padding_button extends StatelessWidget {
  final Color colour;
  final VoidCallback OnPressed;
  final String Title;
  padding_button({
    required this.colour,
    required this.OnPressed,
    required this.Title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: colour,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: OnPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(Title),
        ),
      ),
    );
  }
}
