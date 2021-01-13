
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:virque/Staffs/walkinQueue.dart';
import 'package:virque/model/users.dart';
import 'dart:async';
import 'dart:convert';
import 'file:///C:/Users/Asyraaf/AndroidStudioProjects/virque-master/lib/api/api.dart';
import 'package:virque/request/requirementRequest.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'homeQueue.dart';

Future<Users> createCounters(String countername, counterstatus, users) async {



  var data={
    'counter_name': countername,
    'counter_status' : counterstatus,
    'user_id' : users,
  };
  var response  = await CallApi().postData(data,"counter");
  print(response.statusCode);


  if (response.statusCode == 201) {
    print("workingggg") ; } else {
    throw Exception('Failed to create User');
  }
}

class manageCounter extends StatefulWidget {
  @override
  manageCounterState createState() => manageCounterState();

}

// ignore: camel_case_types
class manageCounterState extends State<manageCounter> {


  String countername = 'Home Queue';

  void _sendDataToQueuePage(BuildContext context) {


    if(countername == 'Home Queue') {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                homeQueuePage(text1: countername),
          ));
    }
    else if (countername == 'Walk-in Queue') {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                walkinQueuePage(text1: countername),
          ));
    }
  }




  var currentUser;
  @override
  void initState() {
    super.initState();
    users();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text(
            "Manage Counter",
            style: new TextStyle(color: Colors.white, fontSize: 30, fontFamily: ''),
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
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
//


                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          decoration: new BoxDecoration(
                              color: Colors.blue.withOpacity(0.25),
                              borderRadius: new BorderRadius.only(
                                topLeft: const Radius.circular(20.0),
                                topRight: const Radius.circular(20.0),
                                bottomLeft: const Radius.circular(20.0),
                                bottomRight: const Radius.circular(20.0),
                              )
                          ),



                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [

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
                                      Text("Staff Name:", style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: '')),
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
                                      Text("Phone No:", style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: '')),
                                      Text(currentUser!=null ? currentUser.phoneno  : "", textAlign: TextAlign.center,
                                        style: new TextStyle(color: Colors.black, fontSize: 15, fontFamily: ''),
                                      ),
                                    ],
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text("Counter Mode", style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: '')),
                                      DropdownButton<String>(
                                        value: countername,
                                        iconSize: 24,
                                        elevation: 16,
                                        style: TextStyle(color: Colors.deepPurple),
                                        underline: Container(
                                          height: 2,
                                          color: Colors.deepPurpleAccent,
                                        ),
                                        onChanged: (String Value) {
                                          setState(() {
                                            countername = Value;
                                          });
                                        },
                                        items: <String>['Home Queue', 'Walk-in Queue']
                                            .map<DropdownMenuItem<String>>((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),

                                    ],
                                  ),
                                ),


                              ],
                            ),
                          ),
                        ),
                      ),



                      Padding(
                        padding: const EdgeInsets.all(10.0),
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
                            child: Text("Next", style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: '')),
                            onPressed: () async {
                              _sendDataToQueuePage(context);
                            },
                          ),
                        ),
                      ),

                    ],
                  )
              ),
            ),
          ),
        )
      // By default, show a loading spinner.
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
