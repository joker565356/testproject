import 'package:flutter/material.dart';
import 'package:testproject/Page/HomePageName.dart';

Widget drawer(BuildContext context, String name) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountName: Text("$name",
              style: TextStyle(fontSize: 18, fontFamily: 'Prompt')),
          accountEmail: Text("Test-Project-Hosting-Cloud Firestore",
              style: TextStyle(fontSize: 18, fontFamily: 'Prompt')),
          decoration: BoxDecoration(
            color: Color(0xff0000b3),
            /*gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Color.fromARGB(255, 0, 153, 255), Color.fromARGB(255, 0, 51, 153)]
            )*/
          ),
        ),
        ListTile(
          leading: Icon(Icons.edit),
          title: Text("Change Name", style: TextStyle(fontFamily: 'Prompt')),
          onTap: () {
            Navigator.push(context,
                new MaterialPageRoute(builder: (context) => HomePageName()));
          },
        ),
        /*ListTile(  
          leading: Icon(Icons.pages),
          title: Text(
            "Log Test",
            style: TextStyle(fontFamily: 'Prompt')
          ),  
          onTap: () {  
            Navigator.push(context, new MaterialPageRoute(builder: (context) => LogTest(null, lang, 1)));
          },  
        ),*/
      ],
    ),
  );
}
