import 'package:AngryDentist/models/activity.dart';
import 'package:AngryDentist/screens/authenticate/authenticate.dart';
import 'package:AngryDentist/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    final user = Provider.of<Activity>(context);
   // print(user);

    // return either the Home or Authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
