import 'package:brownie_points/config/Config.dart';
import 'package:brownie_points/database/savePrefs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class IngredientsForm extends StatefulWidget {
  @override
  IngredientsFormState createState() => IngredientsFormState();
}

class IngredientsFormState extends State<IngredientsForm> {
  static final formKey = formKeys[4];
  TextEditingController _nameController;
  static List<String> nameList = [null];
  TextEditingController _amountController;
  static List<String> amountList = [null];
  static List<String> unitList = [null];
  static int count = 0;

  @override
  void initState(){
    super.initState();
    _nameController = TextEditingController();
    _amountController = TextEditingController();
  }

  @override
  void dispose(){
    _nameController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            ..._getIngredients(),
          ],
        ),
      )
    );
  }

  List<Widget> _getIngredients() {
    List<Widget> ingredientsTextFields = [];
    for (int i = 0; i < nameList.length; i++) {
      ingredientsTextFields.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Expanded(flex: 4,child: NameField(i)),
              Expanded(flex: 2,child: AmountField(i)),
              Expanded(flex: 2,child: UnitDropDown(i)),
              _addRemoveButton(i == nameList.length - 1, i),
            ],
          )
        )
      );
    }
    return ingredientsTextFields;
  }

  Widget _addRemoveButton(bool add, int index) {
    return InkWell(
      onTap: () {
        if (add) {
          nameList.insert(index + 1, null);
          amountList.insert(index + 1, null);
          unitList.insert(index+1, null);
          count++;
        }
        else {
          nameList.removeAt(index);
          amountList.removeAt(index);
          unitList.removeAt(index);
          count--;
        }
        setState(() {});
      },
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: (add) ? Colors.deepPurple : Colors.deepPurpleAccent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon((add) ? Icons.add : Icons.remove, color: Colors.white,),
      ),
    );
  }
}

class AmountField extends StatefulWidget {
  final int index;
  AmountField(this.index);
  @override
  _AmountFieldState createState() => _AmountFieldState();
}

class _AmountFieldState extends State<AmountField> {

  TextEditingController ctr;

  @override
  void initState(){
    super.initState();
    ctr = TextEditingController();
  }

  @override
  void dispose(){
    ctr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ctr.text = IngredientsFormState.amountList[widget.index] ?? '';
    });

    return TextFormField(
      controller: ctr,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText:"Amount",
        helperText: " ",
      ),
      onChanged: (v) => IngredientsFormState.amountList[widget.index] = v,
      validator: (value)
      {
        if(value.isEmpty)
          return " ";
        return null;
      }
    );
  }
}

class NameField extends StatefulWidget {
  final int index;
  NameField(this.index);
  @override
  _NameFieldState createState() => _NameFieldState();
}

class _NameFieldState extends State<NameField> {

  TextEditingController ctr;

  @override
  void initState(){
    super.initState();
    ctr = TextEditingController();
  }

  @override
  void dispose(){
    ctr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ctr.text = IngredientsFormState.nameList[widget.index] ?? '';
    });

    return TextFormField(
      controller: ctr,
      decoration: InputDecoration(
        labelText:"Ingredient Name",
        helperText: " ",
      ),
      onChanged: (v) => IngredientsFormState.nameList[widget.index] = v,
      validator: (value) {
        if(value.isEmpty)
          return " ";
        return null;
      },
    );
  }
}

class UnitDropDown extends StatefulWidget {
  final int index;
  UnitDropDown(this.index);
  @override
  _UnitDropDownState createState() => _UnitDropDownState();
}

class _UnitDropDownState extends State<UnitDropDown> {
  List<String> metric = ['g', 'kg', 'ml', 'l'];
  List<String> imperial = ['lb', 'oz', 'fl-oz', 'cup', 'qt', 'gal', 'tbsp', 'tsp'];


  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(top: 10),
        child: FutureBuilder<Map<String,String>>(
      future: EditPreferences.fetchProfileInfo(),
      builder: (BuildContext context, AsyncSnapshot<Map<String, String>> snapshot){
        Widget child;
        if(snapshot.hasData){
          List<String> unitArr;
          if(snapshot.data['metric'] == 'true')
              unitArr = metric;
          else
            unitArr = imperial;
          child = DropdownButtonFormField<String>(
            style: TextStyle(color: Colors.deepPurple),
            value: IngredientsFormState.unitList[widget.index],
            decoration: const InputDecoration(
              helperText: " ",
            ),
            hint: Text("Unit"),
            onChanged: (String newValue) {
              setState(() {
                IngredientsFormState.unitList[widget.index] = newValue;
              });
            },
            validator: (val)
            {
              if(val == null)
                return " ";
              return null;
            },
            items: unitArr.map<DropdownMenuItem<String>>((String value){
              return DropdownMenuItem<String>(
                  value:value,
                  child: Text(value)
              );
            }).toList(),
          );
        }
        else if (snapshot.hasError) {
        child = Icon(
            Icons.error,
            size: 10,
          );
        } else {
          child = Icon(
              Icons.alarm,
              size: 10,
            );
        }
        return child;
      }
    )
    );
  }
}
