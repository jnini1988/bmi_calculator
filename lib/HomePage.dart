import 'package:flutter/material.dart';
import "dart:math";

enum SingingCharacter {metric,english}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SingingCharacter? _unitSystem = SingingCharacter.metric;
  final heightControl = TextEditingController();
  final weightControl = TextEditingController();
  bool isMetric = true;
  late double BMI;
  String result = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Enter you height and weight to calculate your BMI!',
            ),
            ListTile(
              title: const Text('Metric (cm/kg)'),
              leading: Radio<SingingCharacter>(
                value: SingingCharacter.metric,
                groupValue: _unitSystem,
                onChanged: (SingingCharacter? value) {
                  setState(() {
                    _unitSystem = value;
                    isMetric = true;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('English (in/lbs)'),
              leading: Radio<SingingCharacter>(
                value: SingingCharacter.english,
                groupValue: _unitSystem,
                onChanged: (SingingCharacter? value) {
                  setState(() {
                    _unitSystem = value;
                    isMetric = false;
                  });
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Height',
                ),
                controller: heightControl,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Weight',
                ),
                controller: weightControl,
              ),
            ),

            TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(8.0),
                primary: Colors.blueAccent,
                textStyle: const TextStyle(fontSize: 14),
              ),
              onPressed: calculate_BMI,
              child: const Text('Calculate'),
            ),

            Text(result),
          ],
        ),
      ),
    );
  }

  void calculate_BMI() {
    int? height = int.tryParse(heightControl.text);
    int? weight = int.tryParse(weightControl.text);
    setState(() {
      if (height == null || weight == null || height <= 0 || weight <= 0) {
        result = "Invalid Input: Please enter postive integers only";
      }
      else {
        if (!isMetric) {
          BMI= 703 * weight / pow(height, 2);
        }
        else{
          BMI=weight/pow(height/100,2);
        }
        result = "Your BMI is " + BMI.toStringAsFixed(1)+". Your Status is "+status();
      }
    });
  }

  String status(){
    if(BMI<18.5){
      return 'Underweight';
    }
    else if(BMI<25){
      return 'Healthy Weight';
    }
    else if(BMI<30){
      return 'OverWeight';
    }
    return 'Obesity';
  }
}