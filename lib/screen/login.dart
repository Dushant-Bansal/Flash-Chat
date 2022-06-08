import 'package:flutter/material.dart';
import 'package:flash_chat/components/RoundedButton.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late String email;
  late String password;
  String error = '';
  bool showSpinner = false;

  Widget getSpinner(bool spinner) {
    if (spinner == true) {
      return kSpinkit;
    } else {
      return Container();
    }
  }

  final _auth = FirebaseAuth.instance;
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
                buttonText: 'Login',
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    final user = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/chat');
                  } catch (e) {
                    print(e);
                    setState(() {
                      error = 'Invalid Credentials';
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
              )
            ],
          ),
        ],
      ),
    );
  }
}
