import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';

class RoundedButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  const RoundedButton(
      {Key? key, required this.buttonText, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: Material(
        borderRadius: BorderRadius.circular(50.0),
        color: const Color(0xFFFAF4CF),
        child: MaterialButton(
          padding: const EdgeInsets.all(20.0),
          textColor: Colors.black,
          elevation: 5.0,
          onPressed: onPressed,
          child: Text(
            buttonText,
            style: kButtonTextStyle,
          ),
        ),
      ),
    );
  }
}
