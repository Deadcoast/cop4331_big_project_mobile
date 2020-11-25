import 'package:brownie_points/database/jsonCalls.dart';
import 'package:brownie_points/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class forgotPassword extends StatelessWidget {
  String username = "";
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(fontFamily: 'sans-serif', fontSize: 20.0);
    final rememberField = TextField(
      obscureText: false,
      style: style,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        labelText: "Enter e-mail",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
      onChanged: (text) {
        email = text;
        setState() {
          email;
        }
      },
    );

    final usernameField = TextField(
      obscureText: false,
      style: style,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        labelText: "Enter Username",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
      onChanged: (text) {
        username = text;
        setState() {
          username;
        }
      },
    );

    final newPassField = TextField(
      obscureText: false,
      style: style,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        labelText: "Enter New Password",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
      onChanged: (text) {
        password = text;
        setState() {
          password;
        }
      },
    );

    final sendEmailButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.deepPurple,
      child: MaterialButton(
        padding:EdgeInsets.fromLTRB(10.0, 15.0, 15.0, 15.0),
        onPressed: () {
          JsonCall.resetPassword(username, email, password).then((value) {
            if(value == null) {
              Fluttertoast.showToast(
                msg: "Verification email sent.",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.deepPurple,
                fontSize: 16.0
              );
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage()),
              );
            }
            else
            {
              Fluttertoast.showToast(
                  msg: value,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.deepPurple,
                  fontSize: 16.0);
            }
          });
        },
        child: Text("Send recovery e-mail",
            textAlign: TextAlign.left,
            style: style.copyWith(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16.0)),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(),
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  rememberField,
                  SizedBox(height: 15.0),
                  usernameField,
                  SizedBox(height: 15.0),
                  newPassField,
                  SizedBox(height: 15.0),
                  sendEmailButton
                ]),
            ),
          ),
        ),
      )
    );
  }
}