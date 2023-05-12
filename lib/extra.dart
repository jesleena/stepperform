import 'package:flutter/material.dart';

class StepperForm extends StatefulWidget {
  static const String id ='stepper_form';
  @override
  _StepperFormState createState() => _StepperFormState();
}

class _StepperFormState extends State<StepperForm> {
  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;
  final formKey = GlobalKey<FormState>();
  final myController = TextEditingController();//key for form
  TextEditingController dateController = TextEditingController();
  //String? selectedMoney;


  Widget _buildName(String name) {
    return TextFormField(
      decoration: InputDecoration(
          labelText: "$name Name",
          border: OutlineInputBorder(),
          hintText:"Enter your $name Name"
      ),
      validator: (value){
        if(value!.isEmpty || !RegExp(r'^[A-Za-z]+$').hasMatch(value!)) {
          return "Enter correct name";
        }
        else {
          return null;
        }
      },
    );}
  Widget _buildCurrency(String a,String b) {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Currency'
      ),
      hint: const Text('Select Currency'),
      //value: value,

      onChanged: (value) async {
        setState(() => value = value.toString());
        if(value != null ){
          print(value);  }
      },
      validator: (value) => value == null ? 'Required field' : null,

      items:
      [a,b].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),

        );

      }).toList(),


    );
  }


  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return  Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Flutter Stepper Demo'),
        centerTitle: true,
      ),
      body:  Container(
        child: Column(
            children: [
        Expanded(
        child: Stepper(
        type: stepperType,
            physics: ScrollPhysics(),
            currentStep: _currentStep,
            onStepTapped: (step) => tapped(step),
            onStepContinue:  continued,
            onStepCancel: cancel,
            steps: <Step>[
        Step(
        title: new Text('Account'),
        content:Form(
          key: formKey, //key for form
          child:Column(
            children: <Widget>[

              _buildName('First'),
              SizedBox(height:height*0.03),
              _buildName('Second'),
              SizedBox(height:height*0.03),
              _buildCurrency('AED','Dollar'),
              SizedBox(height:height*0.03),
              _buildCurrency('1','2'),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
              ),

              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
              ),
            ],
          ),
          isActive: _currentStep >= 0,
          state: _currentStep >= 0 ?
          StepState.complete : StepState.disabled,
        ),
        Step(
          title: new Text('Address'),
          content: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Home Address'),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Postcode'),
              ),
            ],
          ),
          isActive: _currentStep >= 0,
          state: _currentStep >= 1 ?
          StepState.complete : StepState.disabled,
        ),
        Step(
          title: new Text('Mobile Number'),
          content: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Mobile Number'),
              ),
            ],
          ),
          isActive:_currentStep >= 0,
          state: _currentStep >= 2 ?
          StepState.complete : StepState.disabled,
        ),
        ],
      ),
    ),
    Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [

    ElevatedButton(onPressed: (){
    if(formKey.currentState !.validate()){
    formKey.currentState?.reset();

    print('Submitting form');
    ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Processing Data')),
    );
    } },

    style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Colors.grey),
    shape: MaterialStateProperty.all(
    RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16),
    ),
    ),
    ),  child: const Text("submit"),
    ),
    ],
    ),
    ],
    ),

    ),
    floatingActionButton: FloatingActionButton(
    child: Icon(Icons.list),
    onPressed: switchStepsType,
    ),

    );
  }
  switchStepsType() {
    setState(() => stepperType == StepperType.vertical
        ? stepperType = StepperType.horizontal
        : stepperType = StepperType.vertical);
  }

  tapped(int step){
    setState(() => _currentStep = step);
  }

  continued(){
    _currentStep < 2 ?
    setState(() => _currentStep += 1): null;
  }
  cancel(){
    _currentStep > 0 ?
    setState(() => _currentStep -= 1) : null;
  }


}






/*
ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.white),

                            ),
                            onPressed: () {
                              _selectTime(context);
                            },
                            child: Text("Choose Time",style: Theme.of(context).textTheme.headline1),
                          ),
                          Padding( padding: const EdgeInsets.fromLTRB(0, 10, 200, 0),
                            child: Text("${selectedTime.hour}:${selectedTime.minute}")),
 */