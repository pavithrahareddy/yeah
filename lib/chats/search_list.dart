import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yeah/Theme/constants.dart';
import 'package:sizer/sizer.dart';

class SearchList extends StatefulWidget {
  static const String id = 'search_list';

  @override
  _SearchListState createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  var user = FirebaseAuth.instance.currentUser;
  List searchList = [];
  TextEditingController search = new TextEditingController();
  bool load = false;
  bool haveUserSearched = false;

  loading() {
    setState(() {
      load = !load;
    });
  }

  searchUsername() async {
    if (search.text.isNotEmpty) {
      loading();
      searchList.clear();
      QuerySnapshot searchedUsers = await FirebaseFirestore.instance
          .collection("users")
          .where('username', isEqualTo: search.text)
          .get();
      for (int i = 0; i < searchedUsers.docs.length; i++) {
        var user = searchedUsers.docs[i];
        searchList.add([user['username'],user['name']]);
      }
      print(searchList);
      loading();
    }
  }


  // sendMessage(String userName){
  //   List<String> users = [Constants.myName,userName];
  //
  //   String chatRoomId = getChatRoomId(Constants.myName,userName);
  //
  //   Map<String, dynamic> chatRoom = {
  //     "users": users,
  //     "chatRoomId" : chatRoomId,
  //   };
  //
  //   databaseMethods.addChatRoom(chatRoom, chatRoomId);
  //
  //   Navigator.push(context, MaterialPageRoute(
  //       builder: (context) => Chat(
  //         chatRoomId: chatRoomId,
  //       )
  //   ));
  //
  // }

  Widget userCard(String userName,String displayName) {
    return Card(
      elevation: 6,
      child: Padding(
        padding: EdgeInsets.all(3.w),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  displayName,
                  style: GoogleFonts.overlock(
                      fontSize: 16.sp,
                      color: Color(0xFF1B52AF),
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  "@"+userName,
                  style: GoogleFonts.overlock(
                      fontSize: 12.sp,
                      color: Color(0xFFD70988),
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                // sendMessage(userName);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                    gradient: appBarGradient,
                    borderRadius: BorderRadius.circular(24)),
                child: Text(
                  "Message",
                  style: GoogleFonts.overlock(
                      fontSize: 14.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3.w),
      child: Column(
        children: [
          Container(
            padding:
                EdgeInsets.only(left: 5.w, right: 5.w, top: 2.w, bottom: 2.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF0C5DD7).withOpacity(0.8),
                    Color(0xFFEC0DCE).withOpacity(0.8),
                  ],
                )),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    cursorColor: Colors.white,
                    controller: search,
                    style: GoogleFonts.overlock(
                        fontSize: 14.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                    decoration: InputDecoration(
                        hintText: "Enter username to search",
                        hintStyle: GoogleFonts.overlock(
                            fontSize: 14.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                        border: InputBorder.none),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    searchUsername();
                  },
                  child: Icon(
                    Icons.person_search_outlined,
                    color: Colors.white,
                    size: 4.h,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 3.h,
          ),
          load
              ? Container(
                  padding: EdgeInsets.only(top: 5.h),
                  width: 100.w,
                  height: 20.h,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: searchList.length,
                  itemBuilder: (context, index) {
                    return userCard(
                      searchList[index][0],
                      searchList[index][1],
                    );
                  })
        ],
      ),
    );
  }
}