//import 'dart:html';

//import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:login/Explor/explore.dart';

import 'package:login/TOP/home.dart';
import 'package:login/post/post.dart';

import 'package:login/profiles/profile.dart';
import 'package:login/profilesnew/profile_2.dart';
import 'package:login/psycho/first.dart';


class AnimatedBottomBar extends StatefulWidget {
  final String uid;
  String users;
   AnimatedBottomBar({super.key,required this.users,required this.uid});

  @override
  _AnimatedBottomBarState createState() => _AnimatedBottomBarState();
}

class _AnimatedBottomBarState extends State<AnimatedBottomBar> {
//  final Screens = [AppBarWidget(),  explore(), PostPage(users: widget.users,),Container(),Container()];

  int index = 0;

  @override
  Widget build(BuildContext context) {   //users: widget.users,
    final Screens = [AppBarWidget(),explore(users: widget.users, uid: widget.uid), PostPage(users: widget.users),Explores(),ProfileE(User:widget.users ,)];
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Screens[index],
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
          child: GNav(
              selectedIndex: index,
              backgroundColor: Color.fromARGB(255, 248, 245, 245),
              color: Color.fromARGB(255, 94, 105, 113),
              activeColor: const Color(0xFF3398DB),
              tabBackgroundColor: Color.fromARGB(199, 203, 202, 202),
              onTabChange: (index) => setState(() => this.index = index),
              padding: EdgeInsets.all(8),
              gap: 8,
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.search,
                  text: 'Explore',
                ),
                GButton(
                  icon: Icons.add_circle_outline,
                  text: 'Post',
                ),
                GButton(
                  icon: Icons.reorder,
                  text: 'Meet',
                ),
                GButton(
                  icon: Icons.person,
                  text: 'Profile',
                ),
                
              ]),
        ),
      ),
    );
  }
}
