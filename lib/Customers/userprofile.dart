
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virque/Customers/userdashboard.dart';
import 'package:virque/api/api.dart';
import 'package:virque/model/users.dart';

import 'editProfile.dart';


class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  var currentUser;
  @override
  void initState() {
    super.initState();
    users();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: new AppBar(
          title: new Text(
            "USER PROFILE",
            style: new TextStyle(color: Colors.white, fontSize: 30, fontFamily: ''),
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
          leading: GestureDetector(
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (BuildContext ctx) => DashBoard()));
            },
            child: Icon(
              Icons.menu,  // add custom icons also
            ),
          ),
        ),
        body: Center(
          child: Column(
                        children: <Widget>[
                          Text(currentUser!=null ? currentUser.name : ""),
                          Text(currentUser!=null ? currentUser.email  : ""),
                          Text(currentUser!=null ? currentUser.fullname  : ""),
                          Text(currentUser!=null ? currentUser.phoneno  : ""),


                          FlatButton(
                            child: Text("Edit", style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: '')),
                            onPressed: () async {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (BuildContext ctx) => EditPage()));
                            },
                          )

                        ],
                      )
                    )
              // By default, show a loading spinner.
        ),
    );
  }

  Future<Users> users() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var id = pref.getString("id");
    final response = await CallApi().getData("users/${id}");
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      Users user;
      var values = json.decode(response.body);
      print(values);
      setState(() {
        currentUser= Users.fromJson(values);
      });
      return user;
    }

    else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load server');
    }
  }
}





