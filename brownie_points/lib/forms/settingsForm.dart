import 'package:brownie_points/database/savePrefs.dart';
import 'package:brownie_points/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    firstName.dispose();
    lastName.dispose();
    userName.dispose();
    email.dispose();
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
              return Column(children: [..._getFields(data['first'], data['last'], data['username'], data['email'], data['metric'] == 'metric')]);
            }

              return Icon(Icons.error);
          }
      )
    );
  }

  List<Widget> _getFields(String firstN, String lastN, String userN, String emailS, bool isMetric){
    List<Widget> fields = List<Widget>();
    print(firstN);
    fields.add(
      Row(
        children: [
          Expanded(child: TextFormField(
            controller: firstName,
            initialValue: firstN,
            decoration: InputDecoration(
              labelStyle: TextStyle(fontSize: 24),
            ),
            onChanged: (v) => first = v,
          )),
          Expanded(child: TextFormField(
            controller: lastName,
            initialValue: lastN,
            decoration: InputDecoration(
              labelStyle: TextStyle(fontSize: 24),
            ),
            onChanged: (v) => last = v,
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
          ),
          onChanged: (v) => user = v,
        )
    );
    fields.add(
        TextFormField(
          controller: email,
          initialValue: emailS,
          decoration: InputDecoration(
            labelStyle: TextStyle(fontSize: 16),
          ),
          onChanged: (v) => e = v,
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
                print("$first $last $e $user $metric");
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
