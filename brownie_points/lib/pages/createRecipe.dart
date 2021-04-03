import 'package:brownie_points/config/Config.dart';
import 'package:brownie_points/database/jsonCalls.dart';
import 'package:brownie_points/forms/categoriesForm.dart';
import 'package:brownie_points/forms/ingredientForm.dart';
import 'package:brownie_points/forms/stepsForm.dart';
import 'package:brownie_points/forms/submitImageForm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CreateRecipe extends StatefulWidget {
  @override
  _CreateRecipeState createState() => _CreateRecipeState();
}

class _CreateRecipeState extends State<CreateRecipe> {
  String title = "";
  int count = 1;
  int stepC = 1;
  int index = 0;
  static final _formKey = formKeys[0];

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(fontFamily: 'sans-serif', fontSize: 20.0);

    final titleField = Form(
      key: _formKey,
      child: TextFormField(
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
          title = text;
        },
      )
    );

    return SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                titleField,
                CategoriesForm(),
                StepsForm(),
                IngredientsForm(),
                ImageForm(),
                Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.deepPurple,
                  child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width,
                    padding:EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    onPressed: () {
                      //TODO: Implement create recipe into the API
                      if(validate())
                        JsonCall.createRecipe(title,
                                              StepsFormState.stepList,
                                              IngredientsFormState.amountList,
                                              IngredientsFormState.nameList,
                                              IngredientsFormState.unitList,
                                              CategoriesFormState.public,
                                              CategoriesFormState.category)
                                              .then((val) {
                          if(val.isEmpty){
                            Fluttertoast.showToast(
                                msg: "Recipe Created Successfully",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.deepPurpleAccent,
                                fontSize: 16.0
                            );
                            setState(() {
                              count = 1;
                              stepC = 1;
                              index = 0;
                              title = "";
                              CategoriesFormState.category = null;
                              IngredientsFormState.nameList = [null];
                              IngredientsFormState.amountList = [null];
                              IngredientsFormState.unitList = [null];
                              StepsFormState.stepList = [null];
                              StepsFormState.count = 0;
                              ImageFormState.image = null;
                            });
                          }
                          else
                            {
                              Fluttertoast.showToast(
                                  msg: "Internal Server Error",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.deepPurple,
                                  fontSize: 16.0
                              );
                            }
                        });
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

  bool validate(){
    for(int i = 0; i < formKeys.length; i++) {
      if ((i != 1) && !formKeys[i].currentState.validate()) return false;
    }
    return true;
  }
}

