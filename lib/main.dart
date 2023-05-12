import 'package:flutter/material.dart';
import 'package:stepperform/stepper_form.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        theme: ThemeData(

        brightness: Brightness.light,
        fontFamily: 'SF Pro Display',
        textTheme: const TextTheme(
        headline1: TextStyle(color: Colors.black54,fontSize:15,fontWeight: FontWeight.normal),
        ),
          elevatedButtonTheme:
          ElevatedButtonThemeData(style: ElevatedButton.styleFrom(minimumSize: Size(1, 45), primary:Colors.white, textStyle: TextStyle(fontSize: 16.0, color: Colors.black))),
        ),
      home: StepperForm(),
      initialRoute:'form_screen' ,
      routes: {
        StepperForm.id: (context) => StepperForm(),
      },);
  }
}