import 'package:brownie_points/database/jsonCalls.dart';
import 'package:brownie_points/database/jsonPacks.dart';
import 'package:brownie_points/forms/categoriesForm.dart';
import 'package:brownie_points/pages/recipePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class MyPageForm extends StatefulWidget {
  @override
  _MyPageFormState createState() => _MyPageFormState();
}

class _MyPageFormState extends State<MyPageForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _titleText;
  static int _pge = 1;
  static String title;
  // ignore: non_constant_identifier_names
  static final int ITEMS_PER_PAGE= 5;
  static List<Recipe> recipes;
  static int currentPageC;
  static int total = 0;

  @override
  void initState() {
    super.initState();
    _titleText = TextEditingController();
  }

  @override
  void dispose() {
    _titleText.dispose();
    super.dispose();
  }

  void _incrementPage(){
    setState(() {
      _pge++;
    });
  }

  void _decrementPage(){
    setState(() {
      _pge--;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              SearchBar(),
              Row(children: [
                IngredientsDropDown(),
                IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      setState((){
                        _pge = 1;
                      });
                    }
                )
              ]),
              SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height*.67,
                    child: Column(
                        children: [
                          FutureBuilder<FetchRecipesReceive>(
                              future: JsonCall.fetchRecipe(title, CategoriesFormState.category, true, _pge, ITEMS_PER_PAGE),
                              builder: (BuildContext context, AsyncSnapshot<FetchRecipesReceive> snapshot){
                                if(snapshot.hasError)
                                  return Text(snapshot.error.toString());
                                else if(snapshot.hasData) {
                                  recipes = snapshot.data.recipes.map((recipe2) => Recipe.fromJson(recipe2)).toList();
                                  currentPageC = snapshot.data.numInPage;
                                  total = snapshot.data.totalNumRecipes;
                                  return _createCards(_pge);
                                }
                                return Icon(Icons.error);
                              }
                          ),
                          Row(mainAxisAlignment: MainAxisAlignment.center,children: [

                          ]
                          ),
                        ]
                    ),)
              ),
            ],
          ),
        )
    );
  }

  Widget _createCards(int page) {

    List<Widget> list = new List<Widget>();

    for(int i = 0; i < currentPageC; i++) {
      Recipe recp = recipes.elementAt(i);
      list.add(createRecipeCard(recp.title, recp.picture, recp.instructions.cast<String>(), recp.ingredients, recp.author, recp.id));
    }

    if(list.length == 0)
      list.add(Align(child: Text("No recipes, try creating one!", style: TextStyle(fontSize: 16)), alignment: Alignment(0, 0)));

    list.add(
        ButtonBar(
            alignment: MainAxisAlignment.center,
            children:[FlatButton(onPressed: (_pge == 1) ? null :_decrementPage,
                child:  (_pge == 1) ? null :Icon(Icons.remove)
            ),
              Text("$_pge"),
              FlatButton(
                  onPressed: (total/ ITEMS_PER_PAGE <= _pge) ? null : _incrementPage,
                  child: (total/ ITEMS_PER_PAGE <= _pge) ? null : Icon(Icons.add)
              )])
    );
    return Flexible(
        child:ListView(
          children: list,
        )
    );
  }

  Widget createRecipeCard(String name, String image, List<String> steps, List<dynamic> ingredients, String user, String id) {
    Image img;
    try {
      if (image == null || image == "")
        img = Image.network(
            "https://banner.uclipart.com/20200112/lqt/mexican-food-cartoon-line.png");
      else
        img = Image.network(image);
    }
    on NetworkImageLoadException {
      img = img = Image.network(
          "https://banner.uclipart.com/20200112/lqt/mexican-food-cartoon-line.png");
    }

    if (name == null)
      name = "College Degree";

    return Padding(
        padding: EdgeInsets.all(0),
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [ListTile(
              title: Text(name),
            ),
              img,
              FlatButton(
                onPressed: () {
                  Navigator.push(context,MaterialPageRoute(builder: (context) => RecipePage(id, name, image, steps, ingredients, user)));
                },
                child: Text('View'),
              ),
            ],
          ),
        )
    );
  }
}




class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController ctr;

  @override
  void initState(){
    super.initState();
    ctr = TextEditingController();
  }

  void dispose(){
    ctr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ctr.text = _MyPageFormState.title ?? '';
    });


    return TextFormField(
      controller: ctr,
      validator: (v) {
        if(v.isEmpty)
          return " ";
        return null;
      },
      obscureText: false,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        labelText: "Title",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular((32.0))),
        hintText: " ",
      ),
      onChanged: (text){
        _MyPageFormState.title = text;
      },
    );
  }
}