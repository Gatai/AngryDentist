import 'package:AngryDentist/models/activity.dart';
import 'package:AngryDentist/screens/wrapper.dart';
import 'package:AngryDentist/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Activity>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
        
      ),
    );
  }
}
