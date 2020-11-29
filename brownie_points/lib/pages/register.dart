import 'package:brownie_points/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../database/jsonCalls.dart';

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(fontFamily: 'sans-serif', fontSize: 20.0);

    String first = "";
    String last = "";
    String password = "";
    String username = "";
    String email = "";
    bool metric = false;

    final registerFirstField = TextField(
        obscureText: false,
        style: style,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          labelText: "First Name",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        ),
      onChanged: (name) {
          first = name;
      },
    );

    final registerLastField = TextField(
        obscureText: false,
        style: style,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          labelText: "Last Name",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        ),
        onChanged: (name) {
          last = name;
        },
    );

    final registerUsernameField = TextField(
        obscureText: false,
        style: style,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          labelText: "Username",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        ),
        onChanged: (user) {
          username = user;
        },
    );

    final registerPasswordField = TextField(
        obscureText: true,
        style: style,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          labelText: "Password",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        ),
        onChanged: (pass) {
          password = pass;
        },
    );

    final registerEmailField = TextField(
        obscureText: false,
        style: style,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          labelText: "E-mail",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        ),
        onChanged: (mail) {
          email = mail;
        },
    );

    final metricField = CheckboxListTile(
      value: metric,
      onChanged: ((value) => metric = value),
      title: Text("Metric")
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Register page'),
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(),
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Column(
                children: <Widget>[
                  registerFirstField,
                  SizedBox(height: 15.0),
                  registerLastField,
                  SizedBox(height: 15.0),
                  registerUsernameField,
                  SizedBox(height: 15.0),
                  registerPasswordField,
                  SizedBox(height: 15.0),
                  registerEmailField,
                  SizedBox(height: 15.0),
                  metricField,
                  SizedBox(height: 15.0),
                  ElevatedButton(
                    child: Text('Register'),
                    onPressed: () {
                      //TODO: Implement checks for register
                        JsonCall.register(username, password, email, first, last, metric).then((value) {
                        if(value == null)
                        {
                          Navigator.pop(context);
                          Navigator.push(context,MaterialPageRoute(builder: (context) => MyHomePage()),);
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


