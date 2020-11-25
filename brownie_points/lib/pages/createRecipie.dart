import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
