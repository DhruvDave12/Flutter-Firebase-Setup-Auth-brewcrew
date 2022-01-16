import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/screens/authenticate/authenticate.dart';
import 'package:brew_crew/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // As we know that we gave a provider which gives state changes to all the childs.
    // So through below line i got the user state in this user
    final user = Provider.of<Userr?>(context);
    // return either home or authenticate widget
    return user == null ? Authenticate() : Home();
  }
}
