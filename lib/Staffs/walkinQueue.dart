
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:virque/model/counters.dart';
import 'package:virque/model/users.dart';
import 'dart:async';
import 'dart:convert';
import 'file:///C:/Users/Asyraaf/AndroidStudioProjects/virque-master/lib/api/api.dart';
import 'package:virque/request/requirementRequest.dart';
import 'package:shared_preferences/shared_preferences.dart';




class walkinQueuePage extends StatefulWidget {
  @override
  walkinQueuePageState createState() => walkinQueuePageState();
  final String text1;
  // receive data from the FirstScreen as a parameter
  walkinQueuePage({Key key, @required this.text1 }) : super(key: key);
}

// ignore: camel_case_types
class walkinQueuePageState extends State<walkinQueuePage> {
  Future<Counters> futureCounter;

  String countername = 'A2';
  String counterstatus = 'Open';



  var currentUser;
  @override
  void initState() {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text(
            "Walk-in Counter",
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
                                      Text("Counter Name", style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: '')),
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
                                        items: <String>['A2']
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



                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text("Counter Status", style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: '')),
                                      DropdownButton<String>(
                                        value: counterstatus,
                                        iconSize: 24,
                                        elevation: 16,
                                        style: TextStyle(color: Colors.deepPurple),
                                        underline: Container(
                                          height: 2,
                                          color: Colors.deepPurpleAccent,
                                        ),
                                        onChanged: (String Value) {
                                          setState(() {
                                            counterstatus = Value;
                                          });
                                        },
                                        items: <String>['Open', 'Close']
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
                            child: Text("Open Now", style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: '')),
                            onPressed: () async {
                              futureCounter = createCounters(
                                widget.text1,
                                countername,
                                counterstatus,
                                users(),
                              );
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
  Future<Counters> createCounters(String textToSend1 , countername, counterstatus, users) async {


    SharedPreferences pref = await SharedPreferences.getInstance();
    var users = pref.getString("id");
    var data={
      'counter_mode': textToSend1,
      'counter_name' : countername,
      'counter_status' : counterstatus,
      'user_id' : users,
    };
    var response  = await CallApi().postData(data,"counters");
    print(response.statusCode);
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();

      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Successfull"),
      content: Text("You have successfull manage the counter"),
      actions: [
        okButton,
      ],
    );

    AlertDialog alert2 = AlertDialog(
      title: Text("Not Successfull"),
      content: Text("Please fill the form first"),
      actions: [
        okButton,
      ],
    );


    if (response.statusCode == 201) {
      print("workingggg") ;

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );

    } else {
      throw Exception('Failed to create Counter');
    }
  }
}
