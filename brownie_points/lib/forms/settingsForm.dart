import 'package:brownie_points/database/jsonCalls.dart';
import 'package:brownie_points/database/savePrefs.dart';
import 'package:brownie_points/main.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  static final formKey = GlobalKey<FormState>();
  TextEditingController firstName;
  static String first;
  TextEditingController lastName;
  static String last;
  TextEditingController userName;
  static String user;
  TextEditingController email;
  static String e;
  bool metric;

  @override void initState() {
    super.initState();
  }

  @override void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: FutureBuilder<Map<String, String>>(
        future: EditPreferences.fetchProfileInfo(),
        builder: (BuildContext context, AsyncSnapshot<Map<String, String>> snapshot)
          {
            if(snapshot.hasData) {
              if(metric == null)
                metric = snapshot.data['metric'] == 'metric';
              Map<String, String> data = snapshot.data;
              return Column(children: [..._getFields(data['first'], data['last'], data['username'], data['email'], data['metric'] == 'true')]);
            }

              return Icon(Icons.error);
          }
      )
    );
  }

  List<Widget> _getFields(String firstN, String lastN, String userN, String emailS, bool isMetric){
    List<Widget> fields = List<Widget>();
    fields.add(
      Row(
        children: [
          Expanded(child: TextFormField(
            controller: firstName,
            initialValue: firstN,
            decoration: InputDecoration(
              labelStyle: TextStyle(fontSize: 24),
              helperText: "First Name",
            ),
            onChanged: (v) => first = v,
            validator: (v) {
              if(v == null)
                return null;
              else if(v.trim().isEmpty)
                return "Please enter a first name";
              else
                return null;
            }
          )),
          Expanded(child: TextFormField(
            controller: lastName,
            initialValue: lastN,
            decoration: InputDecoration(
              labelStyle: TextStyle(fontSize: 24),
              helperText: "Last Name",
            ),
            onChanged: (v) => last = v,
              validator: (v) {
                if(v == null)
                  return null;
                else if(v.trim().isEmpty)
                  return "Please enter a last name";
                else
                  return null;
              }
          ))
        ],
      )
    );

    fields.add(
        TextFormField(
          controller: userName,
          initialValue: userN,
          decoration: InputDecoration(
            labelStyle: TextStyle(fontSize: 12),
            helperText: "Username",
          ),
          onChanged: (v) => user = v,
          validator: (v) {
            if(v == null)
              return null;
            else if(v.trim().isEmpty)
              return "Please enter a username";
            else
              return null;
          }
        )
    );
    fields.add(
        TextFormField(
          controller: email,
          initialValue: emailS,
          decoration: InputDecoration(
            labelStyle: TextStyle(fontSize: 16),
            helperText: "E-mail",
          ),
          onChanged: (v) => e = v,
            validator: (v) {
              if(v == null)
                return null;
              else if(v.trim().isEmpty|| !EmailValidator.validate(v))
                return "Please enter a valid email address";
              else
                return null;
            }
        )
    );
    fields.add(
        SwitchListTile(
          title: Text("Metric Measurements"),
          value: metric,
          onChanged: (value){
            setState(() {metric = value;});
          },
        )
    );
    fields.add(
      ButtonBar(
        children:[
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
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
            ),
          ),
          Material(
            borderRadius: BorderRadius.circular(30.0),
            color: Colors.deepPurple,
            child: MaterialButton(
              minWidth: MediaQuery.of(context).size.width/3,
              padding:EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
              onPressed: () {
                if(formKey.currentState.validate()) {
                  String response;
                  JsonCall.updateUserInfo(first, last, e, user, metric).then((v) => response =  v);
                  if(response == null)
                    Fluttertoast.showToast(
                        msg: "Settings change successful!",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.deepPurple,
                        fontSize: 16.0
                    );
                  else
                    Fluttertoast.showToast(
                        msg: response,
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.deepPurple,
                        fontSize: 16.0
                    );
                }
              },
              child: Text("Save Changes",
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
            ),
          ),
        ]
      )
    );
    return fields;
  }
}
