
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
        body: Container(
          decoration: new BoxDecoration(
          color: Colors.blue.withOpacity(0.25),

        ),
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Container(
              decoration: new BoxDecoration(
                  color: Colors.grey.withOpacity(0.25),
                  borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(20.0),
                    topRight: const Radius.circular(20.0),
                    bottomLeft: const Radius.circular(20.0),
                    bottomRight: const Radius.circular(20.0),
                  )
              ),
              child: Center(
                child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text("Username:", style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: '')),
                                      Text(currentUser!=null ? currentUser.name : "", textAlign: TextAlign.center,
                                        style: new TextStyle(color: Colors.black, fontSize: 15, fontFamily: ''),
                                      ),
                                    ],
                                  ),
                                ),


                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text("Email:", style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: '')),
                                      Text(currentUser!=null ? currentUser.email  : "", textAlign: TextAlign.center,
                                        style: new TextStyle(color: Colors.black, fontSize: 15, fontFamily: ''),
                                      ),
                                    ],
                                  ),
                                ),


                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text("Fullname:", style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: '')),
                                      Text(currentUser!=null ? currentUser.fullname  : "", textAlign: TextAlign.center,
                                        style: new TextStyle(color: Colors.black, fontSize: 15, fontFamily: ''),
                                      ),
                                    ],
                                  ),
                                ),


                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text("Phone no:", style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: '')),
                                      Text(currentUser!=null ? currentUser.phoneno  : "", textAlign: TextAlign.center,
                                        style: new TextStyle(color: Colors.black, fontSize: 15, fontFamily: ''),
                                      ),
                                    ],
                                  ),
                                ),


                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: new BoxDecoration(
                                        color: Colors.blueGrey.withOpacity(0.25),
                                        borderRadius: new BorderRadius.only(
                                          topLeft: const Radius.circular(10.0),
                                          topRight: const Radius.circular(10.0),
                                          bottomLeft: const Radius.circular(10.0),
                                          bottomRight: const Radius.circular(10.0),
                                        )
                                    ),
                                    child: FlatButton(
                                      child: Text("Edit", style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: '')),
                                      onPressed: () async {
                                        Navigator.pushReplacement(context,
                                            MaterialPageRoute(builder: (BuildContext ctx) => EditPage()));
                                      },
                                    ),
                                  ),
                                )

                              ],
                            )
                          ),
            ),
          ),
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





