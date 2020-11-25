// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.


import 'package:brownie_points/pageTemplate.dart';
import 'file:///C:/git/cop4331_big_project_mobile/brownie_points/lib/pages/register.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'pages/forgotPassword.dart';
import 'database/jsonCalls.dart';

void main() {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Brownie Points Login Page',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      debugShowCheckedModeBanner: false,
      showSemanticsDebugger: false,
      home: MyHomePage(title: 'Brownie Points Login')

    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(fontFamily: 'sans-serif', fontSize: 20.0);

    final userNameField = TextField(
      obscureText: false,
      style: style,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        labelText: "Username",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular((32.0))),
      ),
      onChanged: (text) {
        email = text;
      },
    );

    final passwordField = TextField(
      obscureText: true,
      style: style,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        labelText: "Password",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
      onChanged: (text) {
        password = text;
      },
    );

    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.deepPurple,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding:EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {

          JsonCall.login(email, password).then((value) {
            if(value == null)
            {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => pageTemplate()),
              );
            }
            else
            {
              Fluttertoast.showToast(
                msg: value,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.deepPurple,
                fontSize: 16.0
              );
            }
          });

        },
        child: Text("Login",
          textAlign: TextAlign.center,
          style: style.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    final registerButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.deepPurple,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding:EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => register()),
          );
        },
        child: Text("Register",
            textAlign: TextAlign.center,
            style: style.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    final forgotPasswordButton = FlatButton(
        onPressed: () {
          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => forgotPassword()),
          );
        },
        child: Text("Forgot Password?",
            textAlign: TextAlign.left,
            style: style.copyWith(color: Colors.deepPurple, fontWeight: FontWeight.bold, fontSize: 18)),
      );

    return Scaffold(
      appBar: AppBar(
        leading:Container(),
        title: Text("Welcome to Brownie Points"),
      ),
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 45.0),
                  userNameField,
                  SizedBox(height: 25.0),
                  passwordField,
                  SizedBox(height: 1),
                  forgotPasswordButton,
                  SizedBox(height: 1),
                  loginButton,
                  SizedBox(height: 15.0),
                  registerButton,
                  ],
                )
              )
            )
          )
        )
      )
    );
  }
}


/*class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  @override
  final _suggestions = <WordPair>[];
  final _biggerFont = TextStyle(fontSize: 18.0);
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions(){
    return ListView.builder(
      padding: EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) return Divider();
        /*2*/
        final index = i ~/ 2;
        if(index >= _suggestions.length){
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      });
  }

  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
    );
  }
}*/
