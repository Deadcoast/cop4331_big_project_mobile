import 'package:brownie_points/main.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../database/jsonCalls.dart';

class RegisterForm extends StatefulWidget {
  @override
  RegisterFormState createState() => RegisterFormState();
}

class RegisterFormState extends State<RegisterForm> {
  static final formKey = GlobalKey<FormState>();
  TextEditingController firstName;
  static String first;
  TextEditingController lastName;
  static String last;
  TextEditingController userName;
  static String user;
  TextEditingController email;
  static String e;
  TextEditingController password;
  static String pass;
  static bool metric = false;

  @override void initState() {
    super.initState();
    firstName = TextEditingController();
    lastName = TextEditingController();
    userName = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
  }

  @override void dispose() {
    super.dispose();
    firstName.dispose();
    lastName.dispose();
    userName.dispose();
    email.dispose();
    password.dispose();
  }

  @override
  Widget build(BuildContext context) {
  TextStyle style = TextStyle(fontFamily: 'sans-serif', fontSize: 20.0);

    return Form(
      key: formKey,
      child: Scaffold(
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
                    TextFormField(
                      controller: firstName,
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
                      validator: (v) {
                        if(v == null || v.trim().isEmpty)
                          return " ";
                        return null;
                      },
                    ),
                    SizedBox(height: 15.0),
                    TextFormField(
                      controller: lastName,
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
                        validator: (v) {
                          if(v == null || v.trim().isEmpty)
                            return " ";
                          return null;
                        }
                    ),
                    SizedBox(height: 15.0),
                    TextFormField(
                      controller: userName,
                      obscureText: false,
                      style: style,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        labelText: "Username",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                      ),
                      onChanged: (u) {
                        user = u;
                      },
                      validator: (v) {
                        if(v == null || v.trim().isEmpty)
                          return " ";
                        return null;
                      }
                    ),
                    SizedBox(height: 15.0),
                    TextFormField(
                      controller: password,
                      obscureText: true,
                      style: style,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        labelText: "Password",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                      ),
                      onChanged: (p) {
                        pass = p;
                      },
                      validator: (v) {
                        if(v == null || v.trim().isEmpty)
                          return " ";
                        return null;
                      }
                    ),
                    SizedBox(height: 15.0),
                    TextFormField(
                      controller: email,
                      obscureText: false,
                      style: style,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        labelText: "E-mail",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                      ),
                      onChanged: (mail) {
                        e = mail;
                      },
                      validator: (v) {
                        if(v == null || v.trim().isEmpty || !EmailValidator.validate(v))
                          return " ";
                        return null;
                      }
                    ),
                    SizedBox(height: 15.0),
                    Checkbox(),
                    SizedBox(height: 15.0),
                    ElevatedButton(
                      child: Text('Register'),
                      onPressed: () {
                        if(formKey.currentState.validate())
                          JsonCall.register(user, pass, e, first, last, metric).then((value) {
                            if(value == null)
                            {
                              Fluttertoast.showToast(
                                  msg: "Please check your email for verification",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.deepPurple,
                                  fontSize: 16.0
                              );
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
      )
    );
  }
}

class Checkbox extends StatefulWidget {
  @override
  _CheckboxState createState() => _CheckboxState();
}

class _CheckboxState extends State<Checkbox> {
  @override
  Widget build(BuildContext context) {

    return SwitchListTile(
      title: Text("Metric Measurements"),
      value: RegisterFormState.metric,
      onChanged: (value){
        setState(() {
          RegisterFormState.metric = value;
        });
      },
    );
  }
}


