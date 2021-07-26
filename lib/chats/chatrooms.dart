import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class ChatRooms extends StatefulWidget {
  static const String id = 'chat_rooms';

  @override
  _ChatRoomsState createState() => _ChatRoomsState();
}

class _ChatRoomsState extends State<ChatRooms> {
  var user = FirebaseAuth.instance.currentUser;


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection("users").doc(user!.uid)
              .snapshots(),
          builder: (context, snapshot){
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            List<dynamic> chatRooms = snapshot.data!['chats'];
            for(int i = 0; i<chatRooms.length;i++){
              print(chatRooms[i]['displayName']);
            }
            return ListView.builder(itemCount:chatRooms.length,itemBuilder: (BuildContext context, int index){
              return Card(
                color: Color(0xFFCFE0F8),
                shadowColor: Color(0xFFD70988),
                elevation: 3,
                child: Padding(
                  padding: EdgeInsets.all(4.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(chatRooms[index]['displayName'],style: GoogleFonts.overlock(
                              fontSize: 16.sp,
                              color: Color(0xFF1B52AF),
                              fontWeight: FontWeight.w600),),
                          SizedBox(height: 0.5.h,),
                          Text(chatRooms[index]['userName'],style: GoogleFonts.overlock(
                              fontSize: 12.sp,
                              color: Color(0xFFD70988),
                              fontWeight: FontWeight.w600),),
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios,size: 3.h,color:  Color(0xFFD70988),)
                    ],
                  )
                ),
              );
            });
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: () {
         // Navigator.pushNamed(context, SearchList.id);
        },
      ),
    );
  }
}
