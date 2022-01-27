import 'package:flutter/material.dart';
import 'package:brew_crew/shared/constants.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formkey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  String? _currentName;
  String? _currentSugars;
  int? _currentStrength;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formkey,
        child: Column(
          children: [
            Text(
              'Update your Brew Settings',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(
              height: 20.0,
            ),
            TextFormField(
              decoration: textInputDecoration,
              validator: (val) => val!.isEmpty ? 'Please enter a name' : null,
              onChanged: (val) => setState(() => _currentName = val),
            ),

            SizedBox(
              height: 20.0,
            ),

            // drop-down
            DropdownButtonFormField(
              value: _currentSugars,
              onChanged: (newSugar) {
                setState(() {
                  _currentSugars = newSugar.toString();
                });
              },
              items: sugars.map((sugar) {
                return DropdownMenuItem(
                  value: sugar,
                  child: Text('${sugar} sugars'),
                );
              }).toList(),
            ),

            SizedBox(
              height: 20.0,
            ),
            // Slider
            Slider(
              min: 100,
              max: 900,
              // how many times you want to move the slider
              divisions: 8,
              onChanged: (val) {
                setState(() {
                  _currentStrength = val.round();
                });
              },
              value: (_currentStrength ?? 100).toDouble(),
              activeColor: Colors.brown[_currentStrength ?? 100],
              inactiveColor: Colors.brown[_currentStrength ?? 100],
            ),

            RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  'Update',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  print(_currentName);
                  print(_currentSugars);
                  print(_currentStrength);
                })
          ],
        ));
  }
}
