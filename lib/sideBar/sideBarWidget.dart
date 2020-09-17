import 'package:AngryDentist/widgets/chartsWidget.dart';
import 'package:AngryDentist/widgets/tableCalendarWidget.dart';
import 'package:flutter/material.dart';

class SideBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Side bar menu',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
              color: Colors.teal,
              image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/dog2.png'))
            ),
          ),
          ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text('Calender'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TableCalendarWidget(),
                ),
              ),
            },
          ),
          ListTile(
            leading: Icon(Icons.pie_chart),
            title: Text('Statistik'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChartsWidget(),
                ),
              ),
            },
          ),
          /*
          Till vidare utvecling
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          */
        ],
      ),
    );
  }
}
