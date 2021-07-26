import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:yeah/Theme/constants.dart';
import 'package:yeah/widgets/text_widgets.dart';

final _firestore = FirebaseFirestore.instance;

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';
   final String displayName;
   final String to;
   final String from;
  ChatScreen(this.to, this.from, this.displayName);
  @override
  _ChatScreenState createState() => _ChatScreenState(to: to, from: from, displayName: displayName);
}

class _ChatScreenState extends State<ChatScreen> {
  _ChatScreenState({required this.to,required this.from, required this.displayName});

  String to;
  String from;
  String displayName;
  final messageTextController = TextEditingController();
  String messageText = "";

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: H3Heading(text:displayName,),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: appBarGradient,
          ),
        ),
      ),
      body: SafeArea(
        child: Material(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              // MessagesStream(to: to,from: from,),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Color(0xFFEC0DCE), width: 2.0),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        controller: messageTextController,
                        onChanged: (value) {
                          messageText = value;
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                          hintText: 'Type your message here...',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                      },
                      child: Icon(Icons.send,color: Color(0xFFEC0DCE),)
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

