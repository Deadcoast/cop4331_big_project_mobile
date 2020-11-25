import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StepsForm extends StatefulWidget {

  @override
  StepsFormState createState() => StepsFormState();
}

class StepsFormState extends State<StepsForm> {


  final _formKey = GlobalKey<FormState>();
  TextEditingController _stepController;
  static List<String> stepList = [null];
  static int count = 0;

  @override
  void initState() {
    super.initState();
    _stepController = TextEditingController();
  }

  @override
  void dispose() {
    _stepController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            ..._getSteps(),
          ],
        ),
      ),
    );
  }

  List<Widget> _getSteps(){
    List<Widget> stepsTextFields = [];
    for(int i=0; i<stepList.length; i++){
      stepsTextFields.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Expanded(child: StepsField(i)),
                SizedBox(width: 16,),
                _addRemoveButton(i == stepList.length-1, i),
              ],
            ),
          )
      );
    }
    return stepsTextFields;
  }

  Widget _addRemoveButton(bool add, int index) {
    return InkWell(
      onTap: () {
        if (add) {
          stepList.insert(index + 1, null);
          count++;
        }
        else {
          stepList.removeAt(index);
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

class StepsField extends StatefulWidget {
  final int index;
  StepsField(this.index);
  @override
  _StepsFieldState createState() => _StepsFieldState();
}

class _StepsFieldState extends State<StepsField> {

  TextEditingController ctr;

  @override
  void initState() {
    super.initState();
    ctr = TextEditingController();
  }

  @override
  void dispose() {
    ctr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ctr.text = StepsFormState.stepList[widget.index] ?? '';
    });

    return TextFormField(
      controller: ctr,
      decoration: InputDecoration(
        labelText:"Step",
      ),
      onChanged: (v) => StepsFormState.stepList[widget.index] = v,
    );
  }
}
