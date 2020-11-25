import 'package:brownie_points/forms/ingredientForm.dart';
import 'package:brownie_points/forms/stepsForm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateRecipe extends StatefulWidget {
  @override
  _CreateRecipeState createState() => _CreateRecipeState();
}

class _CreateRecipeState extends State<CreateRecipe> {
  String title = "";
  int count = 1;
  int stepC = 1;
  int index = 0;

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(fontFamily: 'sans-serif', fontSize: 20.0);

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
                  child: SingleChildScrollView(
                    child: StepsForm()
                  ),
                ),
                Container(
                  child:SingleChildScrollView(
                    child: IngredientsForm(),
                  ),
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
                      foo(title);
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

  void foo(String title)
  {
    List<String> steps = StepsFormState.stepList;
    List<String> amt = IngredientsFormState.amountList;
    List<String> names = IngredientsFormState.nameList;
    List<String> units = IngredientsFormState.unitList;
    String json = "{\n\t" + title + ",\n" + "\t{\n";
    for(int i = 0; i < StepsFormState.count+1; i++){
      json+= "\t\t\"" + steps.elementAt(i) + "\",\n";
    }
    json = json.substring(0, json.length -1) + "\n\t}\n";
    for(int i = 0; i < IngredientsFormState.count+1; i++) {
      json += "\t{\n\t\t\"" + names.elementAt(i) + "\",\n\t\t" + amt.elementAt(i) + ",\n\t\t\"" + units.elementAt(i) + "\"\n\t},";
    }
    json = json.substring(0,json.length-1) + "\n";
    json += "}";
    print(json);
  }
}

