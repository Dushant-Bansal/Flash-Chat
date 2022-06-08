import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _auth = FirebaseAuth.instance;
final _firestore = FirebaseFirestore.instance;

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  String email = 'User';
  late String text;
  bool isMe = false;

  TextEditingController controller = TextEditingController();
  final loggedInUser = _auth.currentUser;

  void getCurrentUser() async {
    final loggedInUser = this.loggedInUser;
    if (loggedInUser != null) {
      email = loggedInUser.email!;
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: MediaQuery.of(context).size.height * 0.1,
          elevation: 0,
          title: const Text(
            'Flash Chat',
            style: kTitleStyle,
            textAlign: TextAlign.center,
          ),
          backgroundColor: const Color(0xFF303030),
          actions: [
            IconButton(
                onPressed: () {
                  _auth.signOut();
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                icon: const Icon(Icons.logout))
          ],
        ),
        backgroundColor: const Color(0xFF303030),
        body: Container(
          height: MediaQuery.of(context).size.height * 0.9,
          width: double.infinity,
          child: Material(
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(50.0)),
            color: Colors.white,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  StreamBuilder<QuerySnapshot>(
                    stream: _firestore
                        .collection('messages')
                        .orderBy('time')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return const Text('Something went wrong');
                      }
                      try {
                        List<MessageBubble> messageWidgets = [];
                        final messages = snapshot.data!.docs.reversed;
                        for (var message in messages) {
                          String messageSender = message['email'];
                          String messageText = message['message'];
                          final messageTime = message['time'];
                          if (messageSender == loggedInUser!.email) {
                            isMe = true;
                          } else {
                            isMe = false;
                          }
                          messageWidgets.add(MessageBubble(
                              time: messageTime,
                              isMe: isMe,
                              text: messageText,
                              sender: messageSender));
                        }
                        return Flexible(
                          child: ListView(
                            reverse: true,
                            children: messageWidgets,
                          ),
                        );
                      } catch (e) {
                        return const Text(
                          'Error',
                          style: kErrorStyle,
                        );
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Material(
                      color: const Color(0xFFFAF4CF),
                      borderRadius: BorderRadius.circular(25.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: TextField(
                              controller: controller,
                              maxLines: 4,
                              minLines: 1,
                              style: kButtonTextStyle.copyWith(
                                  color: Colors.black, fontSize: 16.0),
                              decoration:
                                  kTextFieldDecoration.copyWith(hintText: ''),
                              onChanged: (value) {
                                text = value;
                              },
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: TextButton(
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                  const EdgeInsets.all(20.0),
                                ),
                                overlayColor: MaterialStateProperty.all(
                                    const Color(0xFFDEEAF5)),
                                shape: MaterialStateProperty.all(
                                  const CircleBorder(
                                    side: BorderSide(
                                        width: 0.0, color: Color(0xFFDEEAF5)),
                                  ),
                                ),
                              ),
                              onPressed: () async {
                                try {
                                  final loggedInUser = this.loggedInUser;
                                  if (loggedInUser != null && text.isNotEmpty) {
                                    _firestore.collection('messages').add(
                                      {
                                        'email': loggedInUser.email,
                                        'message': text,
                                        'time': DateTime.now()
                                            .millisecondsSinceEpoch
                                            .toInt(),
                                      },
                                    );
                                  }
                                } catch (e) {
                                  print(e);
                                }
                                setState(() {
                                  controller.clear();
                                });
                              },
                              child: const Icon(
                                Icons.send,
                                color: Colors.blueAccent,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    Key? key,
    required this.time,
    required this.isMe,
    required this.text,
    required this.sender,
  }) : super(key: key);
  final String text;
  final bool isMe;
  final String sender;
  final int time;

  @override
  Widget build(BuildContext context) {
    String merideim;
    final DateTime date = DateTime.fromMillisecondsSinceEpoch(time);
    int hour = date.hour.toInt();
    if (date.hour >= 12) {
      merideim = 'pm';
      hour = hour - 12;
    } else {
      merideim = 'am';
    }
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: const TextStyle(fontSize: 12, color: Colors.black54),
          ),
          Material(
            borderRadius: const BorderRadius.all(Radius.circular(25.0)),
            elevation: 5.0,
            color: isMe ? const Color(0xFFFAF4CF) : Colors.grey.shade300,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                text,
                style: TextStyle(fontSize: 15.0, color: Colors.black),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text(
              '$hour:${date.minute} $merideim',
              style: const TextStyle(fontSize: 12, color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }
}
