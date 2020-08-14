import 'dart:async';

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
                    image: AssetImage('lib/images/website.jpg'))),
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
            leading: Icon(Icons.verified_user),
            title: Text('Profile'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => {Navigator.of(context).pop()},
          ),
        ],
      ),
    );
  }
}
