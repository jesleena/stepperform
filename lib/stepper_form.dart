import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:time_range_picker/time_range_picker.dart';
class StepperForm extends StatefulWidget {
  static const String id ='stepper_form';
  @override
  _StepperFormState createState() => _StepperFormState();
}

class _StepperFormState extends State<StepperForm> {

  List<GlobalKey<FormState>> formKeys = [GlobalKey<FormState>(), GlobalKey<FormState>(), GlobalKey<FormState>()];
  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;
  TextEditingController dateController = TextEditingController();

  String? Date;
 TimeRange? Time;
  String? num;
  String? dateTime;
  TimeOfDay selectedTime = TimeOfDay.now();
  bool isChecked1 = false;
  bool isChecked2 = false;





  Widget _buildText(String name) {
    return TextFormField(
        decoration: InputDecoration(
            labelText: "$name Name",
            border: OutlineInputBorder(),
            hintText:"Enter your $name Name"
        ),
        validator: (value){
          if(value!.isEmpty) {
            return "required";
          }
          else {
            return null;
          }
        },
      );}
  Widget _buildDropdown(String name,String b,String c) {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        labelText: "Select",
          border: OutlineInputBorder(),
      ),
      hint: const Text('Select Item'),
      //value: value,

      onChanged: (value) async {
        setState(() => value = value.toString());
        if(value != null ){
          print(value);  }
      },
      validator: (value) => value == null ? 'Required field' : null,

      items:
      [b,c].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),

        );

      }).toList(),


    );
  }
  Widget _buildDate() {
    return TextFormField(

      controller: dateController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: " Date" ,
        hintText:"select date" ,
        suffixIcon: Icon(Icons.calendar_today),
      ),
      readOnly: true,  // when true user cannot edit text
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2101),
        );

        if(pickedDate != null ){
          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
          print(formattedDate);

          setState(() {
            dateController.text = formattedDate;
            Date= formattedDate;//set foratted date to TextField value.
          }
          );
        }

      },
      validator: (value){
        if(value!.isEmpty) {
          return "Required field";
        }
        else {
          return null;
        }
      },
    );}
  Widget _buildDropdown2() {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Select'
      ),

      hint: const Text('Select number'),
      value: num,
      onChanged: (value) async {
        setState(() => num = value.toString());
        if(num != null ){
          print(num);  }
      },
      items:
      ['1','2','3'].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
            value: value,
            child: Text(value)
        );
      }).toList(),
    );}
  Widget _buildTextarea() {
    return TextFormField(

      minLines:3, // any number you need (It works as the rows for the textarea)
      keyboardType: TextInputType.multiline,
      maxLines: null,
      decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Description",
          hintText:"Enter Description"
      ),
      onSaved:(value)  {
        if(value != null ){
          print(value);
        }
      },
    );}
/*
  _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if(timeOfDay != null && timeOfDay != selectedTime)
    {
      setState(() {
        selectedTime = timeOfDay;
      });
    }
  }
*/




  @override
  Widget build(BuildContext context) {


    final double height = MediaQuery.of(context).size.height;
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

    return  Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Flutter Stepper Demo'),
        centerTitle: true,
        //backgroundColor: Colors.deepPurpleAccent,
      ),
      body:  Container(
        child: Column(
          children: [
            Expanded(
              child: Stepper(

                type: stepperType,
                physics: ScrollPhysics(),
                currentStep: this._currentStep,
                onStepTapped: (step) => tapped(step),
                onStepContinue:  continued,
                onStepCancel: cancel,
                steps: <Step>[
                  Step(
                    title: new Text('Account'),
                    content: Column(
                      children: <Widget>[
                        _buildText('User'),
                        SizedBox(height:height*0.03),
                        _buildDropdown('Nationality','India','UAE'),
                        SizedBox(height:height*0.03),
                        _buildDropdown('Gender','Male','Female'),
                        SizedBox(height:height*0.03),
                        _buildDate(),
                        SizedBox(height:height*0.03),
                        _buildText('First'),
                        SizedBox(height:height*0.03),
                        _buildText('Last'),
                        SizedBox(height:height*0.03),
                        _buildDropdown2(),
                        SizedBox(height:height*0.03),
                        _buildTextarea(),
                        SizedBox(height:height*0.03),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 1, 0),

                          child:ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.white),
                            ),
                          onPressed: () async {
                           TimeRange result = await showTimeRangePicker(
                             context: context,);
                             print( result.toString());
                              Time=result;
                               },
                          child:
                          Text("time range",style: Theme.of(context).textTheme.headline1),
                         ),

                        ),
                        Text("time range$Time",style: Theme.of(context).textTheme.headline1),

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
                        _buildDropdown('Nationality','India','UAE'),
                        SizedBox(height:height*0.03),
                        _buildDropdown('Gender','Male','Female'),
                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 1 ?
                    StepState.complete : StepState.disabled,
                  ),
                  Step(
                    title: new Text('check'),
                    content: Column(
                      children: <Widget>[

                  Row(
                    children: [
                      Text("checkbox1"),
                      Checkbox(
                        checkColor: Colors.white,
                        fillColor: MaterialStateProperty.resolveWith(getColor),
                        value: isChecked1,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked1 = value!;
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text("checkbox2"),
                      Checkbox(
                        checkColor: Colors.white,
                        fillColor: MaterialStateProperty.resolveWith(getColor),
                        value: isChecked2,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked2 = value!;
                          });
                        },
                      ),
                    ],
                  ),
                  _buildText('name'),
                      ],
                    ),
                    isActive:_currentStep >= 0,
                    state: _currentStep >= 2 ?
                    StepState.complete : StepState.disabled,
                  ),
                ],
              ),
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

/*
  continued(){
    _currentStep < 2 ?
    setState(() => _currentStep += 1): null;
  }
*/

   continued() {
     setState(() {
       if(formKeys[_currentStep].currentState!.validate()) {
         if (_currentStep< 2) {
           _currentStep = _currentStep + 1;
           ScaffoldMessenger.of(context).showSnackBar(
               const SnackBar(content: Text('Processing Data')));
         } else {
           _currentStep = 0;
         }

       }
     });}






     cancel() {
     _currentStep > 0 ?
     setState(() => _currentStep -= 1) : null;
     }
   }