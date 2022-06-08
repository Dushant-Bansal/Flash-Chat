import 'package:flutter/material.dart';
import 'package:flash_chat/screen/welcome_screen.dart';
import 'package:flash_chat/screen/login.dart';
import 'package:flash_chat/screen/register.dart';
import 'package:flash_chat/screen/start.dart';
import 'package:flash_chat/screen/chat.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

final _auth = FirebaseAuth.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const FlashChat());
}

class FlashChat extends StatelessWidget {
  const FlashChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      initialRoute: _auth.currentUser == null ? '/' : '/chat',
      routes: {
        '/': (context) => WelcomeScreen(),
        '/start': (context) => const Start(),
        '/login': (context) => const Login(),
        '/register': (context) => const Register(),
        '/chat': (context) => const Chat(),
      },
    );
  }
}
