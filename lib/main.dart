import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/screens/wrapper.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  // add these two lines for firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.

  // We will wrap this main MyApp root MaterialApp with a Provider which would listen for auth changes

  @override
  Widget build(BuildContext context) {
    return StreamProvider<Userr?>.value(
        initialData: null,
        value: AuthService().user,
        child: MaterialApp(home: Wrapper()));
  }
}
