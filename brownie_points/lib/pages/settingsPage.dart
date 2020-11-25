import 'package:brownie_points/database/savePrefs.dart';
import 'package:brownie_points/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

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
    String name;
    if (first == null && last == null)
      name = "No name";
    else if(first == null)
      name = last;
    else if(last == null)
      name = first;
    else
      name = first + " " + last;
    final _firstNameLastName = Text(
      name,
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
