import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/components/RoundedButton.dart';

class Start extends StatelessWidget {
  const Start({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF303030),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Hero(
            tag: 'icon',
            child: Icon(
              Icons.chat,
              color: const Color(0xFFFAF4CF),
              size: MediaQuery.of(context).size.width / 2,
            ),
          ),
          const Text(
            'Flash Chat',
            style: kTitleStyle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20.0),
          RoundedButton(
            buttonText: 'Login',
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
          ),
          RoundedButton(
            buttonText: 'Register',
            onPressed: () {
              Navigator.pushNamed(context, '/register');
            },
          )
        ],
      ),
    );
  }
}
