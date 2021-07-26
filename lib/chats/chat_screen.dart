import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_morse_util/morse_util.dart';
import 'package:yeah/Theme/constants.dart';
import 'package:yeah/widgets/text_widgets.dart';

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';
   final String displayName;
   final String to;
   final String from;
   final String chatId;
  ChatScreen(this.to, this.from, this.displayName,this.chatId,);
  @override
  _ChatScreenState createState() => _ChatScreenState(to: to, from: from, displayName: displayName, chatId: chatId);
}

class _ChatScreenState extends State<ChatScreen> {
  _ChatScreenState({required this.to,required this.from, required this.displayName,required this.chatId});

  String chatId;
  String to;
  String from;
  String displayName;
  final messageTextController = TextEditingController();
  String messageText = "";

  sendMessage() async {
    if (messageTextController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "from": from,
        "message": messageTextController.text,
        'time': DateTime
            .now()
            .millisecondsSinceEpoch,
        'clock': (DateTime.now().hour).toString()+":"+(DateTime.now().minute).toString(),
      };
      await FirebaseFirestore.instance.collection("chats")
          .doc(chatId)
          .collection("messages")
          .add(chatMessageMap).catchError((e){
        print(e.toString());
      });
      setState(() {
        messageTextController.text = "";
      });
    }
  }

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
              MessagesStream(me: from,chatId: chatId,),
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
                        sendMessage();
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

class MessagesStream extends StatelessWidget {

  MessagesStream({ required this.me,required this.chatId});
  final String me;
  final String chatId;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("chats")
          .doc(chatId)
          .collection("messages")
          .orderBy('time')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Expanded(
            child: Center(
              child: CircularProgressIndicator(
                backgroundColor: Color(0xFFD70988),
              ),
            ),
          );
        }
        final messages = snapshot.data!.docs.reversed;
        List<MessageBubble> messageBubbles = [];
        for (var message in messages) {
          final messageText = message["message"];
          final messageSender = message['from'];
          final clock = message['clock'];

          final currentUser = me;

          final messageBubble = MessageBubble(
            text: messageText,
            isMe: currentUser == messageSender,
            clock: clock,
          );

          messageBubbles.add(messageBubble);
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({ required this.text, required this.isMe, required this.clock});

  final String text;
  final bool isMe;
  final String clock;
  MorseUtil _morseUtil = MorseUtil();


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
        isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Material(
            borderRadius: isMe
                ? BorderRadius.only(
                topLeft: Radius.circular(30.0),
                bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0))
                : BorderRadius.only(
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            elevation: 5.0,
            color: isMe ? Color(0xFFEE83C7).withOpacity(0.7) : Color(0xFF719EE2).withOpacity(0.7),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                _morseUtil.encode(text),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5,horizontal: 2),
            child: Text(
              clock,
              style: TextStyle(
                fontSize: 13.0,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

