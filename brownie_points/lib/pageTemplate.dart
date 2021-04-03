

import 'package:brownie_points/forms/settingsForm.dart';
import 'package:brownie_points/pages/searchPage.dart';
import 'package:brownie_points/pages/createRecipe.dart';
import 'package:brownie_points/pages/myRecipesPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageTemplate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "please god",
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: NavBar(),
      debugShowCheckedModeBanner: false,
      showSemanticsDebugger: false,
    );
  }
}

class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _currentIndex = 2;

  final tabNames = [
    "Search",
    "My Recipes",
    "New Recipe",
    "Profile"
  ];

  final tabs = [
    SearchPageForm(),
    MyPageForm(),
    CreateRecipe(),
    SettingsForm(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: Text(tabNames[_currentIndex]),
      ),
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items:[
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Search",
            backgroundColor: Colors.deepPurple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "My Recipes",
            backgroundColor: Colors.deepPurple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: "Create",
            backgroundColor: Colors.deepPurple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Profile",
            backgroundColor: Colors.deepPurple,
          ),
        ],
        onTap: (index) {
          setState((){
            setState(() {
              _currentIndex = index;
            });
          });
        }
      ),
    );
  }
}


