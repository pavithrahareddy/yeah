import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:yeah/Theme/constants.dart';
import 'package:yeah/authentication/login.dart';
import 'package:yeah/chats/chat_list.dart';
import 'package:yeah/learn/learn_screen.dart';
import 'package:yeah/scanner/scan_screen.dart';
import 'package:yeah/widgets/text_widgets.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static List<Widget> _widgetOptions = <Widget>[
    ChatList(),
    ScanScreen(),
    LearnScreen(),
  ];

  void handleClick(int item) {
    switch (item) {
      case 0:

        FirebaseAuth.instance.signOut();
        Navigator.pushNamedAndRemoveUntil(context, LoginScreen.id, (route) => false);
        break;
      case 1:
        print("hey");
        break;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(8.h),
        child: AppBar(
          elevation: 5,
          centerTitle: true,
          title: Padding(
              padding:EdgeInsets.only(top: 1.5.h,),child: SmallLogo()),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: appBarGradient,
            ),
          ),
          actions: [
            PopupMenuButton<int>(
              elevation: 5,
              offset: Offset(0, 4.h),
              padding: EdgeInsets.only(top: 1.h),
              icon: Icon(Icons.more_vert,size: 4.h,),
              onSelected: (item) => handleClick(item),
              itemBuilder: (context) => [
                PopupMenuItem<int>(value: 0, child: Text('Logout',style: subHeadingStyle)),
              ],
            ),
          ],
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.white,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundGradient: appBarGradient,
              color: Color(0xFFEC0DCE),
              tabs: [
                GButton(
                  icon: Icons.chat,
                  text: 'Chats',
                ),
                GButton(
                  icon: Icons.qr_code_scanner,
                  text: 'Scan',
                ),
                GButton(
                  icon: Icons.school,
                  text: 'Learn',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}


