import 'package:brownie_points/config/Config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoriesForm extends StatefulWidget {
  @override
  CategoriesFormState createState() => CategoriesFormState();
}

class CategoriesFormState extends State<CategoriesForm> {
  
  final _formKey = formKeys[2];
  static String category = null;
  static bool public = false;

  @override initState() => super.initState();
  
  @override
  void dispose() => super.dispose();
  
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Row(
          children: [
            Expanded(flex: 30,child: IngredientsDropDown()),
            Expanded(flex: 25, child: PublicCheckBox()),
          ],
        )
      )
    );
  }
  
}

class IngredientsDropDown extends StatefulWidget {
  @override
  _IngredientsDropDownState createState() => _IngredientsDropDownState();
}

class _IngredientsDropDownState extends State<IngredientsDropDown> {

  List<String> categories = [ "Category","Breakfast", "Lunch", "Dinner", "Snacks", "Dessert", "Drinks"];
  
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        value: CategoriesFormState.category,
        hint: Text("Category"),
        items: categories.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
              value: value,
              child: Text(value)
          );
        }).toList(),
        onChanged:(String newVal) {
          setState(() {
            if(newVal == "Category")
              CategoriesFormState.category = null;
            else
              CategoriesFormState.category = newVal;
          });
        }
    );
  }
}

class PublicCheckBox extends StatefulWidget {
  @override
  _PublicCheckBoxState createState() => _PublicCheckBoxState();
}

class _PublicCheckBoxState extends State<PublicCheckBox> {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
        value: CategoriesFormState.public,
        title: const Text("Public "),
        onChanged: (bool value){
          setState(() {
            CategoriesFormState.public = value;
          });
        }
    );
  }
}
