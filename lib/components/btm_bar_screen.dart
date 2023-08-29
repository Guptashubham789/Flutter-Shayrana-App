import 'package:flutter/material.dart';
import 'package:shayrana/screens/follow_screen.dart';

import 'package:shayrana/screens/home_screen.dart';
import 'package:shayrana/screens/sad_shayari_screen.dart';
import 'package:shayrana/screens/user_profile_screen.dart';



class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  int _selectedIndex=0;
  final List _pages=[
    const HomeScreen(),
    const SadShayriScreen(),
    const FollowScreen(),
    const UserProfileScreen()

  ];

  void _selectedPage(int index){
    setState((){
      _selectedIndex=index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue[50],
        type:BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap:_selectedPage,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outlined),
            label: "Love",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.heart_broken),
            label: "Sad",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cast_connected),
            label: "Follow",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined),
            label: "Profile",
          ),

        ],
      ),
    );
  }
}
