import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/components/RoundedButton.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(),
          Hero(
            tag: 'icon',
            child: Icon(
              Icons.chat,
              color: const Color(0xFFFAF4CF),
              size: MediaQuery.of(context).size.width,
            ),
          ),
          Flexible(
            child: Row(
              children: [
                const SizedBox(
                  width: 25.0,
                ),
                Flexible(
                  child: AnimatedTextKit(totalRepeatCount: 1, animatedTexts: [
                    TypewriterAnimatedText(
                      'It\'s easy talking to your friends with FlashChat',
                      textStyle: kTitleStyle,
                      speed: const Duration(milliseconds: 50),
                    )
                  ]),
                ),
                const SizedBox(
                  width: 25.0,
                ),
              ],
            ),
          ),
          RoundedButton(
              buttonText: 'Get Started',
              onPressed: () {
                Navigator.pushNamed(context, '/start');
              }),
          const SizedBox(),
        ],
      ),
    );
  }
}
