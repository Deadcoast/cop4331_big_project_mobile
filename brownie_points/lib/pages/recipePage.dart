import 'package:brownie_points/database/jsonCalls.dart';
import 'package:brownie_points/database/jsonPacks.dart';
import 'package:brownie_points/database/savePrefs.dart';
import 'package:brownie_points/pageTemplate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecipePage extends StatefulWidget {
  final String id;
  final String title;
  final String image;
  final List<String> steps;
  final List<dynamic> ingredients;
  final String user;

  RecipePage(this.id, this.title, this.image, this.steps, this.ingredients, this.user);
  @override
  _RecipePageState createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {

  Future<bool> returnTrue() async{
    Navigator.pop(context, false);
    await Future.delayed(Duration.zero);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: returnTrue,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title)
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: SingleChildScrollView(
                child: Column(
                  children:[
                    Image(image: NetworkImage(widget.image)),
                    ...getSteps(),
                    ...getIngredients(),
                  ]
                )
            )
          )
        )
      )
    );
  }

  List<Widget> getSteps(){
    List<Widget> steps = List<Widget>.generate(widget.steps.length * 2, (i) {
      if(i % 2 == 0)
        return SizedBox(height:8);
      else
        return Align(child:Text("${((i+1)/2).floor()}. ${widget.steps.elementAt((i/2).floor())}", style: TextStyle(fontSize: 16),), alignment: Alignment(-1,0));
    });

    steps.insert(0, Text("Steps", style: TextStyle(fontSize: 24)));
    return steps;
  }
  List<Widget> getIngredients(){
    List<Widget> ingreds = List<Widget>.generate(widget.ingredients.length * 2, (index) {
      int i = ((index/2)/2).floor();
      if(index % 2 == 0)
        return SizedBox(height:8);
      else
        return FutureBuilder(
            future: EditPreferences.fetchProfileInfo(),
            builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot){
              if(snapshot.hasData)
              {
                String metric = snapshot.data['metric'];
                Ingredient ing = Ingredient(widget.ingredients.elementAt(i).toString());
                if(metric == 'true')
                  return Align(child: Text("${i+1}. ${ing.name} ${ing.amtM} ${ing.unitM}", style: TextStyle(fontSize: 16)), alignment: Alignment(-1,0));
                else
                  return Align(child: Text("${i+1}. ${ing.name} ${ing.amtI} ${ing.unitI}", style: TextStyle(fontSize: 16)), alignment: Alignment(-1,0));
              }
              else if(snapshot.hasError)
                return Icon(Icons.error);
              else
                return Text("Loading User Data");
            });
    });
    ingreds.insert(0, Text("Ingredients", style: TextStyle(fontSize: 24)));
    ingreds.add(FutureBuilder(
      future: EditPreferences.fetchProfileInfo(),
      builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot){
        if(snapshot.hasData){
          if(snapshot.data['userID'] == widget.user)
          {
            return ButtonBar(
              children: [
                FlatButton(
                  child:Text("DELETE", style: TextStyle(color: Colors.red)),
                  onPressed: confirmDelete,
                )
              ],
            );
          }
        }
        return SizedBox(height: 0, width: 0);
      }
    ));
    print(widget.ingredients.elementAt(0).toString());
    return ingreds;
  }

  Future<bool> confirmDelete() async
  {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to delete this recipe?\n(can not be undone)'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () {
              JsonCall.deleteRecipe(widget.id);
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PageTemplate()),
              );
            },
            child: new Text('Yes'),
          ),
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(),
            child: new Text('No'),
          ),
        ],
      ),
    )) ?? false;
  }

}
