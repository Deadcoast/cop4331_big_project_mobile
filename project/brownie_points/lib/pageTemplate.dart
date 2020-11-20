

import 'package:brownie_points/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class pageTemplate extends StatelessWidget {
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
  @override

  int _currentIndex = 2;

  final tabNames = [
    "Favorites",
    "Search",
    "New Recipe",
    "Profile"
  ];

  final tabs = [
    Center(child:Text("Favorites")),
    Center(child:Text("Search")),
    Center(child:Text("New Recipe")),
    profilePage(),
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(tabNames[_currentIndex]),
      ),
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items:[
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            title: Text("Favorites"),
            backgroundColor: Colors.deepPurple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text("Search"),
            backgroundColor: Colors.deepPurple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            title: Text("Create"),
            backgroundColor: Colors.deepPurple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text("Profile"),
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

class profilePage extends StatefulWidget {
  @override
  _profilePageState createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {

  bool state = false;
  TextStyle style = TextStyle(fontFamily: 'sans-serif', fontSize: 20.0);

  final _firstNameLastName = Text(
    "Rick Leinicker",
    textAlign:TextAlign.left,
    style: TextStyle(fontFamily: 'sans-serif', fontSize: 40.0),
  );
  final _username = Text(
    "RickL",
    textAlign:TextAlign.left,
    style: TextStyle(fontFamily: 'sans-serif', fontSize: 20.0, fontStyle: FontStyle.italic),
  );
  final _email = Text(
    "rickL@cop4331.com",
    textAlign:TextAlign.left,
    style: TextStyle(fontFamily: 'sans-serif', fontSize: 20.0),
  );


  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(),
          child: Center(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                  SizedBox(height: 45.0),
                  _firstNameLastName,
                  SizedBox(height: 25.0),
                  _username,
                  SizedBox(height: 15),
                  _email,
                  SizedBox(height: 15.0),
                  SwitchListTile(
                    title: Text("Metric Measurements"),
                    value: state,
                    onChanged: (value){
                      setState(() {state = value;});
                      },
                    ),
                Material(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.deepPurple,
                  child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width/3,
                    padding:EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(context,  MaterialPageRoute(builder: (context) => MyHomePage()));
                      },
                    child: Text("Logout",
                        textAlign: TextAlign.left,
                        style: style.copyWith(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
