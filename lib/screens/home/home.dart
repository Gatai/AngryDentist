import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('home'),
      color: Colors.green,
    );
  }
}

class Buttons extends StatefulWidget {
  @override
  _ButtonsState createState() => _ButtonsState();
}

class _ButtonsState extends State<Buttons> {
  @override
  Widget build(BuildContext context) {
  
  var title =  'Angry Dentist Home Page';

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget> [
          RaisedButton(
            onPressed: () {
            print('Tryckte på flour');
          },
            child: Text('Flour'),
            color: Colors.redAccent,
            textColor: Colors.white,
            padding: EdgeInsets.all(8.0),
            splashColor: Colors.yellowAccent,
            ),

            RaisedButton(
              onPressed: () {
                print('Tryckte på tandtråd');
              },
              child: Text('Tandtråd'), 
                color: Colors.redAccent,
                textColor: Colors.white,
                padding: EdgeInsets.all(8.0),
                splashColor: Colors.yellowAccent,
            ),

            RaisedButton(
              onPressed: () {
                print('Tryckte på borsta tänderna');
              },
              child: Text('Borsta tänderna'), 
                color: Colors.red,
                textColor: Colors.white,
                padding: EdgeInsets.all(8.0),
                splashColor: Colors.yellowAccent,
            ),
       
        ],
      ),
    );
  }
}