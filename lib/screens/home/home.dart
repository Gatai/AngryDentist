import 'package:flutter/material.dart';

//Måste alltid vara med
void main() {
  runApp(Home());
}


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor:  Colors.blueAccent),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Buttons(), // <-- skapar din widget
        ),
      ),
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
    var title = 'Angry Dentist Home Page';

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                print('Tryckte på flour');
              },
              child: Text('Flour'),
              color: Colors.redAccent,
              textColor: Colors.white,
              padding: EdgeInsets.all(10.0),
              splashColor: Colors.yellowAccent,
            ),
            RaisedButton(
              onPressed: () {
                print('Tryckte på tandtråd');
              },
              child: Text('Tandtråd'),
              color: Colors.redAccent,
              textColor: Colors.white,
              padding: EdgeInsets.all(10.0),
              splashColor: Colors.yellowAccent,
            ),
            RaisedButton(
              onPressed: () {
                print('Tryckte på borsta tänderna');
              },
              child: Text('Borsta tänderna'),
              color: Colors.red,
              textColor: Colors.white,
              padding: EdgeInsets.all(10.0),
              splashColor: Colors.yellowAccent,
            ),
          ],
        ),
      ),
    );
  }
}
