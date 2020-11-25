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
    List<Widget> steps = new List.generate(stepC, (int i) => new StepsField());
    List<String> units = new List.generate(count, (int i) => 'g');
    List<String> amounts = new List.generate(count, (int i) => '');
    List<String> ingredNames = new List.generate(count, (int i) => '');

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
    ListView lst = ListView(
      children: steps,
      scrollDirection: Axis.vertical,
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
                  child: lst,
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
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: count,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Container(
                              width:MediaQuery.of(context).size.width * .60,
                              child:TextFormField(
                                decoration: InputDecoration(
                                  labelText: "Ingredient",
                                ),
                                onChanged: (text) {
                                  ingredNames[index] = text;
                                  setState(() {
                                    text;
                                  });
                                },
                              ),
                            ),
                            Container(
                              width:MediaQuery.of(context).size.width * .23,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText:"Amount",
                                ),
                                onChanged: (text) {
                                  setState((){
                                    amounts[index] = text;
                                  });
                                },
                              ),
                            ),
                            Container(
                                alignment: Alignment.bottomCenter,
                                child: DropdownButton(
                                  value: units[index],
                                  icon: Icon(Icons.arrow_downward_rounded),
                                  iconSize: 16,
                                  onChanged: (val){
                                    setState(() {
                                      units[index] = val;
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
                      foo(title, {ingredNames, amounts, units}, steps);
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

  void foo(String title, Set<List<String>> ingredients, List<Widget> steps)
  {
    String jsonCode = "{ \n\"title\" :" + title + ",\n" ;
    String ingred = "{\n";
    for(int i = 0; i < count; i++)
    {
      ingred += ingredients.elementAt(0)[i] + " ";
      ingred += ingredients.elementAt(1)[i] + " ";
      ingred += ingredients.elementAt(2)[i] + "\n";
    }
    ingred += "}";
    jsonCode += ingred;
    print(jsonCode);
  }
}

class StepsField extends StatefulWidget {
  @override
  _StepsFieldState createState() => _StepsFieldState();
}

class _StepsFieldState extends State<StepsField> {
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
