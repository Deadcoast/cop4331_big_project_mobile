

import 'package:brownie_points/main.dart';
import 'package:brownie_points/savePrefs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  int _currentIndex = 2;

  final tabNames = [
    "Search",
    "My Recipes",
    "New Recipe",
    "Profile"
  ];

  final tabs = [
    Center(child:Text("Search")),
    Center(child:Text("My Recipes")),
    createRecipe(),
    profilePage(),
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

class profilePage extends StatefulWidget {
  @override
  _profilePageState createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {

  bool state = false;
  TextStyle style = TextStyle(fontFamily: 'sans-serif', fontSize: 20.0);




  Widget build(BuildContext context) {

    Future<Map<String, String>> profileInfo = EditPreferences.fetchProfileInfo();

    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder<Map<String, String>>(
          future: profileInfo,
          builder: (BuildContext context, AsyncSnapshot<Map<String, String>> snapshot)
          {
            List<Widget> children;
            if (snapshot.hasData) {
              var data = snapshot.data;
              children = createProfileInfo(data['username'], data['email'], data['first'], data['last'], data['metric']);
            }
            else if (snapshot.hasError) {
              children = <Widget>[
                Icon(
                  Icons.error,
                  size: 60,
                )
              ];
            } else {
              children = <Widget>[
                Icon(
                  Icons.alarm,
                  size: 60,
                )
              ];
            }
            return ConstrainedBox(
              constraints: BoxConstraints(),
              child: Center(
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(36.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: children,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }


  List<Widget> createProfileInfo(String username, String email, String first, String last, String metric)
  {
    final _firstNameLastName = Text(
      first + " " + last,
      textAlign:TextAlign.left,
      style: TextStyle(fontFamily: 'sans-serif', fontSize: 40.0),
    );
    final _username = Text(
      username,
      textAlign:TextAlign.left,
      style: TextStyle(fontFamily: 'sans-serif', fontSize: 20.0, fontStyle: FontStyle.italic),
    );
    final _email = Text(
      email,
      textAlign:TextAlign.left,
      style: TextStyle(fontFamily: 'sans-serif', fontSize: 20.0),
    );

    return <Widget>[
      SizedBox(height: 45.0),
      _firstNameLastName,
      SizedBox(height: 25.0),
      _username,
      SizedBox(height: 15),
      _email,
      SizedBox(height: 15.0),
      SwitchListTile(
        title: Text("Metric Measurements"),
        value: metric == 'true',
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
    ];
  }
}

class createRecipe extends StatefulWidget {
  @override
  _createRecipeState createState() => _createRecipeState();
}

class _createRecipeState extends State<createRecipe> {
  String title = "";
  int count = 1;
  int stepC = 1;

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(fontFamily: 'sans-serif', fontSize: 20.0);
    List<Widget> ingredients = new List.generate(count, (int i) => new ingredientField());
    List<Widget> steps = new List.generate(stepC, (int i) => new stepsField());

    final titleField = TextField(
      obscureText: false,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        labelText: "Title",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular((32.0))),
      ),
      onChanged: (text) {
        title = text;
      },
    );

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            titleField,
            Container(
              height: MediaQuery.of(context).size.height * .3,
              child: new ListView(
                children: steps,
                scrollDirection: Axis.vertical,
              ),
            ),
            Container(
              alignment: Alignment.bottomRight,
              child: FlatButton(
                child: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      stepC++;
                    });
                  }
              )
            ),
            Container(
              height: MediaQuery.of(context).size.height * .3,
              child: new ListView(
                children: ingredients,
                scrollDirection: Axis.vertical,
              )
            ),
            Container(
              alignment: Alignment.bottomRight,
              child: FlatButton(
                child: Icon(Icons.add),
                onPressed: () {
                  setState(() {
                    count++;
                  });
                }
              )
            ),
            Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(30.0),
              color: Colors.deepPurple,
              child: MaterialButton(
                minWidth: MediaQuery.of(context).size.width,
                padding:EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                onPressed: () {
                  //TODO: Implement create recipe into the API
                },
                child: Text("Create Recipe",
                    textAlign: TextAlign.center,
                    style: style.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            )
          ],
        )
      )
    );
  }
}

class stepsField extends StatefulWidget {
  @override
  _stepsFieldState createState() => _stepsFieldState();
}

class _stepsFieldState extends State<stepsField> {
  String step = "";

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText:"Step",
      )
    );
  }
}


class ingredientField extends StatefulWidget {
  @override
  _ingredientFieldState createState() => _ingredientFieldState();
}

class _ingredientFieldState extends State<ingredientField> {

  String unit = 'g';

  @override
  Widget build(BuildContext context) {


    return Row(
      children: [
        Container(
          width:MediaQuery.of(context).size.width * .60,
          child:TextFormField(
            decoration: InputDecoration(
              labelText: "Ingredient",
            ),
          ),
        ),
        Container(
          width:MediaQuery.of(context).size.width * .23,
          child: TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText:"Amount",
              )
          ),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          child: DropdownButton(
            value: unit,
            icon: Icon(Icons.arrow_downward_rounded),
            iconSize: 16,
            onChanged: (val){
              unit = val;
              setState(() {
                unit;
              });
            },
            items: <String>['g', 'kg', 'l', 'ml'].map<DropdownMenuItem<String>>((String value){
              return DropdownMenuItem<String>(
                value:value,
                child: Text(value)
              );
            }).toList(),
          )
        ),
      ],
    );
  }
}


