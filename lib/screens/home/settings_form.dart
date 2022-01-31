import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/services/database.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:provider/provider.dart';

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
    final user = Provider.of<Userr>(context);

    return StreamBuilder<UserData>(
        // we desfine the stream here so that we listen to this stream
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData? userData = snapshot.data;
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
                      initialValue: userData!.name,
                      decoration: textInputDecoration,
                      validator: (val) =>
                          val!.isEmpty ? 'Please enter a name' : null,
                      onChanged: (val) => setState(() => _currentName = val),
                    ),

                    SizedBox(
                      height: 20.0,
                    ),

                    // drop-down
                    DropdownButtonFormField(
                      value: _currentSugars ?? userData!.sugars,
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
                      value: (_currentStrength ?? userData.strength).toDouble(),
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
                          await DatabaseService(uid: user.uid).updateUserData(
                              _currentSugars ?? userData.sugars,
                              _currentName ?? userData.name,
                              _currentStrength ?? userData.strength);
                          Navigator.pop(context);
                        })
                  ],
                ));
          } else {
            return Loading();
          }
        });
  }
}
