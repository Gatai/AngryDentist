import 'package:AngryDentist/models/user.dart';
import 'package:AngryDentist/utilities/activities.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ButtonsWidget extends StatefulWidget {
  @override
  _ButtonsWidgetState createState() => _ButtonsWidgetState();
}

class _ButtonsWidgetState extends State<ButtonsWidget> {
  @override
  Widget build(BuildContext context) {
   
     var currentUser = Provider.of<User>(context);

    return Container(
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              print('Tryckte på flour');
              //Anropar metod i classen Activities för att spara information (behövs inte en egen class för det, men koden blir snyggare så)
              new Activities().saveActivity("Flour", currentUser.uid);
            },
            child: Text(
              'Flour',
              style: new TextStyle(fontSize: 12.0),
            ),
            color: Colors.redAccent,
            textColor: Colors.white,
            padding: EdgeInsets.all(10.0),
            splashColor: Colors.yellowAccent,
          ),
          RaisedButton(
            onPressed: () {
              print('Tryckte på tandtråd');
              new Activities().saveActivity("Tandtråd", currentUser.uid);
            },
            child: Text(
              'Tandtråd',
              style: new TextStyle(fontSize: 12.0),
            ),
            color: Colors.redAccent,
            textColor: Colors.white,
            padding: EdgeInsets.all(10.0),
            splashColor: Colors.yellowAccent,
          ),
          RaisedButton(
            onPressed: () {
              print('Tryckte på borsta tänderna');
              new Activities()
                  .saveActivity("Borstat tänderna", currentUser.uid);
            },
            child: Text(
              'Borsta tänderna',
              style: new TextStyle(fontSize: 12.0),
            ),
            color: Colors.red,
            textColor: Colors.white,
            padding: EdgeInsets.all(10.0),
            splashColor: Colors.yellowAccent,
          ),
        ],
      ),
    );
  }
}
