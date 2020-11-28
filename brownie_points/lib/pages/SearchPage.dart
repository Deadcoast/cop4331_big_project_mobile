import 'package:brownie_points/forms/categoriesForm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class SearchPageForm extends StatefulWidget {
  @override
  _SearchPageFormState createState() => _SearchPageFormState();
}

class _SearchPageFormState extends State<SearchPageForm> {
  static List<String> names = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "11"
  ];
  final _formKey = GlobalKey<FormState>();
  TextEditingController _titleText;
  static String title;
  static int _pge = 1;

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
                IngredientsDropDown(),
                ..._createCards(_pge),
                Row(children: [
                  FlatButton(onPressed: _decrementPage,
                      child: Icon(Icons.remove)
                  ),
                  Text("$_pge"),
                  FlatButton(
                      onPressed: _incrementPage,
                      child: Icon(Icons.add))
                ]),
              ],
            )
        )
    );
  }

  List<Widget> _createCards(int page) {
    List<Widget> cards = [];
    for ( int i = (_pge * 5-5); (i < (_pge * 5)) & (i <
        _SearchPageFormState.names.length); i++) {
      setState((){cards.add(
          createRecipeCard('${_SearchPageFormState.names[i]}', null, null));});
    }
    return cards;
  }

  Widget createRecipeCard(String name, String image, String user) {
    Image img;
    if (image == null)
      img = Image.network(
          "https://banner.uclipart.com/20200112/lqt/mexican-food-cartoon-line.png");
    else
      img = Image.network(image);
    if (name == null)
      name = "College Degree";
    if (user == null)
      user = "Rick Leinicker";
    return Padding(
        padding: EdgeInsets.all(0),
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [ListTile(
              title: Text(name),
              subtitle: Text(user),
            ),

              img,
              FlatButton(
                onPressed: () {
                  //TODO: View
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
      ctr.text = _SearchPageFormState()._titleText ?? '';
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
      onChanged: (text) {
        _SearchPageFormState.title = text;
      },
    );
  }
}