import 'package:flutter/material.dart';
import 'package:flash_chat/components/RoundedButton.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late String email;
  late String password;
  String error = '';
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;

  Widget getSpinner(bool spinner) {
    if (spinner == true) {
      return kSpinkit;
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF303030),
      child: Stack(
        children: [
          getSpinner(showSpinner),
          Column(
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
              Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                child: Material(
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(fontSize: 20.0),
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      email = value;
                    },
                    decoration:
                        kTextFieldDecoration.copyWith(hintText: 'Email'),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                child: Material(
                  child: TextField(
                    obscureText: true,
                    style: const TextStyle(fontSize: 20.0),
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      password = value;
                    },
                    decoration:
                        kTextFieldDecoration.copyWith(hintText: 'Password'),
                  ),
                ),
              ),
              RoundedButton(
                buttonText: 'Register',
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/chat');
                  } catch (e) {
                    print(e);
                    setState(() {
                      error = 'Invalid Input';
                      showSpinner = false;
                    });
                    return;
                  }
                },
              ),
              Text(
                error,
                style: kErrorStyle,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
